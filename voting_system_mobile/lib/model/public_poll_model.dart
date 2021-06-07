import 'dart:convert';

List<PublicPollResponseModel> publicPollResponseModelFromJson(String str) =>
    List<PublicPollResponseModel>.from(
        json.decode(str).map((x) => PublicPollResponseModel.fromJson(x)));

String publicPollResponseModelToJson(List<PublicPollResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PublicPollResponseModel {
  PublicPollResponseModel({
    this.pollTitle,
    this.startDate,
    this.endDate,
    this.pollDescription,
    this.questions,
    this.publisherId,
    this.pollId,
  });

  String pollTitle;
  DateTime startDate;
  DateTime endDate;
  String pollDescription;
  List<Question> questions;
  String publisherId;
  String pollId;

  factory PublicPollResponseModel.fromJson(Map<String, dynamic> json) =>
      PublicPollResponseModel(
        pollTitle: json["Title"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        pollDescription: json["description"],
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
        publisherId: json["publisherId"],
        pollId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "Title": pollTitle,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "description": pollDescription,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
        "publisherId": publisherId,
        "id": pollId,
      };
}

class Question {
  Question({
    this.questionTitle,
    this.options,
  });

  String questionTitle;
  List<Option> options;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        questionTitle: json["title"],
        options:
            List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": questionTitle,
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
      };
}

class Option {
  Option({
    this.optionTitle,
    this.voteCount,
  });

  String optionTitle;
  int voteCount;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        optionTitle: json["title"],
        voteCount: json["voteCount"],
      );

  Map<String, dynamic> toJson() => {
        "title": optionTitle,
        "voteCount": voteCount,
      };
}
