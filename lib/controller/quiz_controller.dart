import 'package:http/http.dart' as http;

import '../models/quiz_model.dart';
import '../service/api_service.dart';

class QuizController {
  Future<QuizModel> getQuiz() {
    return ApiService(httpClient: http.Client()).getQuiz();
  }
}
