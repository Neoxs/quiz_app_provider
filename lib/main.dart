import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/quiz_page.dart';
import 'providers/quiz_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuizProvider(),
      child: MaterialApp(
        title: 'Quiz App',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          scaffoldBackgroundColor: Colors.indigo,
        ),
        home: const QuizPage(title: 'Quiz app'),
      ),
    );
  }
}