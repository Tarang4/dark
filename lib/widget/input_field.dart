import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String? hint;
  final TextEditingController? cantroller;
  final Widget? widget;

  const MyInputField(
      {Key? key,
      required this.title,
      required this.hint,
      this.cantroller,
      this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[900],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 7,
            ),
            padding: EdgeInsets.only(
              left: 10,
            ),
            height: 45,
            // width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget==null?false:true,
                    controller: cantroller,
                    autofocus: false,
                    keyboardType: TextInputType.text,textInputAction: TextInputAction.next,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                    ),
                    cursorColor: Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.transparent,
                      )),
                      hintText: hint,
                      hintStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                      ),
                    ),
                  ),
                ),
                widget==null?Container():Container(child: widget,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
