import 'package:dekornata_submission_test/blocs/app_state.dart';
import 'package:dekornata_submission_test/utils/dekornata_routes.dart';
import 'package:dekornata_submission_test/utils/theme_style.dart';
import 'package:flutter/material.dart';

class AppBarCartIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _bloc = AppStateContainer.of(context).blocProvider.cartBloc;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          Container(
            child: CustomPaint(
              painter: AppBarIconBackground(),
            ),
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            color: AppColors.textColor,
            onPressed: () {
              Navigator.of(context).pushNamed(DekornataRoutes.cartPage);
            },
          ),
          Positioned(
            top: 4.0,
            right: 4.0,
            child: Container(
              alignment: Alignment.center,
              width: 16.0,
              height: 16.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              child: StreamBuilder(
                initialData: 0,
                stream: _bloc.cartItemCount,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return Text(
                    snapshot.data.toString(),
                    style: TextStyle(fontSize: 8.0, color: Colors.white,),
                    textAlign: TextAlign.center,
                  );
                }
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AppBarIconBackground extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var _paintBrush = Paint()..color = Colors.white;
    var right = size.width;
    var shadowPath = Path();
    shadowPath.moveTo(right + 90, 40);
    shadowPath.lineTo(right + 10, 40);
    shadowPath.arcToPoint(Offset(right + 20, 0), radius: Radius.circular(20));
    shadowPath.lineTo(right + 90, 0);
    shadowPath.close();

    canvas.drawShadow(shadowPath, Colors.black54, 3, false);
    var rightBase = Rect.fromLTWH(right + 20, 0.0, 70.0, 40.0);
    canvas.drawRect(rightBase, _paintBrush);
    canvas.drawCircle(Offset(right + 18, 20.0), 20.0, _paintBrush);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}