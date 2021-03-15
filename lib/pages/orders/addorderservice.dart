import 'package:dropdown_search/dropdownSearch.dart';
import 'package:flutter/material.dart';
import 'package:moj/const.dart';

class AddOrdersService extends StatefulWidget {
  AddOrdersService({Key key}) : super(key: key);

  @override
  _AddOrdersState createState() => _AddOrdersState();
}

class _AddOrdersState extends State<AddOrdersService> {
  var servicename;
  var catname;
  TextEditingController username = new TextEditingController();

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
                bulidTextForm("ادخل الاسم", Icons.person_add_alt, username, ""),
                bulidTextForm(
                    "ادخل البريد الالكتروني", Icons.mail_outline, username, ""),
                bulidTextForm("ادخل رقم الهاتف",
                    Icons.phone_bluetooth_speaker_outlined, username, ""),
                bulidTextForm("ادخل العنوان ", Icons.location_city_outlined,
                    username, ""),
                DropdownSearch( 
                  items: ["1000 - 10000", "10000 - 20000"],
                  label: "ادخل هنا اسم الخدمة  الذي تريد",
                  mode: Mode.BOTTOM_SHEET,
                  onChanged: (val) async {
                    setState(() {
                      servicename = val;
                    });
                    // setState(() {});
                  },
                  selectedItem: "اسم القسم",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      onPressed: () {},
                      child: Text("صورة الرخصة"),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    ),
                    MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        onPressed: () {},
                        child: Text("صورة الهوية")),
                  ],
                ),
                SizedBox(height: 20),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  onPressed: () {},
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

  Widget bulidTextForm(hint, IconData icon, control, type) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: control,
        validator: (val) {
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
      ),
    );
  }
}
