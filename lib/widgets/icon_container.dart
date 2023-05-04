import 'package:flutter/material.dart';

import '../screens_for_single_player/end_of_round_single.dart';
import '../screens_for_single_player/question2_single_screen.dart';
import '../utils/colors.dart';

class IconContainer extends StatefulWidget {
  final IconData icon;
  bool isSelected;
  IconContainer({
    super.key,
    required this.icon,
    required this.isSelected,
  });

  @override
  State<IconContainer> createState() => _IconContainerState();
}

class _IconContainerState extends State<IconContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHighlightChanged: (value) {
        if (value) {
          setState(() {
            widget.isSelected = true;
          });
        } else {
          setState(() {
            widget.isSelected = false;
          });
        }
      },
      onTap: () {
        if (widget.icon == Icons.done) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const Question2Single(),
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const EndOfRoundSingle(),
            ),
          );
        }
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: widget.isSelected ? Colors.black : bezowy,
          shape: BoxShape.circle,
          border: Border.all(style: BorderStyle.solid, color: Colors.black),
        ),
        child: Icon(widget.icon,
            size: 80, color: widget.isSelected ? Colors.white : Colors.black),
      ),
    );
  }
}
