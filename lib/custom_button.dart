import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color borderColor;
  final TextStyle textStyle;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.borderColor = Colors.blue,
    this.textStyle = const TextStyle(color: Colors.white, fontSize: 14),
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        padding: const EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 12.0),
        backgroundColor: const Color.fromRGBO(0, 0, 128, 0.8),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        side: const BorderSide(
          width: 5.0,
          color: Colors.lightBlueAccent,
          style: BorderStyle.solid,
        ),
        elevation: 4.0,
        shadowColor: Colors.brown.shade400,
        textStyle: TextStyle(
          fontFamily: 'meera',
          fontWeight: FontWeight.bold,
          fontSize: 11.sp,
          color: Colors.white,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        label,
      ),
    );
  }
}
