class NotificationModel {
  NotificationData notificationData;

  NotificationModel({this.notificationData});

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        notificationData: NotificationData.fromJson(json["Data"]),
      );
}

class NotificationData {
  String pollId;
  String notificationType;
  String message;
  bool isChecked;
  String notificationId;

  NotificationData(
      {this.pollId,
      this.notificationId,
      this.isChecked,
      this.message,
      this.notificationType});

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        pollId: json["pollId"],
        notificationType: json["type"],
        message: json["Message"],
        isChecked: json["isChecked"],
        notificationId: json["id"],
      );
}
