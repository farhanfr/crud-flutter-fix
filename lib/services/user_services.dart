import 'dart:convert';

import 'package:crud_exercise1/model/UserModel.dart';
import 'package:http/http.dart' show Client;

class UserServices {
  final String url = "http://192.168.1.12/apilatihan2/";
  Client client = Client();

  Future<List<UserModel>> getUserData() async {
    List<UserModel> _list = [];
    final response = await client.get("$url/getdata.php");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (Map i in data) {
        _list.add(UserModel.fromJson(i));
        // print("ISI $i");
      }
      print(response.body);
      return _list;
    }
  }

  Future<String> deleteUser(String name) async {
    final response = await client.get("$url/deletedata.php/?name=$name");
    if (response.statusCode == 200) {
      return "berhasil";
    }
    else{
      return "gagal update";
    }   
  }

  Future<String> addUser(String uid, String name, String mobile, String email, String password) async {
    final response = await client.post("$url/adddata.php",
    body: {
      'uid':uid,
      'name':name,
      'mobile':mobile,
      'email':email,
      'password':password,
    }
    );
    if (response.statusCode == 200) {
      return "berhasil";
    }
    else{
      return "gagal update";
    }   
  }

  Future<String> editUser(String uid, String name, String mobile, String email, String password) async {
    final response = await client.post("$url/editdata.php",
    body: {
      'uid':uid,
      'name':name,
      'mobile':mobile,
      'email':email,
      'password':password,
    }
    );
    if (response.statusCode == 200) {
      return "berhasil";
    }
    else{
      return "gagal update";
    }   
  }
}
