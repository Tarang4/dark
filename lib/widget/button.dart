import 'package:demo_of/ui/themes.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
final String lable;
final Function()? onTap;
  const MyButton({Key? key, required this.lable, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,alignment: Alignment.center,
        width: 120,
        child: Text(lable,style: const TextStyle(color: Colors.white),),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: primeColor,
        ),
      ),
    );
  }
}
