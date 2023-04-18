import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quiz/models/quiz_model.dart';
import 'package:quiz/service/api_service.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('ApiService', () {
    late http.Client httpClient;
    late ApiService apiService;

    setUp(() {
      httpClient = MockHttpClient();
      apiService = ApiService(httpClient: httpClient);
    });

    test('should return a list of QuizModel instance', () async {
      final jsonResponse = [
        {
          "category": "Food & Drink",
          "id": "624ab0e4348a461bfc6706a3",
          "correctAnswer": "Southeast Asia",
          "incorrectAnswers": ["South America", "China", "Africa"],
          "question": "Where in the world are tangerines originally from?",
          "tags": ["food_and_drink"],
          "type": "Multiple Choice",
          "difficulty": "hard",
          "regions": [],
          "isNiche": false
        },
        {
          "category": "Music",
          "id": "622a1c397cc59eab6f950ca1",
          "correctAnswer": "Pink Floyd",
          "incorrectAnswers": [
            "Wings",
            "Rudimental",
            "The Alan Parsons Project"
          ],
          "question":
              "Which English rock band released the song 'See Emily Play'?",
          "tags": ["rock_music", "music"],
          "type": "Multiple Choice",
          "difficulty": "hard",
          "regions": [],
          "isNiche": false
        }
      ];

      when(() => httpClient
              .get(Uri.parse('https://the-trivia-api.com/api/questions/')))
          .thenAnswer(
              (_) async => http.Response(jsonEncode(jsonResponse), 200));

      final QuizModel response = await apiService.getQuiz();

      expect(response, isA<QuizModel>());

      verify(() => httpClient.get(
          Uri.parse('https://the-trivia-api.com/api/questions/'))).called(1);
    });
  });
}
