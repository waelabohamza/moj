import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:moj/component/mydrawer.dart';
import 'package:moj/const.dart';
import 'package:moj/main.dart';
import 'package:moj/pages/home/homescreen.dart';
import 'package:moj/pages/services/service.dart';
 
 

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {







 
  int selectedindex = 0;
  int countcode = 40;
  // ScrollController scrollController;
  double sc = 0;

  GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }


  List<Widget> widgetsBottombar = [ 
         HomeScreen() , 
        //  Service() , 
        Text("Test") , 
        Text("Test") , 
        //  Services()
  ] ; 

  @override
  Widget build(BuildContext context) {
    double mdw = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        toolbarHeight: 50,
        elevation: 0,
        backgroundColor: mainColor,
        title: Text(
          "اجراءات",
          style: TextStyle(fontSize: 16),
        ),
        leading: IconButton(
          icon: Icon(Icons.segment),
          onPressed: () {
            scaffoldkey.currentState.openDrawer();
          },
        ),
        actions: [
          IconButton(icon: Icon(Icons.exit_to_app_outlined), onPressed: (){
            sharedPrefs.clear() ; 
            Navigator.of(context).pushReplacementNamed("login") ; 
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addorders") ; 
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      bottomNavigationBar: BubbleBottomBar(
        hasNotch: true,
        fabLocation: BubbleBottomBarFabLocation.end,
        opacity: .2,
        currentIndex: selectedindex,
        onTap: (index) {
          setState(() {
            selectedindex = index;
          });
        },
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(
                16)), //border radius doesn't work when the notch is enabled.
        elevation: 8,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                Icons.dashboard,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.dashboard,
                color: Colors.red,
              ),
              title: Text("الرئيسية")),
          BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
           Icons.theater_comedy,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.theater_comedy,
                color: Colors.red,
              ),
              title: Text("الثيم")),
          // BubbleBottomBarItem(
          //     backgroundColor: Colors.indigo,
          //     icon: Icon(
          //       Icons.folder_open,
          //       color: Colors.black,
          //     ),
          //     activeIcon: Icon(
          //       Icons.folder_open,
          //       color: Colors.indigo,
          //     ),
          //     title: Text("Folders")),
          BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                 Icons.addchart_sharp,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.addchart_sharp,
                color: Colors.red,
              ),
              title: Text("الطلبات"))
        ],
      ),
      drawer: MyDrawer(),
      body:widgetsBottombar.elementAt(selectedindex),
    );
  }
}


/*
1 - الاسم 
2 - البريد 
3 - الرقم 
4 - العنوان
5-  دروب دون   شركات   فردي   جزائي 
6 - دروب دون  الاقسام يلي داخل يلي اختارو مثال افلاس اعادة هيكلة اختلاس 
7 - دروب دون السعر 


الشركات الجد  الاب الاقسام مثال 
*/