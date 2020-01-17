// import 'package:flutter/material.dart';
// import 'package:trello_todolist/api_models.dart';
// import 'api_provider.dart';

// TextEditingController label = new TextEditingController();
// TextEditingController desc = new TextEditingController();
// double paddingSize = 8.0;

// alertDialog(BuildContext context, GlobalKey<FormState> formKeys,
//     GlobalKey<RefreshIndicatorState> refresKeys,
//     {ApiModels models}) {
//   showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//             content:
//                 widgetActive(context, formKeys, refresKeys, models: models));
//       }
//     );
// }

// Widget widgetActive(BuildContext contexts, GlobalKey<FormState> formKeys,
//     GlobalKey<RefreshIndicatorState> refresKeys,
//     {ApiModels models}) {
//   String status;
//   if (models != null) {
//     label.text = models.name;
//     desc.text = models.desc;
//     status = "edit";
//     print(models);
//   } else {
//     status = "add";
//   }
//   return Form(
//       key: formKeys,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Center(child: Text(status)),
//           formFields("labels names : ", label),
//           formFields("descrintion : ", desc),
//           RaisedButton(
//               child: Text(status),
//               onPressed: () {
//                 if (status == "add") {
//                   ApiModels api = ApiModels(name: label.text, desc: desc.text);
//                   API_Providers().createCard(api);
//                   API_Providers().getBoards();
//                 } else if (status == "edit") {
//                   ApiModels api = ApiModels(
//                       id: models.id, name: label.text, desc: desc.text);
//                   API_Providers().updateCard(api);
//                   API_Providers().getBoards();
//                 }
//                 refresKeys.currentState.show();
//                 Navigator.pop(contexts);
//               })
//         ],
//       ));
// }

// Widget formFields(
//   String names,
//   TextEditingController controller,
// ) {
//   return Column(
//     children: <Widget>[
//       Text(names),
//       Container(
//         padding: EdgeInsets.all(paddingSize),
//         child: TextFormField(
//           controller: controller,
//           validator: (value) {
//             if (value.isEmpty) {
//               return 'Enter Some text';
//             }
//             return null;
//           },
//         ),
//       )
//     ],
//   );
// }

// alertConfirm(BuildContext context, GlobalKey<FormState> formKeys,
//     GlobalKey<RefreshIndicatorState> refresKeys, ApiModels profil) {
//   showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//             content: Container(
//                 padding: EdgeInsets.all(paddingSize),
//                 child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Container(
//                         padding: EdgeInsets.all(paddingSize),
//                         child: Text("nama : ${profil.name}"),
//                       ),
//                       Container(
//                         padding: EdgeInsets.all(paddingSize),
//                         child: Text("describsi : ${profil.desc}"),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Text("di ubah atau di buang ?"),
//                       Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: <Widget>[
//                             FlatButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                   alertDialog(context, formKeys, refresKeys,
//                                       models: profil); 
//                                 },
//                                 child: Text("edit")),
//                             FlatButton(
//                                 onPressed: () {
//                                   API_Providers().deleteCard(profil);
//                                   refresKeys.currentState.show();
//                                   Navigator.pop(context);
//                                 },
//                                 child: Text("delete",
//                                     style: TextStyle(color: Colors.red))),
//                           ])
//                     ])));
//       });
// }
