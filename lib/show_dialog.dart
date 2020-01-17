import 'package:flutter/material.dart';
import 'api_models.dart';
import 'api_provider.dart';

TextEditingController label = new TextEditingController();
TextEditingController desc = new TextEditingController();
double paddingSize = 8.0;

Widget formFields(
  String names,
  TextEditingController controller,
) {
  return Column(
    children: <Widget>[
      Text(names),
      Container(
        padding: EdgeInsets.all(paddingSize),
        child: TextFormField(
          controller: controller,
          validator: (value) {
            if (value.isEmpty) {
              return 'Enter Some text';
            }
            return null;
          },
        ),
      )
    ],
  );
}

Widget widgetActive(BuildContext contexts, GlobalKey<FormState> formKeys,
    GlobalKey<RefreshIndicatorState> refresKeys,
    {ApiModel models}) {
  String status;
  if (models != null) {
    label.text = models.name;
    desc.text = models.desc;
    status = "edit";
    print(models);
  } else {
    status = "add";
  }
  return SingleChildScrollView(
      key: formKeys,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(child: Text(status)),
          formFields("labels names : ", label),
          formFields("descrintion : ", desc),
          RaisedButton(
              child: Text(status),
              onPressed: () {
                theCallBack(contexts, formKeys, refresKeys,
                    models: models, status: status);
              })
        ],
      ));
}

void theCallBack(BuildContext contexts, GlobalKey<FormState> formKeys,
    GlobalKey<RefreshIndicatorState> refresKeys,
    {ApiModel models, String status}) {
  if (status == "add") {
    ApiModel api = ApiModel(name: label.text, desc: desc.text);
    API_Providers().createCard(api);
    API_Providers().getBoards();
  } else if (status == "edit") {
    ApiModel api = ApiModel(id: models.id, name: label.text, desc: desc.text);
    API_Providers().updateCard(api);
    API_Providers().getBoards();
  }
  label.clear();
  desc.clear();
  refresKeys.currentState.show();
  Navigator.pop(contexts);
}
/*
else if (status == "edit") {
                  ApiModel api = ApiModel(
                      id: models.id, name: label.text, desc: desc.text);
                  API_Providers().updateCard(api);
                  API_Providers().getBoards();
                } */
/*
                if (status == "add") {
                  ApiModels api = ApiModels(name: label.text, desc: desc.text);
                  API_Providers().createCard(api);
                  API_Providers().getBoards();
                } else if (status == "edit") {
                  ApiModels api = ApiModels(
                      id: models.id, name: label.text, desc: desc.text);
                  API_Providers().updateCard(api);
                  API_Providers().getBoards();
                }
                refresKeys.currentState.show();
                Navigator.pop(contexts);
 */

post_update(BuildContext context, GlobalKey<FormState> formKeys,
    GlobalKey<RefreshIndicatorState> refresKeys,
    {ApiModel models}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            content:
                widgetActive(context, formKeys, refresKeys, models: models));
      });
}

delete(BuildContext context, GlobalKey<FormState> formKeys,
    GlobalKey<RefreshIndicatorState> refresKeys,
    {ApiModel models}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            content: Container(
          padding: EdgeInsets.all(paddingSize),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Nama : " + models.name),
              Text("Descripsi : " + models.desc),
              Text("Apakah Anda ingin menghapusnya ?"),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    child: Text("Yes"),
                    onPressed: () {
                      ApiModel api = ApiModel(id: models.id);
                      API_Providers().deleteCard(api);
                      API_Providers().getBoards();
                      refresKeys.currentState.show();
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    child: Text("cancle"),
                    onPressed: () {
                      refresKeys.currentState.show();
                      Navigator.pop(context);
                    },
                  )
                ],
              )
            ],
          ),
        ));
      });
}
