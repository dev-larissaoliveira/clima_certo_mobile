import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {Key? key,
      this.press,
      this.textColor = Colors.white,
      required this.text,
      this.fontSize})
      : super(key: key);
  final String text;
  final Function()? press;
  final Color? textColor;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: newElevatedButton(),
      ),
    );
  }

  Widget newElevatedButton() {
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: fontSize ?? 15),
      ),
      onPressed: press,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF3F51B5),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        textStyle: TextStyle(
          letterSpacing: 2,
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
