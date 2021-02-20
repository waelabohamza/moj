import 'package:flutter/material.dart';
// My Page 
import 'package:moj/pages/home/home.dart';
import 'package:moj/pages/orders/addorders.dart';
import 'package:moj/pages/services/service.dart';
import 'package:moj/pages/services/services.dart';

Map<String, Widget Function(BuildContext)> routes  = {
  "home"  : (context) => HomePage() , 
  "services" : (context) => Services() , 
  "service" : (context) => Service() , 
  "addorders" : (context) => AddOrders()
} ;