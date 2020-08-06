import 'package:dekornata_submission_test/services/cart_service.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'blocs/app_state.dart';
import 'blocs/cart_bloc.dart';
import 'blocs/catalog_bloc.dart';
import 'blocs/user_bloc.dart';
import 'services/catalog_service.dart';
import 'services/user_service.dart';
import 'storage/mock_store.dart';

Future<void> main() async {
  var store = AppStore();
  var catalogService = CatalogServiceTemporary(store);
  var cartService = CartServiceTemporary(store);
  var userService = MockUserService(store);

  var blocProvider = BlocProvider(
    cartBloc: CartBloc(cartService),
    catalogBloc: CatalogBloc(catalogService),
    userBloc: UserBloc(userService),
  );
  runApp(
    AppStateContainer(
      blocProvider: blocProvider,
      child: MyApp(),
    ),
  );
}