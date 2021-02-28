import 'package:flutter/material.dart';
import 'package:moj/component/valid.dart';
import 'package:moj/const.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{

  // KEY FORM
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  // Controller 
  TextEditingController email    = new TextEditingController();
  TextEditingController password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Center(
              child: Image.asset(
                "images/avatar.png",
                height: 120,
                width: 120,
              ),
            ),
            Center(
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  Text(
                    "ALBALLAM",
                    style: TextStyle(fontSize: 30),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 60,
                    child: Text(
                      "Group",
                      style: TextStyle(fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
            Form(
                key: formstate,
                child: Column(children: [
                  SizedBox(height: 20),
                  bulidTextForm("البريد الالكتروني", Icons.email_outlined,
                      email, "email"),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline),
                        suffixIcon: Icon(Icons.remove_red_eye_outlined),
                        hintStyle: TextStyle(fontSize: 14),
                        hintText: "كلمة المرور"),
                  ),
                  SizedBox(height: 30),
                  FlatButton(
                    color: Colors.grey[50],
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(color: mainColor, width: 2)),
                    onPressed: () {},
                    child: Text("تسجيل الدخول"),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {},
                    child: Text("هل نسيت كلمة المرور"),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed("signup");
                    },
                    child: Text("انشاء حساب جديد"),
                  ),
                ]))
          ],
        ),
      ),
    );
  }

  TextFormField bulidTextForm(hint, IconData icon, control, type) {
    return TextFormField(
      controller: control,
      validator: (val) {
        if (type == "email") {
          return validInput(val, 2, 60, "يكون البريد الالكتروني");
        }
        return null;
      },
      decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hint,
          hintStyle: TextStyle(fontSize: 14)),
    );
  }
}
