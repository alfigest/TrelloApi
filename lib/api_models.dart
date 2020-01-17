import 'dart:convert';

List<ApiModel> apiModelFromJson(String str) => List<ApiModel>.from(json.decode(str).map((x) => ApiModel.fromJson(x)));

String apiModelToJson(List<ApiModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ApiModel {
    String id;
    String name;
    String desc;

    ApiModel({
        this.id,
        this.name,
        this.desc,
    });

    factory ApiModel.fromJson(Map<String, dynamic> json) => ApiModel(
        id: json["id"],
        name: json["name"],
        desc: json["desc"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "desc": desc,
    };
}



// import 'dart:convert';

// class ApiModels {
//     String id;
//     String name;
//     String desc;

//     ApiModels({
//         this.id,
//         this.name,
//         this.desc,
//     });

//     factory ApiModels.fromJson(Map<String, dynamic> json) => ApiModels(
//         id: json["id"],
//         name: json["name"],
//         desc: json["desc"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "desc": desc,
//     };
// }
// List<ApiModels> apiClickFromJson(String str) => List<ApiModels>.from(json.decode(str).map((x) => ApiModels.fromJson(x)));

// String apiClickToJson(List<ApiModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
