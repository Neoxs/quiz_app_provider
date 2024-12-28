import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../models/question.dart';
import '../widgets/question_card.dart';
import '../widgets/answer_buttons.dart';
import '../widgets/quiz_progress.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({Key? key, required this.title}) : super(key: key);
  final String title;

  void _showResults(BuildContext context, QuizProvider provider) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quiz Terminé!'),
          content: Text(
            'Votre score: ${provider.score}/${quizQuestions.length}\n'
            'Pourcentage: ${(provider.score / quizQuestions.length * 100).toStringAsFixed(1)}%',
          ),
          actions: [
            TextButton(
              onPressed: () {
                provider.resetQuiz();
                Navigator.of(context).pop();
              },
              child: const Text('Recommencer'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo[800],
      ),
      body: Consumer<QuizProvider>(
        builder: (context, quizProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QuestionCard(
                  question: quizProvider.currentQuestion,
                ),
                const SizedBox(height: 20),
                AnswerButtons(
                  selectedAnswer: quizProvider.selectedAnswer,
                  correctAnswer: quizProvider.currentQuestion.isCorrect,
                  onAnswerSelected: (bool answer) => quizProvider.checkAnswer(answer),
                ),
                const SizedBox(height: 20),
                if (quizProvider.selectedAnswer != null)
                  ElevatedButton.icon(
                    onPressed: () {
                      if (quizProvider.isLastQuestion) {
                        _showResults(context, quizProvider);
                      } else {
                        quizProvider.nextQuestion();
                      }
                    },
                    icon: const Icon(Icons.arrow_forward),
                    label: Text(
                      quizProvider.isLastQuestion 
                        ? 'Voir les Résultats'
                        : 'Question Suivante'
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo[100],
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                QuizProgress(
                  currentIndex: quizProvider.currentIndex,
                  totalQuestions: quizQuestions.length,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}