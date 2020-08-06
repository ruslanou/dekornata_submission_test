import 'package:dekornata_submission_test/models/product.dart';
import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final ImageTitle imageTitle;

  const BackgroundImage({Key key, this.imageTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .7,
      child: ClipPath(
        clipper: BackgroundImageClipper(),
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
            alignment: Alignment.topCenter,
            fit: BoxFit.fitWidth,
            image: AssetImage("assets/images/dekornata-logo.jpg"),
          )),
        ),
      ),
    );
  }
}

class BackgroundImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, size.height);
    path.lineTo(size.width - 150.0, size.height);
    path.lineTo(size.width, size.height - 150.0);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}