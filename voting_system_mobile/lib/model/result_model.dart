// To parse this JSON data, do
//
//     final resultModel = resultModelFromJson(jsonString);

import 'dart:convert';

import 'package:voting_system_mobile/model/response_error_model.dart';

ResultModel resultModelFromJson(String str) =>
    ResultModel.fromJson(json.decode(str));

String resultModelToJson(ResultModel data) =>
    json.encode(ResultData().toJson());

class ResultModel {
  ResultModel({this.result, this.error});

  List<ResultData> result;
  HttpError error;

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
      result: List<ResultData>.from(
        json["data"].map(
          (x) => ResultData.fromJson(x),
        ),
      ),
      error: json["error"] != null ? HttpError.fromJson(json["error"]) : null);
}

class ResultData {
  ResultData({
    this.title,
    this.voteCount,
  });

  String title;
  int voteCount;

  factory ResultData.fromJson(Map<String, dynamic> json) => ResultData(
        title: json["Title"],
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "Title": title,
        "vote_count": voteCount,
      };
}

class ResultRequestModel {
  String userId;
  String pollId;
  String authenticationToken;

  ResultRequestModel({this.userId, this.pollId, this.authenticationToken});
}
