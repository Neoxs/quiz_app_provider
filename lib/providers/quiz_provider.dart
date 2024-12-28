import 'package:flutter/foundation.dart';
import '../models/question.dart';

class QuizProvider with ChangeNotifier {
  int _currentIndex = 0;
  int _score = 0;
  bool? _selectedAnswer;

  // Getters
  int get currentIndex => _currentIndex;
  int get score => _score;
  bool? get selectedAnswer => _selectedAnswer;
  bool get isLastQuestion => _currentIndex == quizQuestions.length - 1;

  void checkAnswer(bool userAnswer) {
    _selectedAnswer = userAnswer;
    if (userAnswer == quizQuestions[_currentIndex].isCorrect) {
      _score++;
    }
    notifyListeners();
  }

  void nextQuestion() {
    if (_selectedAnswer != null) {
      if (_currentIndex < quizQuestions.length - 1) {
        _currentIndex++;
        _selectedAnswer = null;
      }
      notifyListeners();
    }
  }

  void resetQuiz() {
    _currentIndex = 0;
    _score = 0;
    _selectedAnswer = null;
    notifyListeners();
  }

  Question get currentQuestion => quizQuestions[_currentIndex];
}