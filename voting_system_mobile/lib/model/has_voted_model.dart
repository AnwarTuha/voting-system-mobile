import 'dart:convert';

class UserHasVotedRequestModel{
  String userId;
  String pollId;
  String authenticationToken;

  UserHasVotedRequestModel({this.pollId, this.userId, this.authenticationToken});
}

UserHasVotedResponseModel userHasVotedResponseModelFromJson(String str) => UserHasVotedResponseModel.fromJson(json.decode(str));

String userHasVotedResponseModelToJson(UserHasVotedResponseModel data) => json.encode(data.toJson());

class UserHasVotedResponseModel {
  UserHasVotedResponseModel({
    this.hasVoted,
  });

  bool hasVoted;

  factory UserHasVotedResponseModel.fromJson(Map<String, dynamic> json) => UserHasVotedResponseModel(
    hasVoted: json["hasVoted"] != null ? json["hasVoted"] : null,
  );

  Map<String, dynamic> toJson() => {
    "hasVoted": hasVoted,
  };
}
