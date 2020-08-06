import 'package:dekornata_submission_test/blocs/app_state.dart';
import 'package:dekornata_submission_test/blocs/user_bloc.dart';
import 'package:dekornata_submission_test/models/user.dart';
import 'package:dekornata_submission_test/utils/dekornata_routes.dart';
import 'package:flutter/material.dart';

import '../../app.dart';

class AppMenu extends StatefulWidget {
  @override
  AppMenuState createState() => AppMenuState();
}

class AppMenuState extends State<AppMenu> with RouteAware {
  String _activeRoute;
  UserBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
    _bloc = AppStateContainer.of(context).blocProvider.userBloc;
  }

  @override
  void didPush() {
    _activeRoute = ModalRoute.of(context).settings.name;
  }

  Future _navigate(String route) async {
    await Navigator.popAndPushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    _activeRoute ??= "/";

    return Drawer(
      child: ListView(
        children: <Widget>[
          StreamBuilder(
            initialData: ECommerceUser(name: "", contact: ""),
            stream: _bloc.user,
            builder: (BuildContext context, AsyncSnapshot<ECommerceUser> s) =>
                UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/images/dekornata-logo.jpg"),
                  ),
                  accountEmail: Text(s.data.contact),
                  accountName: Text(s.data.name),
                  onDetailsPressed: () {
                    Navigator.pushReplacementNamed(
                        context, DekornataRoutes.userSettingsPage);
                  },
                ),
          ),
          ListTile(
            leading: Icon(Icons.apps),
            title: Text("Catalog"),
            selected: _activeRoute == DekornataRoutes.catalogPage,
            onTap: () => _navigate(DekornataRoutes.catalogPage),
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text("Cart"),
            selected: _activeRoute == DekornataRoutes.cartPage,
            onTap: () => _navigate(DekornataRoutes.cartPage),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("User Settings"),
            selected: _activeRoute == DekornataRoutes.userSettingsPage,
            onTap: () => _navigate(DekornataRoutes.userSettingsPage),
          ),
        ],
      ),
    );
  }
}