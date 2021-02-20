import 'package:flutter/material.dart';
import 'package:moj/const.dart';


class ListBottom extends StatelessWidget {
  final list;
  final mdw;
  const ListBottom({Key key, this.mdw, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed("services") ; 
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: mdw / 14),
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${list['name']}",
                        style: TextStyle(fontSize: 16, color: mainColor),
                      ),
                      Text(
                        "${list['desc']}",
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 3),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // CircularPercentIndicator(
                    //   animation: true,
                    //   radius: 60.0,
                    //   lineWidth: 5.0,
                    //   percent: countcode / 100,
                    //   animationDuration: 1000,
                    //   center: Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       new Text("$countcode"),
                    //     ],
                    //   ),
                    //   progressColor: mainColor,
                    // ),
                    RaisedButton(
                      color: mainColor,
                      textColor: Colors.white,
                      onPressed: () {},
                      child: Text(
                        "ابدا الخدمة",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    // Text(
                    //   "متوسط وقت الانتظار",
                    //   style: TextStyle(fontSize: 12),
                    //   textAlign: TextAlign.center,
                    // )
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
