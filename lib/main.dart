import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var questions = [
    const Question(
      'What is your Favourite color?',
      ['Red', 'Yellow', 'Blue', 'Green'],
      [5, 2, 7, 3],
    ),
    const Question(
      'What is your Favourite Car?',
      ['Bugatti', 'McLaren', 'Lamborghini', 'Tesla'],
      [4, 3, 8, 5],
    ),
    const Question(
      'What is your Favourite Hobby?',
      ['Gardening', 'Travelling', 'Playing Games'],
      [5, 2, 3],
    ),
    const Question(
      'What is your Favourite Animal?',
      ['Lion', 'Elephant', 'Wolf', 'Fox'],
      [5, 2, 8, 4],
    ),
  ];
  int questionIndex = 0;
  int questionNum = 1;
  int totalScore = 0;
  bool quiz = true;
  void _nextQuestion() {
    if (questions.length > questionIndex + 1) {
      questionIndex++;
      questionNum++;
    } else {
      quiz = false;
    }
    setState(() {});
  }

  void _scoreCalculate(int num) {
    totalScore = totalScore + questions[questionIndex].score[num];
  }

  void _resetQuiz() {
    quiz = true;
    totalScore = 0;
    questionIndex = 0;
    questionNum = 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Quiz App")),
        ),
        body: SingleChildScrollView(
          child: quiz
              ? Padding(
                  padding: const EdgeInsets.all(15),
                  child: Center(
                    child: Column(children: [
                      Text(
                        "Question #$questionNum:",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        questions[questionIndex].questionText,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      for (int i = 0;
                          i < questions[questionIndex].answers.length;
                          i++)
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 3,
                              ),
                              child: Text(
                                questions[questionIndex].answers[i],
                                style: const TextStyle(fontSize: 18),
                              ),
                              onPressed: () {
                                _scoreCalculate(i);
                                _nextQuestion();
                              },
                            ),
                          ),
                        ),
                    ]),
                  ),
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 300.0),
                    child: Column(
                      children: [
                        const Text(
                          "Thank you for your time!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(
                          "Total Score: $totalScore",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        ElevatedButton(
                            onPressed: _resetQuiz,
                            child: const Text(
                              "Reset Quiz",
                              style: TextStyle(fontSize: 18),
                            ))
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class Question {
  final String questionText;
  final List<String> answers;
  final List<int> score;
  const Question(this.questionText, this.answers, this.score);
}
