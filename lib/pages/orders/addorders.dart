import 'package:dropdown_search/dropdownSearch.dart';
import 'package:flutter/material.dart';
import 'package:moj/component/crud.dart';
import 'package:moj/pages/linkapi.dart';

class AddOrders extends StatefulWidget {
  AddOrders({Key key}) : super(key: key);

  @override
  _AddOrdersState createState() => _AddOrdersState();
}

class _AddOrdersState extends State<AddOrders> {
  Crud crud = new Crud();

  var servicename;

  List datadropdown = [];

  List datadropdownname = [];

  void getServiceName() async {
    var listData =
        await crud.writeData(linkServices, {"dropdownsearch": "true"});
    for (int i = 0; i < listData.length; i++)
      setState(() {
        datadropdown.add(listData[i]);
        datadropdownname.add(listData[i]['services_name']);
      });
  }
  //

  @override
  void initState() {
    super.initState();
    getServiceName();
  }

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
        child: datadropdown == null
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  Form(
                      child: Column(
                    children: [
                      bulidTextForm(
                          "ادخل الاسم", Icons.person_add_alt, username, ""),
                      bulidTextForm("ادخل البريد الالكتروني",
                          Icons.mail_outline, username, ""),
                      bulidTextForm("ادخل رقم الهاتف",
                          Icons.phone_bluetooth_speaker_outlined, username, ""),
                      bulidTextForm("ادخل العنوان ",
                          Icons.location_city_outlined, username, ""),
                      DropdownSearch(
                        items: datadropdownname,
                        label: "ادخل هنا اسم الخدمة  الذي تريد",
                        mode: Mode.BOTTOM_SHEET,
                        onChanged: (val) async {
                          setState(() {
                            servicename = val;
                          });
                        },
                        selectedItem: "اسم الخدمة",
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                          ),
                          MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
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

  getDataByNameInListCat(String val, List list) {
    var databyname =
        list.where((element) => element['servicesprice_name'] == val).toList();
    return databyname[0];
  }
}
