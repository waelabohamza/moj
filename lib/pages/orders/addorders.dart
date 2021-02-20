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
      "القسم 1"  , 
      "القسم 2"  , 
      "القسم 3 "  , 
      "القسم 4"  , 
      "القسم 5"  , 
  ] ; 
    List<String> datadropdownservicename = [
      "الخدمة 1"  , 
      "الخدمة 2"  , 
      "الخدمة 3 "  , 
      "الخدمة 4"  , 
      "الخدمة 5"  , 
  ] ; 
  var servicename ; 
  var catname ; 
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
                buildTextForm(
                    "ادخل العنوان ", Icons.location_city_outlined, username),
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
                    RaisedButton(
                      onPressed: () {},
                      child: Text("صورة الرخصة"),
                      color: mainColor,
                      textColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    ),
                    RaisedButton(
                        color: mainColor,
                        textColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        onPressed: () {},
                        child: Text("صورة الهوية")),
                  ],
                ),
                SizedBox(height: 20),
                RaisedButton(
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
