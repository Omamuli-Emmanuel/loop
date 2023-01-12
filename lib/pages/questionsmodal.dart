
import 'dart:convert';

List<QuestionsAnswerList> QuestionsAnswerFromJson(String str)
=> List<QuestionsAnswerList>.from(json.decode(str).map((x) => QuestionsAnswerList.fromJson(x)));

String qestionsAnswerToJson(List<QuestionsAnswerList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuestionsAnswerList{
  String questionOne = "";
  String answerOne = "";
  String questionTwo = "";
  String answerTwo = "";
  String questionThree = "";
  String answerThree = "";

  QuestionsAnswerList({
    required this.questionOne,
    required this.answerOne,
    required this.questionTwo,
    required this.answerTwo,
    required this.questionThree,
    required this.answerThree,
  });

  factory QuestionsAnswerList.fromJson(Map<String, dynamic> json) => QuestionsAnswerList(
    questionOne: json["questionOne"],
    answerOne: json["answerOne"],
    questionTwo: json["questionTwo"],
    answerTwo: json["answerTwo"],
    questionThree : json["questionThree"],
    answerThree: json["answerThree"],
  );

  Map<String, dynamic> toJson() => {
    questionOne: questionOne,
    answerOne: answerOne,
    questionTwo : questionTwo,
    answerTwo : answerTwo,
    questionThree : questionThree,
    answerThree: answerThree,
  };
}