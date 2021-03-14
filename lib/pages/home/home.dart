import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moj/component/mydrawer.dart';
import 'package:moj/main.dart';
import 'package:moj/pages/home/homescreen.dart';
import 'package:moj/pages/home/themecolors.dart';
import 'package:moj/pages/orders/myorders.dart';

class HomePage extends StatefulWidget {
  final initialpage;
  HomePage({Key key, this.initialpage}) : super(key: key);

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
    selectedindex = widget.initialpage != null
        ? int.parse(widget.initialpage.toString())
        : 0;
    super.initState();
  }

  List<Widget> widgetsBottombar = [
    HomeScreen(),
    ThemeColors(),
    MyOrders()
    //  Services()
  ];

  @override
  Widget build(BuildContext context) {
    double mdw = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        titleSpacing: 0,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.red),
        shape: Border.all(width: 0, color: Theme.of(context).primaryColor),
        toolbarHeight: 50,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
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
          IconButton(
              icon: Icon(Icons.exit_to_app_outlined),
              onPressed: () {
                sharedPrefs.clear();
                Navigator.of(context).pushReplacementNamed("login");
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addorders");
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
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
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(
                Icons.dashboard,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.dashboard,
                color: Theme.of(context).primaryColor,
              ),
              title: Text("الرئيسية")),
          BubbleBottomBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(
                Icons.theater_comedy,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.theater_comedy,
                color: Theme.of(context).primaryColor,
              ),
              title: Text("الثيم")),
          BubbleBottomBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(
                Icons.addchart_sharp,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.addchart_sharp,
                color: Theme.of(context).primaryColor,
              ),
              title: Text("الطلبات"))
        ],
      ),
      drawer: MyDrawer(),
      body: widgetsBottombar.elementAt(selectedindex),
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
