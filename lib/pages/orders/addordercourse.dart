import 'dart:io';
import 'package:moj/component/myrequest.dart';
import 'package:moj/pages/home/home.dart';
import 'package:moj/pages/linkapi.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:moj/component/alert.dart';
import 'package:moj/component/chooseimage.dart';
import 'package:moj/const.dart';
import 'package:moj/main.dart';

class AddOrderCourse extends StatefulWidget {
  final courseid;
  AddOrderCourse({Key key, this.courseid}) : super(key: key);
  @override
  _AddOrderCourseState createState() => _AddOrderCourseState();
}

class _AddOrderCourseState extends State<AddOrderCourse> {
  
  File file;

  String courseback = "0";

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  TextEditingController username = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController phone = new TextEditingController();

  addImageGallery() async {
    file = await myChooseGallery();
    setState(() {});
  }

  addImageCamera() async {
    file = await myChooseCamera();
    setState(() {});
  }

  @override
  void initState() {
    username.text = sharedPrefs.getString("username");
    email.text = sharedPrefs.getString("email");
    phone.text = sharedPrefs.getString("phone");
    super.initState();
  }

  addOrderCourse(context) async {
    if (file == null)
      return showAlertOneChoose(
          context, "error", "هام", "الرجاء اضافة صورة الهوية");
    if (widget.courseid == null)
      return showAlertOneChoose(
          context, "error", "خطأ", "الرجاء المحاولة مره اخرى");
    var formdata = formstate.currentState;
    if (formdata.validate()) {
      var data = {
        "username": username.text,
        "phone": phone.text,
        "email": email.text,
        "userid": sharedPrefs.getString("id"),
        "courseid": widget.courseid,
        "courseback": courseback.toString()
      };

      showLoading(context);

      var response = await addRequestWithImageOne(linkOrdersCourse, data, file);

      if (response['status'] == "success") {
         
         Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return HomePage(initialpage: 2,) ; 
         })) ; 
     
      }else{

        if (Navigator.of(context).canPop()) Navigator.of(context).pop() ; 

        showAlertOneChoose(context, "error", "خطأ", "حاول مره اخرى") ; 


      }

    } else {
      print("Not Vaild");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('اضافة طلب'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Form(
                key: formstate,
                child: Column(
                  children: [
                    buildTextForm(
                        "ادخل الاسم ", Icons.person_add_alt, username),
                    SizedBox(height: 10),
                    buildTextForm(
                        "ادخل البريد الالكتروني", Icons.mail_outline, email),
                    SizedBox(height: 10),
                    buildTextForm("ادخل رقم الهاتف",
                        Icons.phone_bluetooth_speaker_outlined, phone),
                    SizedBox(height: 10),
                    Text("هل سبق ان دخلت مثل هذه الدورة "),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                              title: Text("نعم"),
                              value: "1",
                              groupValue: courseback,
                              onChanged: (val) {
                                setState(() {
                                  courseback = val;
                                });
                              }),
                        ),
                        Expanded(
                          child: RadioListTile(
                              title: Text("لا"),
                              value: "0",
                              groupValue: courseback,
                              onChanged: (val) {
                                setState(() {
                                  courseback = val;
                                });
                              }),
                        ),
                      ],
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      onPressed: () {
                       return  showbottommenu(
                            context, addImageCamera, addImageGallery);
                      },
                      child: Text("صورة الهوية "),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    ),
                    SizedBox(height: 20),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      onPressed: () async {
                        await addOrderCourse(context);
                      },
                      child: Text("اضافة الطلب"),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 60, vertical: 5),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  buildTextForm(labeltext, icon, mycontroller) {
    return TextFormField(
      validator: (val) {
        return null;
      },
      controller: mycontroller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(1),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        prefixIcon: Icon(icon),
        labelText: labeltext,
        // filled: true,
        // fillColor: Colors.white
      ),
    );
  }
}
