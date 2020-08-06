import 'package:dekornata_submission_test/models/cart.dart';
import 'package:dekornata_submission_test/models/catalog.dart';
import 'package:dekornata_submission_test/models/product.dart';
import 'package:dekornata_submission_test/utils/product_seeds.dart';

ProductCategory getCategoryForProduct(String productName) =>
    categorizeProduct.entries
        .firstWhere((MapEntry<ProductCategory, List<String>> entry) =>
            entry.value.contains(productName))
        .key;


Product createProduct(String productName, double price) {
  return Product(
    title: productName,
    imageTitle: availableProductsToImage[productName],
    category: getCategoryForProduct(productName),
    cost: availableProductToPrice[productName],
  );
}

Catalog populateCatalog() {
  var catalog = Catalog();
  availableProductToPrice.forEach((String productName, double price) { 
    catalog.availableProducts.add(createProduct(productName, price));
  });
  return catalog;
}



Cart buildInitialCart() {
  return Cart()
  ..items = {}
  ..totalCartItems = 0
  ..totalCost = 0.00;
}