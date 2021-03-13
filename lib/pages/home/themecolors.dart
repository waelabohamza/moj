import 'package:flutter/material.dart';
import 'package:moj/component/changecolor.dart';
import 'package:moj/main.dart';
import 'package:provider/provider.dart';

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
          Container(
            margin: EdgeInsets.only(top: 10 , bottom: 30),
            child: Text("اختر اللون المناسب"),
          ),
          Row(children: [
            Spacer(),
            Consumer<ChangeColorTheme>(builder: (context, changecolor, child) {
              return InkWell(
                  onTap: () {
                    changecolor.changeColor("blue");
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30)),
                  ));
            }),
            Spacer(),
            Consumer<ChangeColorTheme>(builder: (context, changecolor, child) {
              return InkWell(
                  onTap: () {
                    changecolor.changeColor("red");
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(30)),
                  ));
            }),
            Spacer(),
            Consumer<ChangeColorTheme>(builder: (context, changecolor, child) {
              return InkWell(
                  onTap: () {
                    changecolor.changeColor("green");
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(30)),
                  ));
            }),
            Spacer(),
            Consumer<ChangeColorTheme>(builder: (context, changecolor, child) {
              return InkWell(
                  onTap: () {
                    changecolor.changeColor("black");
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30)),
                  ));
            }),
            Spacer(),
            Consumer<ChangeColorTheme>(builder: (context, changecolor, child) {
              return InkWell(
                  onTap: () {
                    changecolor.changeColor("yellowAccent");
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Colors.yellowAccent[700],
                        borderRadius: BorderRadius.circular(30)),
                  ));
            }),
            Spacer(),
            Consumer<ChangeColorTheme>(builder: (context, changecolor, child) {
              return InkWell(
                  onTap: () {
                    changecolor.changeColor("brown");
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(30)),
                  ));
            }),
            Spacer(),
          ])
        ],
      ),
    );
  }
}
