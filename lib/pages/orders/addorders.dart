import 'package:dropdown_search/dropdownSearch.dart';
import 'package:flutter/material.dart';
import 'package:moj/const.dart';

class AddOrders extends StatefulWidget {
  AddOrders({Key key}) : super(key: key);

  @override
  _AddOrdersState createState() => _AddOrdersState();
}

class _AddOrdersState extends State<AddOrders> {
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
                  items: datadropdowncatname,
                  label: "ادخل هنا اسم القسم  الذي تريد",
                  mode: Mode.BOTTOM_SHEET,
                  onChanged: (val) async {
                    setState(() {
                      catname = val;
                    });

                    // setState(() {});
                  },
                  selectedItem: "اسم الخدمة",
                ),
                DropdownSearch(
                  items: datadropdownservicename,
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
                      color: mainColor,
                      textColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    ),
                    MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        color: mainColor,
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
