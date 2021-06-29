import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:voting_system_mobile/classes/request_service.dart';
import 'package:voting_system_mobile/model/check_notification_model.dart';
import 'package:voting_system_mobile/model/notification_model.dart';
import 'package:voting_system_mobile/providers/poll_provider.dart';
import 'package:voting_system_mobile/providers/user_provider.dart';
import 'package:voting_system_mobile/utils/app_url.dart';
import 'package:voting_system_mobile/utils/color_palette_util.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  IO.Socket _socket;
  var message;
  NotificationModel mappedNotifications;

  List<NotificationData> additionNotifications = [];
  List<NotificationData> updatingNotifications = [];
  List<NotificationData> removalNotifications = [];
  List<NotificationData> upcomingNotifications = [];

  @override
  void initState() {
    super.initState();
    initSocketIo();
  }

  @override
  void dispose() {
    _socket.close();
    additionNotifications = [];
    updatingNotifications = [];
    removalNotifications = [];
    super.dispose();
  }

  void initSocketIo() {
    var userProvider = Provider.of<UserProvider>(context, listen: false).user;
    try {
      // connect client to socket
      _socket = IO.io(
        "${AppUrl.socketIo}",
        <String, dynamic>{
          'transports': ['websocket']
        },
      );

      _socket.connect();

      _socket.onConnect((_) {
        print('connect');
        // emit authentication event
        var authenticationJson = {
          "userId": userProvider.userId,
          "accesstoken": userProvider.token
        };

        _socket.emit(
          "authentication",
          authenticationJson,
        );

        // listen incoming notification
        _socket.on("Notification", (notificationData) {
          mappedNotifications = NotificationModel.fromJson(notificationData);

          switch (mappedNotifications.notificationData.notificationType) {
            case "Addition":
              setState(() {
                additionNotifications.add(mappedNotifications.notificationData);
                additionNotifications = additionNotifications
                    .distinct((element) => element.pollId)
                    .toList();
              });
              break;
            case "Removal":
              setState(() {
                removalNotifications.add(mappedNotifications.notificationData);
                removalNotifications = removalNotifications
                    .distinct((element) => element.pollId)
                    .toList();
              });
              break;
            case "Editing":
              setState(() {
                updatingNotifications.add(mappedNotifications.notificationData);
                updatingNotifications = updatingNotifications
                    .distinct((element) => element.pollId)
                    .toList();
              });
              break;
            default:
              break;
          }
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateTime date = DateTime.now();
    final DateFormat formatter = DateFormat('EEE, MMM d ');
    final String formattedDate = formatter.format(date);

    var pollProvider = Provider.of<PollProvider>(context);
    var userProvider = Provider.of<UserProvider>(context).user;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                "Notifications",
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 7.0,
            ),
            Center(
              child: Text(
                "$formattedDate",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            additionNotifications.length != 0
                ? Container(
                    child: Column(
                      children: <Widget>[
                        Text(
                          "You've been added to the following polls",
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 7.0,
                        ),
                        ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: additionNotifications.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Container(
                                  padding: EdgeInsets.all(25.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Icon(Icons.notifications),
                                      SizedBox(width: 15.0),
                                      Container(
                                        child: Expanded(
                                          flex: 1,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "${additionNotifications[index].message}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18.0,
                                                  letterSpacing: 1.5,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: tealColors,
                                      )
                                    ],
                                  )),
                            );
                          },
                        ),
                        SizedBox(
                          height: 7.0,
                        ),
                        Divider(),
                      ],
                    ),
                  )
                : Container(),
            SizedBox(
              height: 15.0,
            ),
            updatingNotifications.length != 0
                ? Container(
                    child: Column(
                      children: <Widget>[
                        Text(
                          "The following polls have been updated",
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 7.0,
                        ),
                        ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: updatingNotifications.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Container(
                                  padding: EdgeInsets.all(25.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Icon(Icons.notifications),
                                      SizedBox(width: 15.0),
                                      Container(
                                        child: Expanded(
                                          flex: 1,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "${updatingNotifications[index].message}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18.0,
                                                  letterSpacing: 1.5,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: tealColors,
                                      )
                                    ],
                                  )),
                            );
                          },
                        ),
                        SizedBox(
                          height: 7.0,
                        ),
                        Divider(),
                      ],
                    ),
                  )
                : Container(),
            SizedBox(
              height: 15.0,
            ),
            removalNotifications.length != 0
                ? Container(
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Text(
                            "You've been removed from the following polls",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 7.0,
                        ),
                        ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: removalNotifications.length,
                          itemBuilder: (BuildContext context, int index) {
                            pollProvider.removeFromAllPollsByPollId(
                                removalNotifications[index].pollId);

                            return Dismissible(
                              key: UniqueKey(),
                              onDismissed: (DismissDirection direction) {
                                CheckNotificationModel requestModel =
                                    CheckNotificationModel(
                                  notificationId: removalNotifications[index]
                                      .notificationId,
                                  userId: userProvider.userId,
                                  authenticationToken: userProvider.token,
                                );
                                RequestService()
                                    .checkNotificationAsSeen(requestModel);
                                setState(() {
                                  removalNotifications.removeAt(index);
                                });
                              },
                              direction: DismissDirection.endToStart,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Container(
                                    padding: EdgeInsets.all(25.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Icon(Icons.notifications),
                                        SizedBox(width: 15.0),
                                        Container(
                                          child: Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "${removalNotifications[index].message}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18.0,
                                                    letterSpacing: 1.5,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )
                                      ],
                                    )),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                : Container(),
            removalNotifications.length == 0 &&
                    updatingNotifications.length == 0 &&
                    additionNotifications.length == 0
                ? Container(
                    child: Center(
                      child: Text(
                        "No new Notifications",
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
