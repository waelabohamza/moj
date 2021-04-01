import 'dart:io';
import 'package:dropdown_search/dropdownSearch.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moj/component/alert.dart';
import 'package:moj/component/chooseimage.dart';
import 'package:moj/component/crud.dart';
import 'package:moj/component/myrequest.dart';
import 'package:moj/component/valid.dart';
import 'package:moj/main.dart';
import 'package:moj/pages/linkapi.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:moj/const.dart';

class AddOrders extends StatefulWidget {
  AddOrders({Key key}) : super(key: key);
  @override
  _AddOrdersState createState() => _AddOrdersState();
}

class _AddOrdersState extends State<AddOrders> {
  File filethree;
  File file;
  File filetwo;

  bool isLoadingGetPriceForService = false;

  Crud crud = new Crud();

  var servicename;

  List datadropdown = [];

  List datadropdownname = [];

  var fees;

  var typeprice;

  var serviceid;

  List listpricename = [];

  List listprice = [];

  var serviceprice;

  // For Filed

  TextEditingController username = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController aganist = new TextEditingController();

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  void getServiceName() async {
    var listData =
        await crud.writeData(linkServices, {"dropdownsearch": "true"});
    for (int i = 0; i < listData.length; i++)
      setState(() {
        datadropdown.add(listData[i]);
        datadropdownname.add(listData[i]['services_name']);
      });
  }

  getDataServicesPrice(String serviceid) async {
    listprice.clear();
    listpricename.clear();
    var listData =
        await crud.writeData(linkServicesprice, {"serviceid": serviceid});
    if (listData[0] != "falid") {
      for (int a = 0; a < listData.length; a++)
        setState(() {
          listprice.add(listData[a]);
          listpricename.add(listData[a]['servicesprice_name']);
        });
    }
    // print("data : $listData");
  }
  //

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

  addImageGallerythree() async {
    filethree = await myChooseGallery();
    setState(() {});
  }

  addImageCamerathree() async {
    filethree = await myChooseCamera();
    setState(() {});
  }

