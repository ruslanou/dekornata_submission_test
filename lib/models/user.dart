import 'package:dekornata_submission_test/models/product.dart';

class ECommerceUser {
  final String name;
  final String contact;
  List<Product> userProducts = [];

  ECommerceUser({
    this.name,
    this.contact,
    this.userProducts,
  });
}
