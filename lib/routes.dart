import 'package:flutter/material.dart';
import 'package:moj/pages/courses/courses.dart';
// My Page 
import 'package:moj/pages/home/home.dart';
import 'package:moj/pages/orders/addordercourse.dart';
import 'package:moj/pages/orders/addorders.dart';
import 'package:moj/pages/questions/questions.dart';
import 'package:moj/pages/services/service.dart';
import 'package:moj/pages/services/services.dart';

Map<String, Widget Function(BuildContext)> routes  = {
  "home"  : (context) => HomePage() , 
  "services" : (context) => Services() , 
  "service" : (context) => Service() , 
  "addorders" : (context) => AddOrders()  ,
  "addordercourse" : (context) =>  AddOrderCourse()  , 
  "questions" : (context) => Questions()  ,
  "courses"   :(context) => Courses()
} ;