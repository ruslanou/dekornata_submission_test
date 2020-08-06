import 'package:dekornata_submission_test/blocs/app_state.dart';
import 'package:dekornata_submission_test/models/user.dart';
import 'package:dekornata_submission_test/utils/route_transition.dart';
import 'package:dekornata_submission_test/utils/theme_style.dart';
import 'package:dekornata_submission_test/widgets/sliver_header.dart';
import 'package:dekornata_submission_test/widgets/user_form.dart';
import 'package:flutter/material.dart';

import 'base/page_container.dart';

class UserSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _bloc = AppStateContainer.of(context).blocProvider.userBloc;
    return Stack(
      children: <Widget>[
        CustomScrollView(
          slivers: <Widget>[
            CustomSliverHeader(
              headerText: 'Profile',
            ),
            SliverToBoxAdapter(
              child: UserProfileForm(),
            ),
            CustomSliverHeader(
              headerText: 'My Products',
            ),
            StreamBuilder<ECommerceUser>(
              stream: _bloc.user,
              initialData: ECommerceUser(userProducts: []),
              builder: (context, snapshot) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    var _product = snapshot.data.userProducts[index];
                    return Container(
                      decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: .5, color: Colors.black54),
                          ),
                        ),
                        child: Dismissible(
                          direction: DismissDirection.endToStart,
                          background: Container(color: Colors.red[300]),
                          key: Key(_product.toString()),
                          child: Container(
                            child: ListTile(
                              title: Text(_product.title),
                            ),
                          ),
                          onDismissed: (DismissDirection dir) {
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: AppColors.primary,
                                content: Text(
                                  "${_product.title} deleted.",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(color: AppColors.accentTextColor),
                                ),
                              ),
                            );
                          }
                        )
                    );
                  },
                  childCount: snapshot.data.userProducts.length,
                  ),
                );
              },
            )
          ],
        ),
        Positioned(
          bottom: Spacing.matGridUnit(),
          right: Spacing.matGridUnit(),
          child: FloatingActionButton.extended(
              icon: Icon(Icons.add),
              label: Text("New Product"),
              onPressed: () {
                Navigator.push(
                  context,
                  FadeInSlideOutRoute(
                    builder: (context) => AddNewProductPageContainer(),
                  ),
                );
              }),
        ),
      ],
    );
  }
}