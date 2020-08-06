import 'dart:async';

import 'package:dekornata_submission_test/models/add_product.dart';
import 'package:dekornata_submission_test/models/product.dart';
import 'package:dekornata_submission_test/services/catalog_service.dart';
import 'package:dekornata_submission_test/utils/generate_cart_data.dart';
import 'package:rxdart/rxdart.dart';

class CatalogBloc {
  final CatalogService _service;

  StreamController _productStreamController = BehaviorSubject<List<Product>>(seedValue: populateCatalog().availableProducts);
  Stream<List<Product>> get allProducts => _productStreamController.stream;

  List<StreamController<List<Product>>> _controllersByCategory = [];
  List<Stream<List<Product>>> productStreamsByCategory = [];

  final _productInputController = StreamController<ProductEvent>.broadcast();
  Sink<ProductEvent> get addNewProduct => _productInputController.sink;
  Sink<ProductEvent> get updateProduct => _productInputController.sink;

  CatalogBloc(this._service) {
    _productInputController.stream
        .where((ProductEvent event) => event is UpdateProductEvent)
        .listen(_handleProductUpdate);
    _productInputController.stream
        .where((ProductEvent event) => event is AddProductEvent)
        .listen(_handleAddProduct);
    _service.streamProducts().listen((List<Product> data) {
      _productStreamController.add(data);
    });

    ProductCategory.values.forEach((ProductCategory category) {
      var _controller = BehaviorSubject<List<Product>>();
      _service.streamProductCategory(category).listen((List<Product> data) {
        return _controller.add(data);
      });
      return _controllersByCategory.add(_controller);
    });

    _controllersByCategory.forEach((StreamController<List<Product>> controller) {
      productStreamsByCategory.add(controller.stream);
    });
  }

    _handleProductUpdate(ProductEvent event) {
    _service.addNewProduct(
      Product(
        title: event.product.title,
        category: event.product.category,
        cost: event.product.cost,
        imageTitle: ImageTitle.AiraTray,
      ),
    );
  }

  _handleAddProduct(ProductEvent event) {
    _service.addNewProduct(
      Product(
        category: event.product.category,
        title: event.product.title,
        cost: event.product.cost,
        imageTitle: ImageTitle.AiraTray,
      ),
    );
  }

  void close() {
    _productStreamController.close();
    _productInputController.close();
    _controllersByCategory.forEach((controller) => controller.close());
  }
}