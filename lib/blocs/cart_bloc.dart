import 'dart:async';

import 'package:dekornata_submission_test/models/product.dart';
import 'package:dekornata_submission_test/services/cart_service.dart';
import 'package:rxdart/rxdart.dart';

class CartBloc {
  final CartService _service;

  StreamController<AddToCartEvent> addProductSink = StreamController<AddToCartEvent>();
  StreamController<RemoveFromCartEvent> removeFromCartSink = StreamController<RemoveFromCartEvent>();

  Stream<Map<String,int>> get cartItems => _cartItemStreamController.stream;
  StreamController _cartItemStreamController = BehaviorSubject<Map<String,int>>(seedValue: {});

  Stream<int> get cartItemCount => _cartItemCountStreamController.stream;
  StreamController _cartItemCountStreamController = BehaviorSubject<int>(seedValue: 0);

  CartBloc(this._service) {
    addProductSink.stream.listen((_handleAddItemsToCart));
    removeFromCartSink.stream.listen((_handleRemoveCartItem));

    _service.streamCartCount().listen((int count) {
      _cartItemCountStreamController.add(count);
    });
    _service
    .streamCartItems()
    .listen((Map<String,int> data) => _cartItemStreamController.add(data));
  }

  void _handleAddItemsToCart(AddToCartEvent event) {
    _service.addToCart(event.product, event.qty);
  }

  void _handleRemoveCartItem(RemoveFromCartEvent event) {
    _service.removeFromCart(event.productTitle, event.qtyInCart);
  }

  close() {
    addProductSink.close();
    removeFromCartSink.close();
    _cartItemCountStreamController.close();
    _cartItemStreamController.close();
  }
}

class AddToCartEvent {
  final Product product;
  final int qty;
  AddToCartEvent(this.product, this.qty);
}

class RemoveFromCartEvent {
  final String productTitle;
  final int qtyInCart;
  RemoveFromCartEvent(this.productTitle, this.qtyInCart);
}