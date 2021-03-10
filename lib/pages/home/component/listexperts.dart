import 'package:flutter/material.dart';
import 'package:moj/pages/linkapi.dart';

class ListExperts extends StatelessWidget {
  final mdw;
  final list;
  const ListExperts({Key key, this.mdw, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: mdw / 15),
      height: 120,
      child: ListView.builder(
          itemCount: list.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            return InkWell(
              onTap: () {},
              child: Container(
                width: mdw / 3,
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 3,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            height: 100,
                            padding: EdgeInsets.all(10),
                            child: Image.network(
                              "$linkRootImage/experts/${list[i]['experts_image']}",
                              fit: BoxFit.fill,
                              width: 75,
                              height: 100,
                            )),
                        Text(
                          "${list[i]['experts_name']}",
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "${list[i]['experts_spec']}",
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),
              ),
            );
          }),
    );
  }
}
