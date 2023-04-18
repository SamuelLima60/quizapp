import 'package:flutter/material.dart';
import 'package:quiz/view/home_view.dart';

class ResultView extends StatelessWidget {
  final int? correctQuestion;
  const ResultView({super.key, this.correctQuestion = 0});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$correctQuestion/10',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'RESULT',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const HomeView(),
                  ),
                );
              },
              child: const Text('restart'),
            ),
          ],
        ),
      ),
    );
  }
}
