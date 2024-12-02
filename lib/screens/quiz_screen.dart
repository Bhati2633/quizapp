import 'package:flutter/material.dart';
import 'dart:convert'; // For JSON decoding
import 'package:http/http.dart' as http; // For making HTTP requests

class QuizScreen extends StatefulWidget {
  final int numberOfQuestions;
  final String category;
  final String difficulty;
  final String questionType;

  const QuizScreen({
    Key? key,
    required this.numberOfQuestions,
    required this.category,
    required this.difficulty,
    required this.questionType,
  }) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool isLoading = true;
  List<dynamic> questions = [];

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  void fetchQuestions() async {
  // Base API URL
  String baseUrl = 'https://opentdb.com/api.php';

  // Build the query parameters
  String url = '$baseUrl?amount=${widget.numberOfQuestions}';

  // Add category if specified
  if (widget.category != "Any Category") {
    url += "&category=${widget.category}";
  }

  // Add difficulty if specified
  if (widget.difficulty != "Any Difficulty") {
    url += "&difficulty=${widget.difficulty.toLowerCase()}";
  }

  // Add question type if specified
  if (widget.questionType != "Any Type") {
    url += "&type=${widget.questionType.toLowerCase().replaceAll(" ", "_")}";
  }

  // Log URL for debugging
  print('Fetching questions from URL: $url');

  // Fetch data
  final response = await http.get(Uri.parse(url));

  // Check for successful response
  if (response.statusCode == 200) {
    final data = json.decode(response.body);

    // Update state with retrieved questions
    setState(() {
      questions = data['results'];
      isLoading = false;
    });
  } else {
    setState(() {
      isLoading = false;
    });

    // Handle error: show a message or retry
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to load questions. Error: ${response.statusCode}')),
    );
  }
}

  void submitAnswer(bool correct) {
    if (correct) score++;
    if (currentQuestionIndex + 1 < widget.numberOfQuestions) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      Navigator.pushReplacementNamed(context, '/summary', arguments: score);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Quiz')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final question = questions[currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              question['question'],
              style: const TextStyle(fontSize: 18),
            ),
            ...question['incorrect_answers']
                .map<Widget>((answer) => ElevatedButton(
                      onPressed: () => submitAnswer(false),
                      child: Text(answer),
                    ))
                .toList(),
            ElevatedButton(
              onPressed: () => submitAnswer(true),
              child: Text(question['correct_answer']),
            ),
          ],
        ),
      ),
    );
  }
}
