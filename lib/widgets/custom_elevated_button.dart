import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CustomElevatedButton extends StatefulWidget {
  final void Function()? onPressed;
  final bool isLoading;
  final String text;
  const CustomElevatedButton(
      {super.key, this.onPressed, required this.isLoading, required this.text});

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(300, 60),
        backgroundColor: bezowy,
        side: const BorderSide(color: Colors.black),
      ),
      onPressed: widget.onPressed,
      child: widget.isLoading
          ? const SizedBox(
              width: 300,
              height: 60,
              child: Center(
                child: CircularProgressIndicator(color: Colors.black),
              ),
            )
          : Row(
              children: [
                const Spacer(),
                Text(
                  widget.text,
                  style: const TextStyle(
                      color: Colors.black, fontSize: 22, fontFamily: 'Oswald'),
                ),
                const Spacer(),
              ],
            ),
    );
  }
}
