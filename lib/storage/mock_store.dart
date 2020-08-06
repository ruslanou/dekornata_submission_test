import 'dart:async';

import 'package:dekornata_submission_test/models/cart.dart';
import 'package:dekornata_submission_test/models/catalog.dart';
import 'package:dekornata_submission_test/models/user.dart';
import 'package:dekornata_submission_test/utils/generate_cart_data.dart';

class AppStore {
  Cart _cart;
  Catalog _catalog;
  ECommerceUser _user;

  StreamController<Cart> cartNotifier = StreamController<Cart>.broadcast();
  StreamController<Catalog> catalogNotifier = StreamController<Catalog>.broadcast();
  StreamController<ECommerceUser> userNotifier = StreamController<ECommerceUser>.broadcast();

  AppStore() {
    _cart = buildInitialCart();
    _catalog = populateCatalog();
    _user = ECommerceUser(name: "Ahmad Ruslan", contact: "aruslan8395@gmail.com", userProducts: []);

    Future.delayed(Duration(milliseconds: 500), () {
      catalogNotifier.add(_catalog);
      cartNotifier.add(_cart);
      userNotifier.add(_user);
    });
  }

  Cart get cart => _cart;

  set cart(Cart c) {
    _cart = c;
    cartNotifier.add(c);
  }

  Catalog get catalog => _catalog;

  set catalog(Catalog c) {
    _catalog = c;
    catalogNotifier.add(c);
  }

  ECommerceUser get user => _user;

  set user(ECommerceUser c) {
    _user = c;
    userNotifier.add(c);
  }
}