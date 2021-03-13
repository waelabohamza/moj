import 'package:flutter/material.dart';

class ThemeColors extends StatefulWidget {
  ThemeColors({Key key}) : super(key: key);

  @override
  _ThemeColorsState createState() => _ThemeColorsState();
}

class _ThemeColorsState extends State<ThemeColors> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(children: [
            InkWell(
              onTap: (){
                
              },
                child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(30)),
            )),
            SizedBox(width: 20),
            InkWell(
              onTap: (){

              },
                child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(30)),
            ))
          ])
        ],
      ),
    );
  }
}
