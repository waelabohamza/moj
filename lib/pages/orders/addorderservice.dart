import 'dart:io';
import 'package:dropdown_search/dropdownSearch.dart';
import 'package:flutter/material.dart';
import 'package:moj/component/alert.dart';
import 'package:moj/component/chooseimage.dart';
import 'package:moj/component/crud.dart';
import 'package:moj/component/myrequest.dart';
import 'package:moj/main.dart';
import 'package:moj/pages/linkapi.dart';

class AddOrdersService extends StatefulWidget {
  final typeprice;
  final servicesid;
  AddOrdersService({Key key, this.servicesid, this.typeprice})
      : super(key: key);
  @override
  _AddOrdersState createState() => _AddOrdersState();
}

class _AddOrdersState extends State<AddOrdersService> {
  File file;
  File filetwo;
  Crud crud = new Crud();
  var servicename;

  var fees;

  TextEditingController username = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController aganist = new TextEditingController();

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  List listprice = [];
  List listpricename = [];

  getDataServicesPrice() async {
    var listData = await crud.writeData(
        linkServicesprice, {"serviceid": widget.servicesid.toString()});
    if (listData[0] != "falid") {
      for (int a = 0; a < listData.length; a++)
        setState(() {
          listprice.add(listData[a]);
          listpricename.add(listData[a]['servicesprice_name']);
        });
    }
    // print("data : $listData");
  }

  addImageGallery() async {
    file = await myChooseGallery();
    setState(() {});
  }

  addImageCamera() async {
    file = await myChooseCamera();
    setState(() {});
  }

  addImageGallerytwo() async {
    filetwo = await myChooseGallery();
    setState(() {});
  }

  addImageCameratwo() async {
    filetwo = await myChooseCamera();
    setState(() {});
  }

  initalData() {
    username.text = sharedPrefs.getString("username");
    email.text = sharedPrefs.getString("email");
    phone.text = sharedPrefs.getString("phone");
  }

  addOrdersService() async {
    if (file == null)
      return showAlertOneChoose(
          context, "error", "خطأ", "الرجاءادخال صورة الهوية");

    var formdata = formstate.currentState;

    if (formdata.validate()) {
      var data = {
        "username": username.text.toString(),
        "email": email.text.toString(),
        "phone": phone.text.toString(),
        "address": address.text.toString(),
        "against": aganist.text.toString(),
        "fees": fees.toString() ?? "0",
        "serviceid": widget.servicesid.toString(),
        "userid": sharedPrefs.get("id")
      };
      var responsebody;
      if (filetwo == null) {
        showLoading(context);
        responsebody =
            await addRequestWithImageOne(linkAddOrdersService, data, file);
      } else {
        showLoading(context);
        responsebody = await addRequestAndImageTwo(
            linkAddOrdersService, data, file, filetwo);
      }
      if (responsebody['status'] == "success") {
        Navigator.of(context).pushReplacementNamed("home");
      } else {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }

        showAlertOneChoose(context, "error", "خطا", "الرجاء المحاولة مره اخرى");
      }
    }
  }

  @override
  void initState() {
    initalData();
    getDataServicesPrice();
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
                key: formstate,
                child: Column(
                  children: [
                    buildTextForm("ادخل الاسم", Icons.person_add_alt, username),
                    SizedBox(height: 10),
                    buildTextForm(
                        "ادخل البريد الالكتروني", Icons.mail_outline, email),
                    SizedBox(height: 10),
                    buildTextForm("ادخل رقم الهاتف",
                        Icons.phone_bluetooth_speaker_outlined, phone),
                    SizedBox(height: 10),
                    buildTextForm(
                        "ادخل العنوان ", Icons.location_city_outlined, address),
                    SizedBox(height: 10),
                    buildTextForm(
                        "المطالب ضده ",
                        Icons
                            .signal_cellular_connected_no_internet_4_bar_outlined,
                        aganist),
                    SizedBox(height: 10),
                    int.parse(widget.typeprice.toString()) == 1
                        ? DropdownSearch(
                            items: listpricename,
                            label: "المبلغ المطالب به",
                            // mode: Mode.BOTTOM_SHEET,
                            onChanged: (val) async {
                              setState(() {
                                servicename = val;
                                fees = getDataByNameInListCat(
                                    val, listprice)['servicesprice_fees'];
                              });
                              // setState(() {});
                            },
                            selectedItem: "اسم القسم",
                          )
                        : SizedBox(),
                    fees != null
                        ? Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            child: Center(
                                child: Text(
                              "رسوم الخدمة : $fees",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                            )))
                        : SizedBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          onPressed: () {
                            return showbottommenu(
                                context, addImageCameratwo, addImageGallerytwo);
                          },
                          child: Text("صورة الرخصة"),
                          color:filetwo == null ?  Theme.of(context).primaryColor : Colors.green,
                          textColor: Colors.white,
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        ),
                        MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            color: file == null ?  Theme.of(context).primaryColor : Colors.green,
                            textColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            onPressed: () {
                              return showbottommenu(context, addImageCamera,
                                  addImageGallery);
                            },
                            child: Text("صورة الهوية")),
                      ],
                    ),
                    SizedBox(height: 20),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      onPressed: () async {
                        await addOrdersService();
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

  Widget buildTextForm(labeltext, icon, mycontroller) {
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

  getDataByNameInListCat(String val, List list) {
    var databyname =
        list.where((element) => element['servicesprice_name'] == val).toList();
    return databyname[0];
  }
}
