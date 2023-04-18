import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/quiz_model.dart';

class ApiService {
  final http.Client httpClient;

  ApiService({required this.httpClient});

  Future<QuizModel> getQuiz() async {
    final response = await httpClient
        .get(Uri.parse('https://the-trivia-api.com/api/questions/'));

    if (response.statusCode == 200) {
      return QuizModel.fromJson(jsonDecode(response.body)[0]);
    } else {
      throw Exception('Failed to load QuizModels');
    }
  }
}
