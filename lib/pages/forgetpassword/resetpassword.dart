import 'package:flutter/material.dart';
import 'package:moj/component/alert.dart';
import 'package:moj/component/crud.dart';
import 'package:moj/component/valid.dart';
import 'package:moj/const.dart';
import 'package:moj/pages/linkapi.dart';

class ResetPassword extends StatefulWidget {
  final email;
  ResetPassword({Key key, this.email}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  //
  Crud crud = new Crud();
  bool isShowPass = true;
  // Key
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  //  Start Controller

  TextEditingController password = new TextEditingController();

  // Method

  resetPassword() async {
    var formdata = formstate.currentState;
    if (formdata.validate()) {
      var data = {"email": widget.email, "password": password.text};
      showLoading(context);
      var responsebody = await crud.writeData(linkResetPassword, data);
      if (responsebody['status'] == "success"){
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
        Navigator.of(context).pushReplacementNamed("home");
      } else {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
        showAlertOneChoose(context, "error", "خطأ", "الرجاء المحاولة مره اخرى");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("اعادة تعيين كلمة المرور"),
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
                  bulidTextForm("ادخل كلمة المرور الجديدة هنا", Icons.lock_open_outlined,
                      password, "password"),
                  SizedBox(height: 40),
                  FlatButton(
                    color: Colors.grey[50],
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(color: mainColor, width: 2)),
                    onPressed: () {
                      resetPassword();
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

  TextFormField bulidTextForm(hint, IconData icon, control, type){
    return TextFormField(
      obscureText: isShowPass,
      controller: control,
      validator: (val) {
        if (type == "password") {
          return validInput(val, 2, 60, "تكون كلمة المرور");
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
