import 'package:flutter/material.dart';
import 'api_models.dart';
import 'show_dialog.dart';
import 'api_provider.dart';

class Homes extends StatefulWidget {
  @override
  _HomesState createState() => _HomesState();
}

class _HomesState extends State<Homes> {
  API_Providers news = new API_Providers();
  List<ApiModel> allList = new List();
  GlobalKey<RefreshIndicatorState> refresKeys =
      new GlobalKey<RefreshIndicatorState>();
  GlobalKey<FormState> formKeys = new GlobalKey<FormState>();

  void getThem() async {
    List<ApiModel> jsonsB = await news.getBoards();
    // dengan forEach
    jsonsB.forEach((f) {
      setState(() {
        allList.add(ApiModel(name: f.name, id: f.id, desc: f.desc));
      });
    });
    print(allList.length);
  }

  @override
  void initState() {
    super.initState();
    this.getThem();
  }

  Widget loading({Widget body}) {
    if (allList.length == 0 || body == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        body: body,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            post_update(context, formKeys, refresKeys);
          },
          child: Icon(Icons.add),
        ),
      );
    }
  }

  void restars() async {
    allList.clear();
    getThem();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        key: refresKeys,
        onRefresh: () async {
          return restars();
        },
        child: loading(
            body: ListView.builder(
          itemCount: allList.length,
          itemBuilder: (context, index) {
            return FlatButton(
              child: Card(
                child: ListTile(
                    title: Text('name : ' + allList[index].name),
                    subtitle: Text('desc : ' + allList[index].desc),
                    trailing: Container(
                        width: 40,
                        child: FlatButton(
                          child: Icon(Icons.delete),
                          onPressed: () {
                            delete(context, formKeys, refresKeys,
                                models: allList[index]);
                          },
                        ))),
              ),
              onPressed: () {
                post_update(context, formKeys, refresKeys,
                    models: allList[index]);
              },
            );
          },
        )),
      ),
    );
  }
}

// class Homes extends StatefulWidget {
//   @override
//   _HomesState createState() => _HomesState();
// }

// class _HomesState extends State<Homes> {
//   API_Providers news = new API_Providers();
//   List<ApiModel> allList = new List();
//   List<ApiModel> jsonsB;
//   String dolls;
//   GlobalKey<RefreshIndicatorState> refresKeys =
//       new GlobalKey<RefreshIndicatorState>();

//   @override
//   void initState() {
//     super.initState();
//     this.getThem();
//   }

//   Widget loading({Widget body}) {
//     if (allList.length == 0 || body == null) {
//       return Center(
//         child: CircularProgressIndicator(),
//       );
//     } else {
//       return body;
//     }
//   }

//   void restars() async {
//     allList.clear();
//     getThem();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: RefreshIndicator(
//         key: refresKeys,
//         onRefresh: () async {
//           return restars();
//         },
//         child: loading(
//             body: ListView.builder(
//           itemCount: allList.length,
//           itemBuilder: (context, index) {
//             return Card(
//               child: ListTile(
//                   // Text('id : ' + allList[index].id),
//                   title: Text('name : ' + allList[index].name),
//                   subtitle: Text('desc : ' + allList[index].desc)),
//             );
//           },
//         )),
//       ),
//     );
//   }
// }

// class Homes extends StatefulWidget {
//   @override
//   _HomesState createState() => _HomesState();
// }

// class _HomesState extends State<Homes> {
//   API_Providers prov;
//   GlobalKey<FormState> formKeys = new GlobalKey<FormState>();
// GlobalKey<RefreshIndicatorState> refresKeys =
//     new GlobalKey<RefreshIndicatorState>();

//   @override
//   void initState() {
//     super.initState();
//     prov = API_Providers();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Future<List<ApiModels>> allList = prov.getBoards();
//     void restAgain() {
//       setState(() {
//         allList = prov.getBoards();
//       });
//     }

//     return Scaffold(
//         appBar: AppBar(title: Text('Todolist Trello')),
//         floatingActionButton: FloatingActionButton(
//           child: Icon(Icons.add),
//           onPressed: () {
//             setState(() {
//               alertDialog(context, formKeys, refresKeys, models: null);
//             });
//           },
//         ),
//         body: Padding(
//             padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
//             child: RefreshIndicator(
//                 key: refresKeys,
//                 onRefresh: () async {
//                   return restAgain();
//                 },
//                 child: FutureBuilder(
//                     future: allList,
//                     builder: (BuildContext context,
//                         AsyncSnapshot<List<ApiModels>> snapshot) {
//                       if (snapshot.hasError) {
//                         return Center(
//                           child: Text(
//                               'something wrong : ${snapshot.error.toString()}'),
//                         );
//                       } else if (snapshot.connectionState ==
//                           ConnectionState.done) {
//                         List<ApiModels> profiles = snapshot.data;
//                         return Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 8.0, horizontal: 16.0),
//                             child: ListView.builder(
//                               itemCount: profiles.length,
//                               itemBuilder: (context, index) {
//                                 ApiModels profile = profiles[index];
//                                 return RaisedButton(
//                                   child: ListTile(
//                                     title: Text(profile.name),
//                                     subtitle: Text(profile.desc),
//                                   ),
//                                   onPressed: () {
//                                     alertConfirm(
//                                         context, formKeys, refresKeys, profile);
//                                   },
//                                 );
//                               },
//                             ));
//                       } else {
//                         return Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       }
//                     }))));
//   }
// }
