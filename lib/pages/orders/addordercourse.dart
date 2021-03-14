import 'package:flutter/material.dart';
import 'package:moj/const.dart';
import 'package:moj/main.dart';

class AddOrderCourse extends StatefulWidget {
  final courseid;
  AddOrderCourse({Key key, this.courseid}) : super(key: key);
  @override
  _AddOrderCourseState createState() => _AddOrderCourseState();
}

class _AddOrderCourseState extends State<AddOrderCourse> {

  String  course = "0";

  TextEditingController username = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController phone = new TextEditingController();

  @override
  void initState() {
    username.text = sharedPrefs.getString("username");
    email.text = sharedPrefs.getString("email");
    phone.text = sharedPrefs.getString("phone");
    super.initState();
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
                child: Column(
              children: [
                buildTextForm("ادخل الاسم ", Icons.person_add_alt, username),
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
                          value: "0",
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
                  onPressed:(){},
                  child: Text("صورة الهوية"),
                  color: Theme.of(context).primaryColor,
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
                  color: Theme.of(context).primaryColor,
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
