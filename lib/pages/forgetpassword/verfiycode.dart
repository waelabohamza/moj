import 'package:flutter/material.dart';
import 'package:moj/component/alert.dart';
import 'package:moj/component/crud.dart';
import 'package:moj/component/valid.dart';
import 'package:moj/const.dart';
import 'package:moj/pages/forgetpassword/resetpassword.dart';
import 'package:moj/pages/linkapi.dart';

class VerfiyCode extends StatefulWidget {
  final email;
  VerfiyCode({Key key, this.email}) : super(key: key);

  @override
  _VerfiyCodeState createState() => _VerfiyCodeState();
}

class _VerfiyCodeState extends State<VerfiyCode> {
  //
  Crud crud = new Crud();
  bool isShowPass = true;
  // Key
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  //  Start Controller

  TextEditingController code = new TextEditingController();

  // Method

  verfiyCode() async {
    var formdata = formstate.currentState;
    if (formdata.validate()) {
      var data = {
        "email": widget.email,
        "code": code.text,
      };
      showLoading(context);
      var responsebody = await crud.writeData(linkVerfiyCode, data);
      if (responsebody['status'] == "success") {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
          return ResetPassword(email: widget.email) ;
        }));
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
        title: Text("رمز التاكيد"),
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
                  bulidTextForm(
                      "كود التفعيل", Icons.qr_code_sharp, code, "code"),
                  SizedBox(height: 40),
                  FlatButton(
                    color: Colors.grey[50],
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(color: mainColor, width: 2)),
                    onPressed: () {
                      verfiyCode();
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
        if (type == "code") {
          return validInput(val, 4, 6, "يكون كود التفعيل");
        }
        return null;
      },
      maxLength: 5,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(1),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          prefixIcon: Icon(icon),
          hintText: hint,
          hintStyle: TextStyle(fontSize: 14)),
    );
  }
}
