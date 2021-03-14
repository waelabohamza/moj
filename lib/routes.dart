import 'package:flutter/material.dart';
import 'package:moj/pages/auth/login.dart';
// My Page
import 'package:moj/pages/auth/signup.dart';
import 'package:moj/pages/forgetpassword/forgetpassword.dart';
import 'package:moj/pages/home/home.dart';
import 'package:moj/pages/orders/addordercourse.dart';
import 'package:moj/pages/orders/addorders.dart';
import 'package:moj/pages/orders/myorders.dart';
import 'package:moj/pages/questions/question.dart';
import 'package:moj/pages/services/services.dart';

Map<String, Widget Function(BuildContext)> routes = {
  "home": (context) => HomePage(),
  "services": (context) => Services(),
  "addorders": (context) => AddOrders(),
  "addordercourse": (context) => AddOrderCourse(),
  "questions": (context) => Question(),
  "login": (context) => Login(),
  "signup": (context) => SignUp(),
  "forgetPassword": (context) => ForgetPassword() , 
  "myorders" : (context) => MyOrders() 
};
