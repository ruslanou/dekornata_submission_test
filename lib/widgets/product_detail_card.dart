import 'package:dekornata_submission_test/models/product.dart';
import 'package:dekornata_submission_test/utils/theme_style.dart';
import 'package:flutter/material.dart';

class ProductDetailCard extends StatelessWidget {
  final Product product;
  final GestureTapCallback onTap;
  final GestureLongPressCallback onLongPress;

  const ProductDetailCard({Key key, this.product, this.onTap, this.onLongPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _radius = BorderRadius.circular(10.0);

    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: _radius),
      child: GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        child: RepaintBoundary(
          child: Hero(
            tag: product.uniqueId,
            child: Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                borderRadius: _radius,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(product.imageUrl),
                ),
              ),
              child: Container(
                constraints: BoxConstraints.expand(
                  height: Spacing.matGridUnit(scale: 5),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                ),
                padding: EdgeInsets.all(
                  Spacing.matGridUnit(scale: .5),
                ),
                child: Center(
                  child: Text(product.title, style: Theme.of(context).primaryTextTheme.subtitle1),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}