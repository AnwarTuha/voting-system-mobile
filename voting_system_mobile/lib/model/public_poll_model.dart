import 'dart:convert';

import 'package:voting_system_mobile/model/response_error_model.dart';

PublicPollResponseModel publicPollResponseModelFromJson(String str) =>
    PublicPollResponseModel.fromJson(json.decode(str));

String publicPollResponseModelToJson(PublicPollResponseModel data) =>
    json.encode(data.toJson());

class PublicPollResponseModel {
  PublicPollResponseModel({
    this.polls,
  });

  List<PublicPoll> polls;

  factory PublicPollResponseModel.fromJson(Map<String, dynamic> json) =>
      PublicPollResponseModel(
        polls: List<PublicPoll>.from(
            json["Polls"].map((x) => PublicPoll.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Polls": List<dynamic>.from(polls.map((x) => x.toJson())),
      };
}

class PublicPoll {
  PublicPoll(
      {this.pollTitle,
      this.startDate,
      this.endDate,
      this.pollDescription,
      this.questions,
      this.pollId,
      this.error});

  String pollTitle;
  DateTime startDate;
  DateTime endDate;
  String pollDescription;
  List<Question> questions;
  String pollId;
  HttpError error;

  factory PublicPoll.fromJson(Map<String, dynamic> json) => PublicPoll(
        pollTitle: json["Title"] != null ? json["Title"] : null,
        startDate: json["startDate"] != null
            ? DateTime.parse(json["startDate"])
            : null,
        endDate:
            json["endDate"] != null ? DateTime.parse(json["endDate"]) : null,
        pollDescription:
            json["description"] != null ? json["description"] : null,
        questions: json["questions"] != null
            ? List<Question>.from(
                json["questions"].map((x) => Question.fromJson(x)))
            : [],
        pollId: json["id"] != null ? json["id"] : null,
        error: json["error"] != null ? HttpError.fromJson(json["error"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "Title": pollTitle,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "description": pollDescription,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
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
        questionTitle: json["title"] != null ? json["title"] : null,
        options: json["options"] != null
            ? List<Option>.from(json["options"].map((x) => Option.fromJson(x)))
            : null,
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
        optionTitle: json["title"] != null ? json["title"] : null,
        voteCount: json["voteCount"] != null ? json["voteCount"] : null,
      );

  Map<String, dynamic> toJson() => {
        "title": optionTitle,
        "voteCount": voteCount,
      };
}

PublicVoteResponseModel publicVoteResponseModelFromJson(String str) =>
    PublicVoteResponseModel.fromJson(json.decode(str));

String publicVoteResponseModelToJson(PublicVoteResponseModel data) =>
    json.encode(data);

class PublicVoteResponseModel {
  HttpError error;
  String message;

  PublicVoteResponseModel({this.message, this.error});

  factory PublicVoteResponseModel.fromJson(Map<String, dynamic> json) =>
      PublicVoteResponseModel(
        message: json["Response"] != null ? json["Response"] : null,
        error: json["error"] != null ? json["error"] : null,
      );
}

class PublicPollVoteModel {
  List<Choice> choices;
  String pollId;
  String userId;
  String authenticationToken;

  PublicPollVoteModel(
      {this.choices, this.userId, this.pollId, this.authenticationToken});

  Map<String, dynamic> toJson() => {
        "choice": List<dynamic>.from(choices.map((x) => x.toJson())),
      };
}

class Choice {
  int questionIndex;
  int choiceIndex;

  Choice({this.questionIndex, this.choiceIndex});

  Map<String, dynamic> toJson() => {
        "questionIndex": questionIndex,
        "choiceIndex": choiceIndex,
      };
}
