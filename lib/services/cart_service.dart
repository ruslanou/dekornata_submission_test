import 'package:dekornata_submission_test/models/product.dart';
import 'package:dekornata_submission_test/storage/mock_store.dart';

abstract class CartService {
  Stream<int> streamCartCount();
  Stream<Map<String,int>> streamCartItems();
  Future addToCart(Product product, int qty);
  Future<void> removeFromCart(String p, int qty);
}

class CartServiceTemporary implements CartService {
  final AppStore store;
  CartServiceTemporary(this.store);

  @override
  Future addToCart(Product product, int qty) async {
    var newTotalCount = store.cart.totalCartItems + qty;
    var newProductTotalCount = _currentCountForProduct(product) + qty;
    store.cart.totalCartItems = newTotalCount;
    store.cart.items[product.title] = newProductTotalCount;
    store.cart = store.cart;
  }

  @override
  Stream<int> streamCartCount() {
    return store.cartNotifier.stream.map((_) => store.cart.totalCartItems);
  }

  @override
  Future removeFromCart(String product, int qty) async {
    var newTotalCount = store.cart.totalCartItems - qty;
    store.cart.totalCartItems = newTotalCount;
    store.cart.items.remove(product);
    store.cart = store.cart;
  }

  @override
  Stream<Map<String,int>> streamCartItems() {
    return store.cartNotifier.stream.map((_) => store.cart.items);
  }

  int _currentCountForProduct(Product product) {
    if (!store.cart.items.containsKey(product.title)) return 0;
    return store.cart.items[product.title];
  }
}