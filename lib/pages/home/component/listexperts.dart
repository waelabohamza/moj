import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moj/pages/experts/expert.dart';
import 'package:moj/pages/linkapi.dart';

class ListExperts extends StatelessWidget {
  final mdw;
  final list;
  const ListExperts({Key key, this.mdw, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: mdw / 15),
      height: 140,
      child: ListView.builder(
          itemCount: list.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i){
            return InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return Expert(list: list[i]);
                }));
              },
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
                            height: 75,
                            padding: EdgeInsets.all(10),
                            child: CachedNetworkImage(
                              placeholder: (context, e) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, st, w) => Text("ERROR"),
                              imageUrl:
                                  "$linkRootImage/experts/${list[i]['experts_image']}",
                              fit: BoxFit.fill,
                              width: 75,
                              height: 75,
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
