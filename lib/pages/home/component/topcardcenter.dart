import 'package:flutter/material.dart';
import 'package:moj/const.dart';
import 'package:moj/pages/services/service.dart';

class TopCardCenter extends StatelessWidget {
  final list;
  final mdw;
  const TopCardCenter({Key key, this.mdw, this.list}) : super(key: key);
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
                      children: [
                        buildService(context, list[0]),
                        VerticalDivider(
                          color: Colors.grey,
                          thickness: 1,
                          width: 10,
                        ),
                        buildService(context, list[1]),
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
                      children: [
                        buildService(context, list[2]),
                        VerticalDivider(
                          color: Colors.grey,
                          thickness: 1,
                          width: 10,
                        ),
                        buildService(context, list[3]),
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
                      children: [
                        buildService(context, list[4]),
                        VerticalDivider(
                          color: Colors.grey,
                          thickness: 1,
                          width: 10,
                        ),
                        buildService(context, list[5]),
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

  buildService(context, service) {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return Service(list: service);
          }));
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
                  "${service['services_name']}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                )
              ],
            )),
      ),
    );
  }
}
