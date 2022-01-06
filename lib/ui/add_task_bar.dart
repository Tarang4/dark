import 'package:demo_of/modals/task.dart';
import 'package:demo_of/sqllite/database_utils.dart';
import 'package:demo_of/ui/themes.dart';
import 'package:demo_of/widget/button.dart';
import 'package:demo_of/widget/input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatefulWidget {
  final int? update;

  const AddTaskPage({Key? key, this.update}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  var update;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  late DateTime _selectDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = "9:30 PM";
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = "none";
  List<String> repeatList = ["none", "Daily", "weekly", "monthly"];
  int _selectedColor = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    update = widget.update!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _appBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // _appBar(),
              Container(
                margin: EdgeInsets.only(bottom: 10, top: 20),
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 30,
                  ),
                ),
              ),

              const Text(
                "Add Task",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 18,
              ),
              MyInputField(
                title: "Title",
                hint: "Enter your title",
                cantroller: _titleController,
              ),
              MyInputField(
                title: "Note",
                hint: "Enter your Note",
                cantroller: _noteController,
              ),
              MyInputField(
                title: "Date",
                hint: DateFormat.yMd().format(_selectDate),
                widget: IconButton(
                    onPressed: () {
                      _getDateFromUser();
                      print(_selectDate);
                    },
                    icon: Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey,
                    )),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      title: "Start Time",
                      hint: _startTime,
                      widget: IconButton(
                        icon: Icon(
                          Icons.access_time_outlined,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          _getTimeFromUser(isStartTime: true);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: MyInputField(
                      title: "End Time",
                      hint: _endTime,
                      widget: IconButton(
                        icon: Icon(
                          Icons.access_time_outlined,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          _getTimeFromUser(isStartTime: false);
                        },
                      ),
                    ),
                  ),
                  // MyInputField(
                  //   title: "Start Time",
                  //   hint: 'll',
                  // ),
                ],
              ),
              MyInputField(
                title: "Remind",
                hint: "${_selectedRemind} Minutes early",
                widget: DropdownButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  underline: Container(
                    height: 0,
                  ),
                  elevation: 4,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[900],
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRemind = int.parse(newValue!);
                    });
                  },
                  items: remindList.map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem<String>(
                        value: value.toString(), child: Text(value.toString()));
                  }).toList(),
                ),
              ),
              MyInputField(
                title: "Repeat",
                hint: "${_selectedRepeat} ",
                widget: DropdownButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  underline: Container(
                    height: 0,
                  ),
                  elevation: 4,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[900],
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRepeat = newValue!;
                    });
                  },
                  items:
                      repeatList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value.toString(), child: Text(value.toString()));
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 18.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Color",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Get.isDarkMode
                              ? Colors.grey[100]
                              : Colors.grey[900],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: List<Widget>.generate(3, (index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                _selectedColor = index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: CircleAvatar(
                                radius: 14,
                                backgroundColor: index == 0
                                    ? primeColor
                                    : index == 1
                                        ? pink
                                        : yellow,
                                child: _selectedColor == index
                                    ? Icon(
                                        Icons.done,
                                        size: 16,
                                        color: Colors.white,
                                      )
                                    : Container(),
                              ),
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                  MyButton(
                      lable: "Save Task",
                      onTap: () async {
                        await _validateData();
                        // DatabaseUtils.db.insertDatabase(
                        //     1,
                        //     _titleController.text,
                        //     _noteController.text,1,
                        //     _startTime,
                        //
                        //     );
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _validateData() async {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      var xMem = UserModel(
          title: _titleController.text,
          note: _noteController.text,
          date: DateFormat.yMd().format(_selectDate).toString(),
          startTime: _startTime.toString(),
          endTime: _endTime.toString(),
          color: _selectedColor.toInt(),
          remind: _selectedRemind.toInt(),
          repeat: _selectedRepeat.toString());

      if (update == 1) {
        await DatabaseUtils.db.insertDatabase(
            _titleController.text,
            _noteController.text,
            DateFormat.yMd().format(_selectDate).toString(),
            _startTime.toString(),
            _endTime.toString(),
            _selectedColor.toInt(),
            _selectedRemind.toInt(),
            _selectedRepeat.toString());
      }
      DatabaseUtils.db.getData();

      Get.back();
    } else if (_titleController.text.isEmpty ||
        _noteController.text.isEmpty ||
        DateFormat.yMd().format(_selectDate).toString().isEmpty) {
      DatabaseUtils.db.updateDogBox(
          update!,
          _titleController.text,
          _noteController.text,
          DateFormat.yMd().format(_selectDate).toString(),
          _startTime.toString(),
          _endTime.toString(),
          _selectedColor.toInt(),
          _selectedRemind.toInt(),
          _selectedRepeat.toString());
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
        "Required",
        "All filed are required",
        backgroundColor: Colors.white,
        colorText: Get.isDarkMode ? Colors.black : Colors.black,
        icon: const Icon(
          Icons.warning_amber_outlined,
          color: Colors.black,
        ),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  _appBar() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.person,
            size: 30,
          ),
        ],
      ),
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime(2023),
        context: context);
    if (_pickerDate != null) {
      setState(() {
        _selectDate = _pickerDate;
        print(_selectDate);
      });
    } else {
      print("null 6e bro");
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var _pickedTime = await _showTimePicker();
    String _formatedTime = _pickedTime.format(context);
    if (_pickedTime == null) {
      print("time is not avalable");
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _pickedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _showTimePicker() async {
    return await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
          hour: int.parse(_startTime.split(":")[0]),
          minute: int.parse(_startTime.split(":")[1].split(" ")[0])),
    );
  }
}
