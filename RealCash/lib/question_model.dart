class Question {
  final String questionText;
  final List<Answer> answersList;

  Question(this.questionText, this.answersList);
}

class Answer {
  final String answerText;
  final bool isCorrect;

  Answer(this.answerText, this.isCorrect);
}

List<Question> getQuestions() {
  List<Question> list = [];
  //ADD questions and answer here

  list.add(Question(
    "Which one is the smallest ocean in the World?",
    [
      Answer("Indian", false),
      Answer("pacific", false),
      Answer("Atlantic", false),
      Answer("Arctic", true),
    ],
  ));

  list.add(Question(
    "Which one is the capital of spain?",
    [
      Answer("Barcelona", false),
      Answer("Madrid", true),
      Answer("Seville", false),
      Answer("Lisbon", false),
    ],
  ));

  list.add(Question(
    "Which country has the most number of lakes?",
    [
      Answer("Canada", true),
      Answer("USA", false),
      Answer("Finland", false),
      Answer("Brazil", false),
    ],
  ));

  list.add(Question(
    "Emu bird is found in the ocuntry?",
    [
      Answer("New Zealand", false),
      Answer("Japan", false),
      Answer("Austrila", true),
      Answer("Thailand", false),
    ],
  ));

  list.add(Question(
    "International Woman's day is celebrated on?",
    [
      Answer("2nd Jan", false),
      Answer("5th April", false),
      Answer("8th March", true),
      Answer("15 September", false),

    ],
  ));

  return list;
}

