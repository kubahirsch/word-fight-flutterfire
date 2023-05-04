import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../utils/colors.dart';

class CustomPercentIndicator extends StatefulWidget {
  final int animationDuration;
  const CustomPercentIndicator({super.key, required this.animationDuration});

  @override
  State<CustomPercentIndicator> createState() => _CustomPercentIndicatorState();
}

class _CustomPercentIndicatorState extends State<CustomPercentIndicator> {
  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      percent: 1,
      animation: true,
      animationDuration: widget.animationDuration,
      lineHeight: 33,
      backgroundColor: Colors.white,
      progressColor: Color.fromARGB(255, 63, 63, 63),
      barRadius: const Radius.circular(10),
    );
  }
}
