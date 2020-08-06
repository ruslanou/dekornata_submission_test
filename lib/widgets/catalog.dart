import 'package:dekornata_submission_test/blocs/app_state.dart';
import 'package:dekornata_submission_test/blocs/cart_bloc.dart';
import 'package:dekornata_submission_test/blocs/catalog_bloc.dart';
import 'package:dekornata_submission_test/models/product.dart';
import 'package:dekornata_submission_test/pages/base/page_container.dart';
import 'package:dekornata_submission_test/utils/route_transition.dart';
import 'package:dekornata_submission_test/widgets/sliver_header.dart';
import 'package:flutter/material.dart';

import 'add_tocart_bottomsheet.dart';
import 'humanize.dart';
import 'product_detail_card.dart';

class Catalog extends StatefulWidget {
  @override
  _CatalogState createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  CatalogBloc _bloc;
  List<Widget> slivers = [];
  bool loading = true;

  void didChangeDependencies() {
    super.didChangeDependencies();
    slivers = [];
    _bloc = AppStateContainer.of(context).blocProvider.catalogBloc;
  }

  Future _toProductDetailPage(Product product) async {
    await Navigator.push(
      context,
      FadeInSlideOutRoute(
        builder: (context) => ProductDetailPageContainer(
          product: product,
        )
      )
    );
  }

  void _showQuickAddToCart(BuildContext context, Product product) async {
    var _cartBloc = AppStateContainer.of(context).blocProvider.cartBloc;

    int qty = await showModalBottomSheet<int>(
        context: context,
        builder: (BuildContext context) {
          return AddToCartBottomSheet(
            key: Key(product.id),
          );
        });

    _addToCart(product, qty, _cartBloc);
  }

  void _addToCart(Product product, int quantity, CartBloc _bloc) {
    _bloc.addProductSink.add(AddToCartEvent(product, quantity));
  }

  List<Widget> _buildSlivers(BuildContext context) {
    if (slivers.isNotEmpty && slivers != null) {
      return slivers;
    }
    _bloc.productStreamsByCategory.forEach((Stream<List<Product>> dataStream) {
      slivers.add(StreamBuilder(
          stream: dataStream,
          builder: (context, AsyncSnapshot<List<Product>> snapshot) {
            return CustomSliverHeader(
              onTap: (String text) => print(text),
              headerText:
                  Humanize.productCategoryFromEnum(snapshot?.data?.first?.category) ?? "header",
            );
          }));
      slivers.add(StreamBuilder(
          stream: dataStream,
          builder: (context, AsyncSnapshot<List<Product>> snapshot) {
            return SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  var _product = snapshot.data[index];
                  return ProductDetailCard(
                    key: ValueKey(_product.imageTitle.toString()),
                    onTap: () => _toProductDetailPage(_product),
                    onLongPress: () => _showQuickAddToCart(context, _product),
                    product: _product,
                  );
                },
                childCount: snapshot.data?.length ?? 0,
              ),
            );
          }));
    });
    return slivers;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: _buildSlivers(context),
      physics: BouncingScrollPhysics(),
    );
  }
}