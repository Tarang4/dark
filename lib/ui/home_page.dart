import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:demo_of/modals/task.dart';
import 'package:demo_of/services/notification_services.dart';
import 'package:demo_of/services/thems_services.dart';
import 'package:demo_of/sqllite/database_utils.dart';
import 'package:demo_of/ui/add_task_bar.dart';
import 'package:demo_of/ui/themes.dart';
import 'package:demo_of/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';

import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DateTime _selectedDate = DateTime.now();

  List<UserModel> taskList = [];

  var notifyHelper;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    // notifyHelper = NotifyHelper();
    // NotifyHelper().requestIOSPermissions();
    // NotifyHelper().initializeNotification;
  }


  getData() async {
    List<UserModel> tasks = await DatabaseUtils.db.getData();
    setState(() {
      taskList = tasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _appBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [_appBare(), _addTaskBar(), _AddDateBar(), _showTask()],
        ),
      ),
    );
  }

  _showTask() {
    return ListView.builder(
      // itemCount: taskList.length,
      itemCount: taskList.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        // return Container();
        UserModel taskModal = taskList[index];
        var colorr = int.parse(taskModal.color.toString());

        return Container(
          height: 110,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 20),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: colorr == 0
                ? blue
                : colorr == 1
                    ? pink
                    : colorr == 2
                        ? yellow
                        : blue,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Column(
              //   children: [
              //     Text(taskModal.id.toString()),
              //     Text(taskModal.title.toString()),
              //     Text(taskModal.note.toString()),
              //     Text(taskModal.date.toString()),
              //     Text(taskModal.startTime.toString()),
              //     Text(taskModal.endTime.toString()),
              //     Text(taskModal.color.toString()),
              //     Text(taskModal.repeat.toString()),
              //     Text(taskModal.remind.toString()),
              //   ],
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        taskModal.title.toString(),
                        style: taskStyle,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        taskModal.date.toString(),
                        style: taskExtraSmallStyle,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_outlined,
                        size: 18,
                        color: Colors.grey[900],
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        taskModal.startTime.toString(),
                        style: taskSmallStyle,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        taskModal.endTime.toString(),
                        style: taskSmallStyle,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width / 150 * 100,
                    child: Text(
                      taskModal.note.toString(),
                      style: taskExtraSmallStyle,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 0,
              ),
              Container(
                height: 70,
                width: 2,
                color: Colors.grey[800]!.withOpacity(0.5),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {var isUpdate=taskModal.id;
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTaskPage(update: isUpdate)));
                      getData();
                    },
                    child: Container(
                      height: 35,
                      alignment: Alignment.center,
                      width: 55,
                      decoration: BoxDecoration(
                          color: colorr == 1
                              ? yellow
                              : colorr == 2
                                  ? blue
                                  : colorr == 0
                                      ? pink
                                      : yellow,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "Edit",
                        style: buttonExtraSmallStyle,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      DatabaseUtils.db.deleteData(taskModal.title.toString());
                      getData();
                    },
                    child: Container(
                      height: 35,
                      alignment: Alignment.center,
                      width: 55,
                      decoration: BoxDecoration(
                          color: colorr == 0
                              ? yellow
                              : colorr == 1
                                  ? blue
                                  : colorr == 2
                                      ? pink
                                      : yellow,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "Delete",
                        style: buttonExtraSmallStyle,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  _AddDateBar() {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        onDateChange: (date) {
          _selectedDate = date;
        },
        width: 80,
        dateTextStyle: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
        monthTextStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        dayTextStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        initialSelectedDate: DateTime.now(),
        selectionColor: blue,
        selectedTextColor: Colors.white,
      ),
    );
  }

  _addTaskBar() {
    return Padding(
      padding:
          const EdgeInsets.only(left: 20.0, right: 20, bottom: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeadingStyle,
              ),
              Text(
                "Today",
                style: headingStyle,
              )
            ],
          ),
          MyButton(
            onTap: () {
              Get.to(const AddTaskPage( update: 1,));
            },
            lable: '+ Add task',
          )
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          ThemeServices().switchTheme();
          //NotifyHelper().displayNotification(title: "theme changed",body:Get.isDarkMode?"activated dark theme":"activated light theme");
          //NotifyHelper().scheduledNotification();
          print("okk");
        },
        icon: const Icon(
          Icons.nightlight_round,
          size: 30,
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
            setState(() {
              getData();
            });
          },
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.person,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }

  _appBare() {
    return Padding(
      padding: const EdgeInsets.only(left: 13.0, right: 13, top: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              ThemeServices().switchTheme();
              //NotifyHelper().displayNotification(title: "theme changed",body:Get.isDarkMode?"activated dark theme":"activated light theme");
              //NotifyHelper().scheduledNotification();
              print("okk");
            },
            icon: const Icon(
              Icons.nightlight_round,
              size: 30,
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                getData();
              });
            },
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.person,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
