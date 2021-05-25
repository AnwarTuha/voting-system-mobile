class PollResponseModel{
  List<Poll> polls;
  ResponseError error;

  PollResponseModel({this.polls, this.error});

  factory PollResponseModel.fromJson(Map<String, dynamic> json) => PollResponseModel(
      polls: json["polls"] != null ? List<Poll>.from(json["polls"].map((x) => Poll.fromJson(x))) : [],
      error:  json["error"] != null ? ResponseError.fromJson(json["error"]) : null
  );

}


class Poll{
  String pollTitle;
  String pollDescription;
  DateTime startDate;
  DateTime endDate;
  List<Rules> rules;

  Poll({this.pollTitle, this.endDate, this.pollDescription, this.startDate, this.rules});

  factory Poll.fromJson(Map<String, dynamic> json) => Poll(
      pollTitle: json['pollTitle'] != null ? json['pollTitle'] : '',
      pollDescription: json['pollDescription'] != null ? json['pollDescription'] : '',
      startDate: json['startDate'] != null ? json['startDate'] : '',
      endDate: json['endDate'] != null ? json['endDate'] : '',
      rules: json["rules"] != null ? List<Rules>.from(json["rules"].map((x) => Rules.fromJson(x))) : []
  );

  Map<String, dynamic> toJson() => {
    "pollTitle": pollTitle,
    "pollDescription": pollDescription,
    "startDate": startDate,
    "endDate": endDate
  };

}

class Rules{
  bool isVoteRetractable;
  bool isWinPlurality;
  bool isWinPercent;

  Rules({this.isVoteRetractable, this.isWinPercent, this.isWinPlurality});

  factory Rules.fromJson(Map<String, dynamic> json) => Rules(
    isVoteRetractable: json["isVoteRetractable"],
    isWinPercent: json["isWinPercent"],
    isWinPlurality: json["isWinPlurality"]
  );

}

class PollRequestModel{
  String userId;

  PollRequestModel({this.userId});

  Map<String, dynamic> toJson() => {
    "userId": userId
  };

}

class ResponseError{
  ResponseError({
    this.name,
    this.message,
    this.code,
  });

  String name;
  String message;
  String code;

  factory ResponseError.fromJson(Map<String, dynamic> json) => ResponseError(
    name: json["name"],
    message: json["message"],
    code: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": code,
    "name": name,
    "message": message,
  };
}