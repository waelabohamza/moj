import 'package:dropdown_search/dropdownSearch.dart';
import 'package:flutter/material.dart';
import 'package:moj/const.dart';

class AddOrderCourse extends StatefulWidget {
  AddOrderCourse({Key key}) : super(key: key);
  @override
  _AddOrderCourseState createState() => _AddOrderCourseState();
}

class _AddOrderCourseState extends State<AddOrderCourse> {
  bool course;
  List<String> datadropdowncatname = [
    "القسم 1",
    "القسم 2",
    "القسم 3 ",
    "القسم 4",
    "القسم 5",
  ];
  List<String> datadropdownservicename = [
    "الخدمة 1",
    "الخدمة 2",
    "الخدمة 3 ",
    "الخدمة 4",
    "الخدمة 5",
  ];
  var servicename;
  var catname;
  TextEditingController username = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text('اضافة طلب'),
      ),
      body: Container(
        child: ListView(
          children: [
            Form(
                child: Column(
              children: [
                buildTextForm("ادخل الاسم", Icons.person_add_alt, username),
                buildTextForm(
                    "ادخل البريد الالكتروني", Icons.mail_outline, username),
                buildTextForm("ادخل رقم الهاتف",
                    Icons.phone_bluetooth_speaker_outlined, username),
                Text("هل سبق ان دخلت مثل هذه الدورة "),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                          title: Text("نعم"),
                          value: true,
                          groupValue: course,
                          onChanged: (val) {
                            setState(() {
                              course = val;
                            });
                          }),
                    ),
                    Expanded(
                      child: RadioListTile(
                          title: Text("لا"),
                          value: false,
                          groupValue: course,
                          onChanged: (val) {
                            setState(() {
                              course = val;
                            });
                          }),
                    ),
                  ],
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  onPressed: () {},
                  child: Text("صورة الرخصة"),
                  color: mainColor,
                  textColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                ),
                SizedBox(height: 20),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  onPressed: () {
                    Navigator.of(context).pushNamed("addordercourse");
                  },
                  child: Text("اضافة الطلب"),
                  color: mainColor,
                  textColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 5),
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
          prefixIcon: Icon(icon),
          labelText: labeltext,
          filled: true,
          fillColor: Colors.white),
    );
  }
}
