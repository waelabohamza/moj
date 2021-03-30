import 'dart:io';
import 'package:moj/component/myrequest.dart'     ;
import 'package:moj/component/valid.dart'         ;
import 'package:moj/pages/home/home.dart'         ;
import 'package:moj/pages/linkapi.dart'           ;
import 'package:flutter/material.dart'            ;
import 'package:moj/component/alert.dart'         ;  
import 'package:moj/component/chooseimage.dart'   ;
import 'package:moj/const.dart'                   ;
import 'package:moj/main.dart'                    ;
import 'package:url_launcher/url_launcher.dart'   ;

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

  initalDataTextForm() {
    username.text = sharedPrefs.getString("username");
    email.text = sharedPrefs.getString("email");
    phone.text = sharedPrefs.getString("phone");
  }

  @override
  void initState() {
    initalDataTextForm();
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
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return HomePage(
            initialpage: 2,
          );
        }));
      } else {
        if (Navigator.of(context).canPop()) Navigator.of(context).pop();

        showAlertOneChoose(context, "error", "خطأ", "حاول مره اخرى");
      }
    } else {
      print("Not Vaild");
    }
  }

  @override
  void dispose() { 
    username.dispose()  ; 
    email.dispose();  
    phone.dispose() ; 
    super.dispose();
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
                    buildTextForm("ادخل الاسم ", Icons.person_add_alt, username,
                        "username"),
                    SizedBox(height: 10),
                    buildTextForm("ادخل البريد الالكتروني", Icons.mail_outline,
                        email, "email"),
                    SizedBox(height: 10),
                    buildTextForm("ادخل رقم الهاتف",
                        Icons.phone_bluetooth_speaker_outlined, phone, "phone"),
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
                    SizedBox(height: 20),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      onPressed: () async {
                        String text = "اريد الاستفسار من اجل خدمات تطبيقاتكم";
                        String url =
                            'https://api.whatsapp.com/send/?phone=$phonewhatsapp&text=$text&app_absent=0';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Text("$textcontactwhatsapp"),
                      color: Colors.green,
                      textColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 60, vertical: 5),
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      onPressed: () {
                        return showbottommenu(
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

  buildTextForm(labeltext, icon, mycontroller, type) {
    return TextFormField(
      validator: (val) {
        if (type == "email")
          return validInput(val, 2, 100, "يكون البريد الالكتروني", "email");
        if (type == "username")
          return validInput(val, 2, 100, "يكون اسم المستخدم");
        if (type == "phone")
          return validInput(val, 7, 12, "يكون رقم الهاتف", "phone");
        return null;
      },
      keyboardType: type == "phone" ? TextInputType.number : TextInputType.text,
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
