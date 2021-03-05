import 'package:flutter/material.dart';
import 'package:moj/const.dart';

class TopCardCenter extends StatelessWidget {
  final list ; 
  final mdw;
  const TopCardCenter({Key key, this.mdw , this.list}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Container(
          height: mdw / 1.6,
          width: double.infinity,
          decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(50))),
        ),
        Center(
          child: Card(
            child: Container(
              width: mdw / 1.2,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10, top: 10),
                    child: Text(
                      "الخدمات المفضلة",
                      style: TextStyle(color: Colors.grey[800], fontSize: 18),
                    ),
                  ),
                  IntrinsicHeight(
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: InkWell(
                             onTap: () {       
                                   Navigator.of(context).pushNamed("services") ; 
                            },
                                                      child: Container(
                                padding: EdgeInsets.all(mdw / 15),
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.home_repair_service_outlined,
                                      color: mainColor,
                                      size: 40,
                                    ),
                                    Text(
                                      "القضايا العمالية",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                )),
                          ),
                        ),
                        VerticalDivider(
                          color: Colors.grey,
                          thickness: 1,
                          width: 10,
                        ),
                        Expanded(
                          child: InkWell(
                             onTap: () {       
                                   Navigator.of(context).pushNamed("services") ; 
                            },
                                                      child: Container(
                                padding: EdgeInsets.all(mdw / 15),
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.home_repair_service_outlined,
                                      color: mainColor,
                                      size: 40,
                                    ),
                                    Text(
                                      "القضايا الاسرية",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey[400],
                    height: 0,
                    thickness: 1,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                              padding: EdgeInsets.all(mdw / 15),
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.home_repair_service_outlined,
                                    color: mainColor,
                                    size: 40,
                                  ),
                                  Text(
                                    "القضايا الايجارية ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              )),
                        ),
                        VerticalDivider(
                          color: Colors.grey,
                          thickness: 1,
                          width: 10,
                        ),
                        Expanded(
                          child: InkWell(
                             onTap: () {       
                                   Navigator.of(context).pushNamed("services") ; 
                            },
                                                      child: Container(
                                padding: EdgeInsets.all(mdw / 15),
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.home_repair_service_outlined,
                                      color: mainColor,
                                      size: 40,
                                    ),
                                    Text(
                                      "الامور المستعجلة",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey[400],
                    height: 0,
                    thickness: 1,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {       
                                   Navigator.of(context).pushNamed("services") ; 
                            },
                            child: Container(
                                padding: EdgeInsets.all(mdw / 15),

                                // decoration: BoxDecoration(
                                //     border: Border(
                                //         left: BorderSide(
                                //             color: Colors.grey[600]))),
                                // padding: EdgeInsets.symmetric(
                                //     horizontal: mdw / 10),
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.home_repair_service_outlined,
                                      color: mainColor,
                                      size: 40,
                                    ),
                                    Text(
                                      "القضايا المدنية",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                )),
                          ),
                        ),
                        VerticalDivider(
                          color: Colors.grey,
                          thickness: 1,
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                              padding: EdgeInsets.all(mdw / 15),
                              // padding: EdgeInsets.symmetric(horizontal: 10),

                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.home_repair_service_outlined,
                                    color: mainColor,
                                    size: 40,
                                  ),
                                  Text(
                                    "القضايا التجارية",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
        Positioned(
            bottom: -20,
            right: mdw / 3,
            left: mdw / 3,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () {
                Navigator.of(context).pushNamed("services");
              },
              color: Colors.red,
              textColor: Colors.white,
              child: Text("عرض الكل"),
            ))
      ],
    );
  }
}
