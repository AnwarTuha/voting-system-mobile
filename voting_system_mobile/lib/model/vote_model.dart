import 'dart:convert';
import 'package:voting_system_mobile/model/response_error_model.dart';

VoteResponseModel voteResponseModelFromJson(String str) => VoteResponseModel.fromJson(json.decode(str));

String voteResponseModelToJson(VoteResponseModel data) => json.encode(data.toJson());

class VoteResponseModel {
  VoteResponseModel({
    this.response,
    this.error
  });

  String response;
  HttpError error;

  factory VoteResponseModel.fromJson(Map<String, dynamic> json) => VoteResponseModel(
    response: json["response"] != null ? json["response"] : null,
    error: json["error"] != null ? HttpError.fromJson(json["error"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "response": response,
  };
}

class VoteRequestModel{
  String voterId;
  String option;
  String pollId;

  VoteRequestModel({this.option, this.voterId, this.pollId});

  Map<String, dynamic> toJson() => {
    "voterId": voterId,
    "option": option
  };
}