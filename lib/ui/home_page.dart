import 'package:demo_of/services/thems_services.dart';
import 'package:demo_of/ui/themes.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            ThemeServices().switchTheme();
            print("okk");
          },
          icon: const Icon(
            Icons.nightlight_round,
            size: 30,
          ),
        ),
      ),
      // body: Column(
      //   children:  [
      //     Text(
      //       "hello",
      //       style: TextStyle(fontSize: 37,color: Colors.red),
      //     ),
      //     Container(
      //       height: 100,
      //       width: 200,
      //       color: Colors.green,
      //     ),
      //   ],
      // ),
    );
  }
}
