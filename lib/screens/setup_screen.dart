import 'package:flutter/material.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({Key? key}) : super(key: key);

  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  int numberOfQuestions = 10;
  String selectedCategory = "Any Category";
  String selectedDifficulty = "Any Difficulty";
  String questionType = "Any Type";

  final categories = ["Any Category", "9", "21"]; // Use category IDs
  final difficulties = ["Any Difficulty", "Easy", "Medium", "Hard"];
  final types = ["Any Type", "Multiple Choice", "True/False"];

  void startQuiz() {
    // Navigate to QuizScreen with selected options
    Navigator.pushNamed(
      context,
      '/quiz',
      arguments: {
        'numberOfQuestions': numberOfQuestions,
        'category': selectedCategory,
        'difficulty': selectedDifficulty,
        'questionType': questionType,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Setup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Number of Questions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Slider(
              value: numberOfQuestions.toDouble(),
              min: 5,
              max: 50,
              divisions: 9,
              label: numberOfQuestions.toString(),
              onChanged: (value) {
                setState(() {
                  numberOfQuestions = value.toInt();
                });
              },
            ),
            const SizedBox(height: 16),
            const Text('Select Category',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: selectedCategory,
              isExpanded: true,
              items: categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text('Select Difficulty',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: selectedDifficulty,
              isExpanded: true,
              items: difficulties.map((String difficulty) {
                return DropdownMenuItem<String>(
                  value: difficulty,
                  child: Text(difficulty),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedDifficulty = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text('Question Type',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: questionType,
              isExpanded: true,
              items: types.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  questionType = value!;
                });
              },
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: startQuiz,
                child: const Text('Start Quiz'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}