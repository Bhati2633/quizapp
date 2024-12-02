import 'package:flutter/material.dart';
import 'package:quizapp/screens/setup_screen.dart';
import 'package:quizapp/screens/quiz_screen.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const SetupScreen(),
        '/quiz': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return QuizScreen(
            numberOfQuestions: args['numberOfQuestions'] ?? 10,
            category: args['category'] ?? 'Any Category',
            difficulty: args['difficulty'] ?? 'Any Difficulty',
            questionType: args['questionType'] ?? 'Any Type',
          );
        },
      },
    );
  }
}
