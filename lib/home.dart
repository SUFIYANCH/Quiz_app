import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:music_player/welcome.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  int? selectednumber;
  bool isselect = false;
  late ConfettiController _centerController;

  Color currentColor = Colors.yellow;
  List<Question> questions = [
    Question('Who won the best player award in FIFA world cup 2022?',
        ['Kane', 'Messi', 'Neymar', 'Mbappe'], 'Messi'),
    Question('What is the capital of France?',
        ['Berlin', 'London', 'Paris', 'Nice'], 'Paris'),
    Question('What is the largest planet in our solar system?',
        ['Earth', 'Jupiter', 'Saturn', 'Mars'], 'Jupiter'),
    Question('What is the largest mammal in the world?',
        ['Elephant', 'Blue Whale', 'Giraffe', 'Lion'], 'Blue Whale'),
    Question('Which team won the FIFA world cup 2022?',
        ['Brazil', 'Germany', 'Argentina', 'France'], 'Argentina'),
  ];

  void goToNextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        showResult();
        _centerController.play();
      }
    });
  }

  Color selectcolor({required int optionlistindex}) {
    final questionoption =
        questions[currentQuestionIndex].answers[optionlistindex];

    final canswer = questions[currentQuestionIndex].correctAnswer;
    if (questionoption == canswer) {
      return Colors.green;
    } else if (questionoption != canswer && selectednumber == optionlistindex) {
      return Colors.red;
    }
    return currentColor;
  }

  void showResult() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              'Your Score',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          content: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.amber,
            child: Text(
              "$score",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 40),
            ),
          ),
          actions: <Widget>[
            Align(
              alignment: Alignment.center,
              child: ConfettiWidget(
                confettiController: _centerController,
                blastDirection: pi / 2,
                maxBlastForce: 5,
                minBlastForce: 1,
                emissionFrequency: 0.05,

                // 10 paticles will pop-up at a time
                numberOfParticles: 12,

                // particles will pop-up
                gravity: 0,
              ),
            ),
            Center(
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.black87),
                child: const Text('Back to home'),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Welcome(),
                    ),
                  );
                  setState(() {
                    currentQuestionIndex = 0;
                    score = 0;
                  });
                },
              ),
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    _centerController =
        ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _centerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amberAccent,
        title: Text(
          'Your Score : $score',
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Text(
                'Question ${currentQuestionIndex + 1} of ${questions.length}',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber),
              ),
              const SizedBox(height: 16),
              Text(
                questions[currentQuestionIndex].text,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: SizedBox(
                        height: 70,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: selectednumber == null
                                  ? currentColor
                                  : selectcolor(optionlistindex: index)),
                          child: Text(
                            questions[currentQuestionIndex].answers[index],
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                          onPressed: () {
                            setState(() {
                              selectednumber = index;
                              isselect = true;
                            });
                            if (questions[currentQuestionIndex]
                                    .answers[index] ==
                                questions[currentQuestionIndex].correctAnswer) {
                              setState(() {
                                score++;
                              });
                            }
                            Future.delayed(const Duration(seconds: 1))
                                .then((value) {
                              setState(() {
                                selectednumber = null;
                                isselect = false;
                                currentColor = Colors.yellow;
                              });
                              return goToNextQuestion();
                            });
                          },
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: questions[currentQuestionIndex].answers.length)
            ],
          )),
    );
  }
}

class Question {
  final String text;
  final List<String> answers;
  final String correctAnswer;

  Question(
    this.text,
    this.answers,
    this.correctAnswer,
  );
}
