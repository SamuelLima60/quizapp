import 'package:flutter/material.dart';
import 'package:quiz/models/quiz_model.dart';
import 'package:quiz/view/result_view.dart';
import 'package:quiz/widgets/quiz_button_widget.dart';

import '../controller/quiz_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  QuizModel? value;
  int pressedButtonIndex = 1;
  int numberQuestion = 0;
  int correctQuestion = 0;
  List<Color?> colorSend = List.filled(4, null);

  Future<void> nextQuestion(int i) async {
    await Future.delayed(const Duration(milliseconds: 10000));
    colorSend[i] = Colors.white;
  }

  void onTapButton(int i, QuizModel? snapshotData) async {
    setState(() {
      if (numberQuestion < 10) {
        numberQuestion++;
      }

      if (snapshotData?.answers[i] == snapshotData?.correctAnswer) {
        correctQuestion++;
      }

      for (int j = 0; j < colorSend.length; j++) {
        if (j != i) {
          colorSend[j] = Colors.white;
        }
      }

      if (numberQuestion == 10) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                ResultView(correctQuestion: correctQuestion),
          ),
        );
      }

      colorSend[i] = Colors.green;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: QuizController().getQuiz(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            colorSend = List.filled(4, null);
          }

          return Scaffold(
              body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Quiz',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 55,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(child: Text('$numberQuestion/10')),
                ),
                const SizedBox(height: 10),
                Text(
                  snapshot.data?.question ?? 'Carregando..',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 9),
                  child: Divider(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Choose an question',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (ctx, i) {
                      pressedButtonIndex = i;
                      return Column(
                        children: [
                          const SizedBox(height: 15),
                          InkWell(
                            onTap: () {
                              onTapButton(i, snapshot.data);
                            },
                            child: QuizButtonWidget(
                              answer:
                                  snapshot.data?.answers[i] ?? 'Carregando..',
                              colorRecv: colorSend[i],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ));
        });
  }
}
