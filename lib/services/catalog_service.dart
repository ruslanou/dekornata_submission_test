import 'package:dekornata_submission_test/models/product.dart';
import 'package:dekornata_submission_test/storage/mock_store.dart';

abstract class CatalogService {
  Stream<List<Product>> streamProducts();
  Stream<List<Product>> streamProductCategory(ProductCategory productCategory);
  Future<void> addNewProduct(Product product);
  Future<void> updateProduct(Product product);
}

class CatalogServiceTemporary implements CatalogService {
  final AppStore store;

  CatalogServiceTemporary(this.store);

  @override
  Future addNewProduct(Product product) async {
    store.catalog.availableProducts.add(product);
  }

  @override
  Stream<List<Product>> streamProductCategory(ProductCategory productCategory) {
    return store.catalogNotifier.stream.map((data) => 
    store.catalog.availableProducts.where((Product product) => product.category == productCategory).toList());
  }

  @override
  Stream<List<Product>> streamProducts() {
    return store.catalogNotifier.stream.map((_) => 
    store.catalog.availableProducts);
  }

  @override
  Future updateProduct(Product product) async {
    var originalProduct = store.catalog.availableProducts.firstWhere((Product product) => product.title == product.title);
    store.catalog.availableProducts.remove(originalProduct);
    store.catalog.availableProducts.add(product);
  }
}