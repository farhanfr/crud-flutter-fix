// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
    UserModel({
        this.uid,
        this.name,
        this.mobile,
        this.email,
        this.password,
    });

    String uid;
    String name;
    String mobile;
    String email;
    String password;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["uid"],
        name: json["name"],
        mobile: json["mobile"],
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "mobile": mobile,
        "email": email,
        "password": password,
    };
}
