import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField(
      {Key? key,
      this.hintText,
      this.prefixIcon,
      this.obscureText,
      this.textInputType,
      this.textInputAction,
      this.suffixIcon,
      this.validator,
      this.onChanged,
      this.controller})
      : super(key: key);

  final String? hintText;
  final Icon? prefixIcon;
  final TextInputType? textInputType;
  final bool? obscureText;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width / 1.2,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        validator: validator,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        obscureText: obscureText ?? false,
        cursorColor: Color(0xfffeeeee4),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15),
          errorMaxLines: 2,
          filled: true,
          fillColor: Color(0xfffeeeee4),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
