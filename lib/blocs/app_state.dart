import 'package:dekornata_submission_test/services/cart_service.dart';
import 'package:dekornata_submission_test/services/catalog_service.dart';
import 'package:flutter/material.dart';

import 'cart_bloc.dart';
import 'catalog_bloc.dart';
import 'user_bloc.dart';

class AppStateContainer extends StatefulWidget {
  final Widget child;
  final BlocProvider blocProvider;
  const AppStateContainer({
    Key key,
    @required this.child,
    @required this.blocProvider,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => AppState();

  static AppState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_AppStoreContainer>().appData;
  }
}

class AppState extends State<AppStateContainer> {
  BlocProvider get blocProvider => widget.blocProvider;

  @override
  Widget build(BuildContext context) {
    return _AppStoreContainer(
      appData: this,
      blocProvider: widget.blocProvider,
      child: widget.child,
    );
  }

  void dispose() {
    super.dispose();
  }

  int cartCount = 0;
  void updateCartTotal(int count) {
    setState(() => cartCount += count);
  }
}

class _AppStoreContainer extends InheritedWidget {
  final AppState appData;
  final BlocProvider blocProvider;

  _AppStoreContainer({
    Key key,
    @required this.appData,
    @required child,
    @required this.blocProvider,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_AppStoreContainer oldWidget) => oldWidget.appData != this.appData;
}

class ServiceProvider {
  final CatalogService catalogService;
  final CartService cartService;

  ServiceProvider({
    @required this.catalogService,
    @required this.cartService,
  });
}

class BlocProvider {
  CartBloc cartBloc;
  CatalogBloc catalogBloc;
  UserBloc userBloc;

  BlocProvider({
    @required this.cartBloc,
    @required this.catalogBloc,
    @required this.userBloc,
  });
}
