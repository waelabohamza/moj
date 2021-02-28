import 'package:flutter/material.dart';
import 'package:moj/component/valid.dart';
import 'package:moj/const.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isShowPass = true;
  // Key
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  //  Start Controller
  TextEditingController email = new TextEditingController();
  TextEditingController username = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController repassword = new TextEditingController();

  // Method

  signUp() async {
    var formdata = formstate.currentState;
    if(formdata.validate()){
       
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("انشاء الحساب"),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Form(
                child: Column(children: [
              bulidTextForm(
                  "البريد الالكتروني", Icons.email_outlined, email, "email"),
              SizedBox(height: 10),
              bulidTextForm(
                  "اسم المستخدم", Icons.person_outline, email, "username"),
              SizedBox(height: 10),
              bulidTextForm("رقم الهاتف", Icons.phone_android_outlined, email,
                  "username"),
              SizedBox(height: 10),
              bulidTextForm("كلمة المرور", Icons.lock_open, email, "password"),
              SizedBox(height: 40),
              FlatButton(
                color: Colors.grey[50],
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: mainColor, width: 2)),
                onPressed: () {
                  signUp();
                },
                child: Text("انشاء الحساب"),
              ),
              SizedBox(height: 20),
            ]))
          ],
        ),
      ),
    );
  }

  TextFormField bulidTextForm(hint, IconData icon, control, type) {
    return TextFormField(
      obscureText: type == "password" ? isShowPass : false,
      controller: control,
      validator: (val) {
        if (type == "email") {
          return validInput(val, 2, 60, "يكون البريد الالكتروني");
        }
        if (type == "username") {
          return validInput(val, 2, 60, "يكون اسم المستخدم");
        }
        if (type == "phone") {
          return validInput(val, 2, 60, "يكون رقم الهاتف");
        }
        if (type == "password") {
          return validInput(val, 2, 60, "تكون كلمة المرور");
        }
        return null;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(1),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          suffixIcon: type == "password"
              ? Icon(Icons.remove_red_eye_outlined)
              : SizedBox(),
          prefixIcon: Icon(icon),
          hintText: hint,
          hintStyle: TextStyle(fontSize: 14)),
    );
  }
}
