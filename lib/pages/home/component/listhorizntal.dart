import 'package:flutter/material.dart';
import 'package:moj/const.dart';
import 'package:moj/pages/services/service.dart';

class ListHorzintal extends StatelessWidget {
  final type;
  final mdw;
  final list;
  const ListHorzintal({Key key, this.mdw, this.list, this.type})
      : super(key: key);

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
              onTap: () {
                if (type == "service") {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                     return Service(list: list[i]) ; 
                  }));
                } else if (type == "questions") {
                  Navigator.of(context).pushNamed("questions");
                } else {
                  Navigator.of(context).pushNamed("courses");
                }
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
                            height: 60,
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.image_search_sharp,
                              color: mainColor,
                              size: 40,
                            )),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                           type == "service" ?  list[i]['services_name']
                           : type == "questions" ? list[i]['questions_name'] : 
                           type == "courses" ? list[i]['courses_name'] : 
                           "sew"
                           ,
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    )),
              ),
            );
          }),
    );
  }
}
