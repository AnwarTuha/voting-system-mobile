import 'dart:convert';
import 'package:voting_system_mobile/model/response_error_model.dart';

Polls pollsFromJson(String str) => Polls.fromJson(jsonDecode(str));

class Polls{
  List<Poll> polls;
  HttpError error;

  Polls({this.polls, this.error});

  factory Polls.fromJson(Map<String, dynamic> json) => Polls(
    polls: json["Polls"] != null ? List<Poll>.from(json["Polls"].map((x) => Poll.fromJson(x))) : [],
    error: json["error"] != null ? HttpError.fromJson(json["error"]) : null,
  );

}

class Poll{
  String pollId;
  String pollTitle;
  String pollDescription;
  String type;
  DateTime startDate;
  DateTime endDate;
  List<Option> option;
  bool isPublic;
  bool canRetract;
  bool hasVoted = false;

  Poll({this.pollId, this.pollTitle, this.isPublic, this.endDate, this.startDate, this.pollDescription, this.canRetract, this.option, this.type});

  factory Poll.fromJson(Map<String, dynamic> json) => Poll(
    pollId: json["id"] != null ? json["id"] : "",
    pollTitle: json["Title"] != null ? json["Title"] : "",
    pollDescription: json["description"] != null ? json["description"] : "",
    type: json["type"] != null ? json["type"] : "",
    endDate: json["endDate"] != null ? DateTime.parse(json["endDate"]) : "",
    startDate: json["startDate"] != null ? DateTime.parse(json["startDate"]) : "",
    isPublic: json["isPublic"],
    canRetract: json["canRetract"],
    option: List<Option>.from(json["options"].map((x) => Option.fromJson(x)))
  );

}

class Option{
  String title;
  int voteCount;

  Option({this.voteCount, this.title});

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    title: json["Title"] != null ? json["Title"] : "",
    voteCount: json["vote_count"] != null ? json["vote_count"] : ""
  );

}

class PollRequestModel{
  String userId;
  PollRequestModel({this.userId});
}
