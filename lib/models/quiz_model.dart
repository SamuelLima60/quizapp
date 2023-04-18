class QuizModel {
  final String id;
  final String category;
  final String question;
  final String correctAnswer;
  final List<dynamic> answers;

  QuizModel({
    required this.id,
    required this.question,
    required this.correctAnswer,
    required this.category,
    required this.answers,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    json['incorrectAnswers'].add(json['correctAnswer']);

    json['incorrectAnswers'].shuffle();
    return QuizModel(
      id: json['id'],
      question: json['question'],
      correctAnswer: json['correctAnswer'],
      category: json['category'],
      answers: json['incorrectAnswers'],
    );
  }
}