  addOrdersService() async {
    if (file == null)
      return showAlertOneChoose(
          context, "error", "خطأ", "الرجاءادخال صورة الهوية");
    if (serviceid == null)
      return showAlertOneChoose(
          context, "error", "خطأ", "الرجاء اختيار الخدمة اولا");
    if ((typeprice != null && typeprice != "0") && fees == null)
      return showAlertOneChoose(
          context, "error", "خطأ", "الرجاء اختيار السعر اولا");
    var formdata = formstate.currentState;
    if (formdata.validate()) {
      var data = {
        "username": username.text.toString(),
        "email": email.text.toString(),
        "phone": phone.text.toString(),
        "address": address.text.toString(),
        "against": aganist.text.toString(),
        "fees": fees.toString() ?? "0",
        "serviceid": serviceid.toString(),
        "userid": sharedPrefs.get("id")
      };
      var responsebody;
      if (filetwo == null && filethree == null) {
        showLoading(context);
        responsebody =
            await addRequestWithImageOne(linkAddOrdersService, data, file);
      } else if (filetwo != null && filethree != null) {
        showLoading(context);
        responsebody = await addRequestAndImageThree(
            linkAddOrdersService, data, file, filetwo, filethree);
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

  initalDataTextForm() {
    username.text = sharedPrefs.getString("username");
    email.text = sharedPrefs.getString("email");
    phone.text = sharedPrefs.getString("phone");
  }

  @override
  void initState() {
    super.initState();
    initalDataTextForm();
    getServiceName();
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
        child: datadropdown == null || datadropdown.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  Form(
                      key: formstate,
                      child: Column(
                        children: [
                          bulidTextForm("ادخل الاسم", Icons.person_add_alt,
                              username, "username"),
                          bulidTextForm("ادخل البريد الالكتروني",
                              Icons.mail_outline, email, "email"),
                          bulidTextForm(
                              "ادخل رقم الهاتف",
                              Icons.phone_bluetooth_speaker_outlined,
                              phone,
                              "phone"),
                          bulidTextForm("ادخل العنوان ",
                              Icons.location_city_outlined, address, "address"),
                          bulidTextForm("المطالب ضده ",
                              Icons.follow_the_signs_sharp, aganist, "against"),
                          DropdownSearch(
                            items: datadropdownname,
                            mode: Mode.MENU,
                            label: "ادخل هنا اسم الخدمة  الذي تريد",
                            onChanged: (val) async {
                              fees = null;
                              setState(() {
                                servicename = val;
                                serviceid = getDataByNameInListCat(
                                    val, datadropdown)['services_id'];
                                typeprice = getDataByNameInListCat(
                                    val, datadropdown)['services_typeprice'];
                                isLoadingGetPriceForService = true;
                              });
                              // showLoading(context);
                              await getDataServicesPrice(serviceid);
                              setState(() {
                                isLoadingGetPriceForService = false;
                              });
                              print(listpricename);
                            },
                            selectedItem: "اسم الخدمة",
                          ),
                          typeprice != null &&
                                  typeprice != "0" &&
                                  isLoadingGetPriceForService != true
                              ? DropdownSearch(
                                  items: listpricename,
                                  mode: Mode.MENU,
                                  label: "المبلغ المطالب به",
                                  // mode: Mode.BOTTOM_SHEET,
                                  onChanged: (val) async {
                                    setState(() {
                                      serviceprice = val;
                                      fees = getdataByNameInListserviceprice(
                                          val, listprice)['servicesprice_fees'];
                                      print(fees);
                                    });
                                    // setState(() {});
                                  },
                                  selectedItem: "المبلغ المطالب به",
                                )
                              : SizedBox(),
                          isLoadingGetPriceForService == true
                              ? Container(
                                  margin: EdgeInsets.all(15),
                                  child: Center(
                                      child: CircularProgressIndicator()))
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
                                  return showbottommenu(context,
                                      addImageCameratwo, addImageGallerytwo);
                                },
                                child: Text("صورة الرخصة"),
                                color: filetwo == null
                                    ? Theme.of(context).primaryColor
                                    : Colors.green,
                                textColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                              ),
                              MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  color: file == null
                                      ? Theme.of(context).primaryColor
                                      : Colors.green,
                                  textColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  onPressed: () {
                                    return showbottommenu(context,
                                        addImageCamera, addImageGallery);
                                  },
                                  child: Text("صورة الهوية")),
                            ],
                          ),
                          SizedBox(height: 20),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            onPressed: () async {
                              return showbottommenu(context,
                                  addImageCamerathree, addImageGallerythree);
                            },
                            child: Text("اضافة مستند غير الزامي"),
                            color: filethree == null
                                ? Theme.of(context).primaryColor
                                : Colors.green,
                            textColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 60, vertical: 5),
                          ),
                          SizedBox(height: 20),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            onPressed: () async {
                              String text =
                                  "اريد الاستفسار من اجل خدمات تطبيقاتكم";
                              String url =
                                  'https://api.whatsapp.com/send/?phone=$phonewhatsapp&text=$text&app_absent=0';
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("$textcontactwhatsapp"),
                                SizedBox(width: 10),
                                FaIcon(FontAwesomeIcons.whatsapp),
                              ],
                            ),
                            color: Colors.green,
                            textColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 60, vertical: 5),
                          ),
                          SizedBox(height: 20),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            onPressed: () {
                              addOrdersService();
                            },
                            child: Text("اضافة الطلب"),
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 60, vertical: 5),
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
          if (type == "email")
            return validInput(val, 2, 100, "يكون البريد الالكتروني", "email");
          if (type == "username")
            return validInput(val, 2, 100, "يكون اسم المستخدم");
          if (type == "phone")
            return validInput(val, 7, 12, "يكون رقم الهاتف", "phone");
          if (type == "address")
            return validInput(val, 2, 100, "يكون العنوان  ");
          if (type == "against")
            return validInput(val, 2, 100, "يكون المطالب ضده");
          return null;
        },
        keyboardType:
            type == "phone" ? TextInputType.number : TextInputType.text,
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
        list.where((element) => element['services_name'] == val).toList();
    return databyname[0];
  }

  getdataByNameInListserviceprice(String val, List list) {
    var databyname =
        list.where((element) => element['servicesprice_name'] == val).toList();
    return databyname[0];
  }
}
