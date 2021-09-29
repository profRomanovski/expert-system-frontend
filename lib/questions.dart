import 'dart:convert';
import 'package:http/http.dart' as http;

class Question {
  String question = '';
  final int id;
  final int answerId;
  List<Answer> answers;

  Question(
      {required this.question,
      required this.id,
      required this.answerId,
      required this.answers});

  factory Question.fromJson(Map<String, dynamic> json) {
    var answersList = json['answers'] as List;
    return Question(
        question: json['question']['value'] as String,
        id: json['question']['id'] as int,
        answerId: json['question']['answer_id'] as int,
        answers: answersList.map((e) => Answer.fromJson(e)).toList());
  }
}

class Answer {
  final String value;
  final int questionId;
  final int id;

  Answer({required this.value, required this.questionId, required this.id});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
        value: json['value'] as String,
        questionId: json['question_id'] as int,
        id: json['id'] as int);
  }
}

Future<Question> getQuestion(int answerId) async {
  const url = 'https://evening-island-37670.herokuapp.com/api/get-data';
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, int>{
      'answer': answerId,
    }),
  );
  if (response.statusCode == 200) {
    return Question.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
