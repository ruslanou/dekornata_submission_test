import 'package:dekornata_submission_test/utils/theme_style.dart';
import 'package:flutter/material.dart';

class FormFieldContainer extends StatelessWidget {
  final Widget child;

  FormFieldContainer({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: Spacing.matGridUnit(scale: 2)),
      child: child,
    );
  }
}