import 'dart:convert';

import 'package:voting_system_mobile/model/response_error_model.dart';

CandidateResponseModel candidatePollResponseModelFromJson(String str) =>
    CandidateResponseModel.fromJson(json.decode(str));

String candidatePollResponseModelToJson(CandidateResponseModel data) =>
    json.encode(data.toJson());

class CandidateResponseModel {
  CandidateResponseModel({this.response, this.error});

  Response response;
  HttpError error;

  factory CandidateResponseModel.fromJson(Map<String, dynamic> json) =>
      CandidateResponseModel(
        response: json["response"] != null
            ? Response.fromJson(json["response"])
            : null,
        error: json["error"] != null ? HttpError.fromJson(json["error"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "response": response.toJson(),
      };
}

class Response {
  Response({
    this.candidates,
  });
  List<Candidate> candidates;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        candidates: json["candidates"] != null
            ? List<Candidate>.from(
                json["candidates"].map((x) => Candidate.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "candidates": List<dynamic>.from(candidates.map((x) => x.toJson())),
      };
}

class Candidate {
  Candidate({
    this.candidateFirstName,
    this.candidateLastName,
    this.id,
    this.role,
  });

  String candidateFirstName;
  String candidateLastName;
  String id;
  String role;

  factory Candidate.fromJson(Map<String, dynamic> json) => Candidate(
        candidateFirstName: json["firstname"],
        candidateLastName: json["lastname"],
        id: json["id"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": candidateFirstName,
        "lastname": candidateLastName,
        "id": id,
        "role": role,
      };
}

class CandidateRequestModel {
  String pollId;
  String voterId;
  String authenticationToken;

  CandidateRequestModel({this.pollId, this.voterId, this.authenticationToken});
}
