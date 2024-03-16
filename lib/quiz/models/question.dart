// ignore_for_file: constant_identifier_names, avoid_print, avoid_function_literals_in_foreach_calls

class Question {
  final int id, answer;
  final String question;
  final List<String> options;

  Question(
      {required this.id,
      required this.question,
      required this.answer,
      required this.options});
}

const List sample_data = [
  {
    "id": 1,
    "question":
        "Flutter is an open-source UI software development kit created by ______",
    "options": ['Apple', 'Google', 'Facebook', 'Microsoft'],
    "answer_index": 1,
  },
  {
    "id": 2,
    "question": "When did Google release Flutter?",
    "options": ['Jun 2017', 'May 2017', 'May 2018', 'Jun 2018'],
    "answer_index": 2,
  },
  {
    "id": 3,
    "question": "A memory location that holds a single letter or number.",
    "options": ['Double', 'Int', 'Char', 'Word'],
    "answer_index": 2,
  },
  {
    "id": 4,
    "question": "What command do you use to output data to the screen?",
    "options": ['Cin', 'Count>>', 'Cout', 'Output>>'],
    "answer_index": 2,
  },
];

void main() {
  List<Question> questions = sample_data.map((data) {
    return Question(
      id: data["id"],
      question: data["question"],
      options: List<String>.from(data["options"]),
      answer: data["answer_index"],
    );
  }).toList();

  // Test if questions are parsed correctly
  questions.forEach((question) {
    print("ID: ${question.id}");
    print("Question: ${question.question}");
    print("Options: ${question.options}");
    print("Answer Index: ${question.answer}");
    print("");
  });
}
