import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomButton({Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered))
                return Colors.deepPurple.withOpacity(0.04);
              if (states.contains(MaterialState.focused) ||
                  states.contains(MaterialState.pressed))
                return Colors.deepPurple.withOpacity(0.12);
              return null; // Defer to the widget's default.
            },
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.purple.shade100),
          minimumSize: MaterialStateProperty.all(Size(300, 50))
        ),
        onPressed: onPressed,
        child: Text(text, style: TextStyle(fontSize: 18),),
      ),
    );
  }
}
