import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:moj/component/applocal.dart';
import 'package:moj/pages/auth/login.dart';
import 'package:moj/pages/home/home.dart';
import 'package:moj/routes.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences sharedPrefs;
String userid;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPrefs = await SharedPreferences.getInstance();
  userid = sharedPrefs.getString("id");
  runApp(MultiProvider(providers: [
     ChangeNotifierProvider(create: (context){
       return ChangeLocal() ; 
     })
  ],child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    FlutterStatusbarcolor.setStatusBarColor(Colors.red);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moj',
      theme: ThemeData(
        fontFamily: 'Cairo',
      ),
      home:userid == null ?  Login() : HomePage(),
      routes: routes,
      localizationsDelegates: [
        AppLocale.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale('en', ''), Locale('ar', '')],
      locale: Locale("ar", ""),
    );
  }
}


class ChangeLocal with ChangeNotifier {
  
}