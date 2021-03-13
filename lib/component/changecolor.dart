
import 'package:flutter/material.dart';
import 'package:moj/main.dart';

class ChangeColorTheme with ChangeNotifier {
  Color mainColor = sharedPrefs.getString("colormain") == "red"
      ? Colors.red
      : sharedPrefs.getString("colormain") == "blue"
          ? Colors.blue
          : sharedPrefs.getString("colormain") == "green"
              ? Colors.green
              : sharedPrefs.getString("colormain") == "black"
                  ? Colors.black
                  : sharedPrefs.getString("colormain") == "yellowAccent"
                      ? Colors.yellowAccent[700]
                      : sharedPrefs.getString("colormain") == "brown"
                          ? Colors.brown
                          : Colors.red;
  changeColor(String type) {
    if (type == "red") mainColor = Colors.red;
    if (type == "blue") mainColor = Colors.blue;
    if (type == "green") mainColor = Colors.green;
    if (type == "black") mainColor = Colors.black;
    if (type == "yellowAccent") mainColor = Colors.yellowAccent[700];
    if (type == "brown") mainColor = Colors.brown;

    sharedPrefs.setString("colormain", type);
    notifyListeners();
  }
}
