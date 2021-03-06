import 'package:flutter/material.dart';
import 'package:moj/const.dart';
import 'package:moj/pages/services/services.dart';

class ListBottom extends StatelessWidget {
  final list;
 
  final mdw;
  const ListBottom({Key key, this.mdw, this.list})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Services(index: i, categories: list , catid : list[i]['categories_id']);
              }));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: mdw / 14),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${list[i]['categories_name_ar']}",
                              style: TextStyle(fontSize: 16, color: mainColor),
                            ),
                            Text(
                              "${list[i]['categories_desc_ar']}",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 3),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RaisedButton(
                            color: mainColor,
                            textColor: Colors.white,
                            onPressed: () {},
                            child: Text(
                              "ابدا الخدمة",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
