import 'package:dekornata_submission_test/models/product.dart';

class Humanize {
  static String productCategoryFromEnum(ProductCategory c) {
    return c.toString().split(".").last;
  }
}
