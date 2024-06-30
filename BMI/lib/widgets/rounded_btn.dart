import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String btnname;
  final Icon? icon;
  final Color? bgColor;
  final TextStyle? textStyle;
  final VoidCallback? callBack;

  RoundedButton(
      {required this.btnname,
      this.icon,
      this.bgColor = Colors.blue,
      this.textStyle,
      this.callBack});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          callBack!();
        },
        child: icon != null ?
        Row(
          children: [
            icon!,
            Text(
              btnname,
              style: textStyle,
            )
          ],
        ) : Text(
                btnname,
                style: textStyle,
              ),
      style: ElevatedButton.styleFrom(
        foregroundColor: bgColor,
        shadowColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(21),
            bottomLeft: Radius.circular(21)
          )
        )
      ),
    );
  }
}
