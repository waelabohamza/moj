import 'package:flutter/material.dart';
import 'package:moj/component/alert.dart';
import 'package:moj/component/crud.dart';
import 'package:moj/component/valid.dart';
import 'package:moj/const.dart';
import 'package:moj/pages/forgetpassword/verfiycode.dart';
import 'package:moj/pages/linkapi.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({Key key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  //
  Crud crud = new Crud();
  bool isShowPass = true;
  // Key
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  //  Start Controller

  TextEditingController email = new TextEditingController();

  // Method

  forgetPassword() async {
    var formdata = formstate.currentState;
    if (formdata.validate()) {
      var data = {
        "email": email.text,
      };
      showLoading(context);
      var responsebody = await crud.writeData(linkCheckEmail, data);
      if (responsebody['status'] == "success") {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return VerfiyCode(email: email.text);
        }));
      } else {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
        var title = "خطأ" ; 
        var body = "البريد الالكتروني غير موجود" ; 
        showAlertOneChoose(context, "error"  , title  , body );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("التحقق من البريد الالكتروني"),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Form(
                key: formstate,
                child: Column(children: [
                  bulidTextForm("ادخل البريد الالكتروني هنا", Icons.email,
                      email, "email"),
                  SizedBox(height: 40),
                  FlatButton(
                    color: Colors.grey[50],
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(color: mainColor, width: 2)),
                    onPressed: () {
                      forgetPassword();
                    },
                    child: Text("تم"),
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
      controller: control,
      validator: (val) {
        if (type == "email") {
          return validInput(val, 2, 60, "يكون البريد الالكتروني");
        }
        return null;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(1),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          prefixIcon: Icon(icon),
          hintText: hint,
          hintStyle: TextStyle(fontSize: 14)),
    );
  }
}
