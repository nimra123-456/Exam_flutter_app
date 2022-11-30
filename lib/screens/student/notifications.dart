import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:exam_app/constants/constants.dart';
import 'package:exam_app/controllers/notification_controller.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final NotificationCOntroller _notificationController =
      Get.put(NotificationCOntroller());
      @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
   // _notificationController.fetchtfinalNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Notifications"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: kDefaultPadding - 6),
            child: Obx(
              () {
                if (_notificationController.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: false,
                  itemCount: _notificationController.notificationList.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 15);
                  },
                  itemBuilder: (context, index) {
                    var notification =
                        _notificationController.notificationList[index];
                    return Card(
                      elevation: 0.3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.topRight,
                                          colors: [
                                            Theme.of(context)
                                                .focusColor
                                                .withOpacity(0.7),
                                            Theme.of(context)
                                                .focusColor
                                                .withOpacity(0.05),
                                          ])),
                                  child: Icon(
                                    Icons.notifications,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    size: 25,
                                  ),
                                ),
                                Positioned(
                                  right: -30,
                                  bottom: -50,
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor
                                          .withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(150),
                                    ),
                                  ),
                                ),
                               Positioned(
                                  left: -20,
                                  top: -50,
                                  child: Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor
                                          .withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(150),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(width: 15),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(
                                    notification.subject,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    textAlign: TextAlign.justify,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .merge(TextStyle(
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        notification.time,
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.watch_later_outlined,
                                            size: 15,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            DateFormat('HH:mm ')
                                                .format(notification.createdAt),
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ));
  }
}
