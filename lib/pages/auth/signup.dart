import 'package:flutter/material.dart';
import 'package:moj/component/alert.dart';
import 'package:moj/component/crud.dart';
import 'package:moj/component/valid.dart';
import 'package:moj/const.dart';
import 'package:moj/pages/auth/approveuser.dart';
import 'package:moj/pages/linkapi.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //
  Crud crud = new Crud();
  bool isShowPass = true;
  // Key
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  //  Start Controller
  TextEditingController email = new TextEditingController();
  TextEditingController username = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController repassword = new TextEditingController();
  TextEditingController confirmPassword = new TextEditingController();

  // Method
  signUp() async {
    var formdata = formstate.currentState;
    if (formdata.validate()) {
      var data = {
        "email": email.text,
        "username": username.text,
        "password": password.text,
        "phone": phone.text
      };
      showLoading(context);
      var responsebody = await crud.writeData(linkSignUp, data);
      if (responsebody['status'] == "success") {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return ApproveUser(email: email.text);
        }));
      } else {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
        showAlertOneChoose(context, "error", "خطا", responsebody['cause']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("انشاء الحساب"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Form(
                key: formstate,
                child: Column(children: [
                  bulidTextForm("البريد الالكتروني", Icons.email_outlined,
                      email, "email"),
                  SizedBox(height: 10),
                  bulidTextForm("اسم المستخدم", Icons.person_outline, username,
                      "username"),
                  SizedBox(height: 10),
                  bulidTextForm("رقم الهاتف", Icons.phone_android_outlined,
                      phone, "phone"),
                  SizedBox(height: 10),
                  bulidTextForm(
                      "كلمة المرور", Icons.lock_open, password, "password"),
                  SizedBox(height: 10),
                  bulidTextForm("كلمة المرور مره اخرى", Icons.lock_open,
                      confirmPassword, "confirmpassword"),
                  SizedBox(height: 40),
                  MaterialButton(
                    color: Colors.grey[50],
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2)),
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
          return validInput(val, 2, 60, "يكون البريد الالكتروني", "email");
        }
        if (type == "username") {
          return validInput(val, 2, 60, "يكون اسم المستخدم");
        }
        if (type == "phone") {
          return validInput(val, 2, 60, "يكون رقم الهاتف", "phone");
        }
        if (type == "password") {
          return validInput(val, 2, 60, "تكون كلمة المرور");
        }
        if (type == "confirmpassword") {
          if (confirmPassword.text != password.text) {
            return "كلمة المرور غير متطابقة";
          }
        }
        return null;
      },
      keyboardType: type == "phone" ? TextInputType.number : TextInputType.text,
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
