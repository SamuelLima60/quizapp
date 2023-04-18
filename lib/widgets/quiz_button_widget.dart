import 'package:flutter/material.dart';

class QuizButtonWidget extends StatelessWidget {
  final String answer;
  final Color? colorRecv;
  const QuizButtonWidget(
      {super.key, required this.answer, required this.colorRecv});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        color: colorRecv,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(child: Text(answer)),
    );
  }
}
