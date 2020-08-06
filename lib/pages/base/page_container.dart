import 'package:dekornata_submission_test/models/product.dart';
import 'package:dekornata_submission_test/utils/product_seeds.dart';
import 'package:dekornata_submission_test/utils/theme_style.dart';
import 'package:flutter/material.dart';

import '../add_product_page.dart';
import '../cart_page.dart';
import '../catalog_page.dart';
import '../detail_product_page.dart';
import '../user_settings_page.dart';
import 'menu_drawer.dart';
import 'page_background_image.dart';
import 'page_base.dart';

class PageContainer extends PageContainerBase {
  final PageType pageType;
  PageContainer({Key key, @required this.pageType})
  : super(key: key);

  @override
  Widget get menuDrawer => AppMenu();

  @override
  String get pageTitle {
    switch (pageType) {
      case PageType.Cart:
        return "My Cart";
      case PageType.Settings:
        return "My Settings";
        break;
      case PageType.AddProductForm:
        return "Add Product";
      case PageType.Catalog:
      default:
        return "Craftsman Workshop";
    }
  }

  @override
  Widget get body {
    var page;
    switch (pageType) {
      case PageType.Cart:
      page = CartPage();
      break;
      case PageType.Settings:
      page = UserSettingsPage();
      break;
      case PageType.Catalog:
      default:
      page = CatalogPage();
    }
    return Padding(
      padding: EdgeInsets.all(Spacing.matGridUnit()),
      child: page,
    );
  }

  @override
  Widget get background => Container();

  @override
  Color get backgroundColor => AppColors.background;
}

class ProductDetailPageContainer extends PageContainerBase {
  final Product product;
  ProductDetailPageContainer({@required this.product});

  @override
  Widget get body => ProductDetailPage(product: product);

  @override
  String get pageTitle => "";

  @override
  Widget get menuDrawer => null;

  @override
  Widget get background => BackgroundImage(
    key: PageStorageKey(product),
    imageTitle: _getImageForCategory,
  );

  ImageTitle get _getImageForCategory => categoriesToImageMap[product.category];

  @override
  Color get backgroundColor => Colors.transparent;
}

class AddNewProductPageContainer extends PageContainerBase {
  @override
  Widget get body => AddProductForm();

  @override
  String get pageTitle => "Add Product";

  @override
  Widget get menuDrawer => null;

  @override
  Widget get background => Container();

  @override
  Color get backgroundColor => Colors.transparent;
}