import 'package:crud_exercise1/model/UserModel.dart';
import 'package:crud_exercise1/services/user_services.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class UpdateUser extends StatefulWidget {
  UserModel userModel;
  UpdateUser({this.userModel});

  @override
  _UpdateUserState createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  UserServices userServices;

  TextEditingController uidCon = new TextEditingController();
  TextEditingController nameCon = new TextEditingController();
  TextEditingController mobileCon = new TextEditingController();
  TextEditingController emailCon = new TextEditingController();
  TextEditingController passwordCon = new TextEditingController();

  @override
  void initState() {
    super.initState();
    userServices = UserServices();
    uidCon.text = this.widget.userModel.uid;
    nameCon.text = this.widget.userModel.name;
    mobileCon.text = this.widget.userModel.mobile;
    emailCon.text = this.widget.userModel.email;
    passwordCon.text = this.widget.userModel.password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text("Update Data"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            TextField(
                controller: uidCon,
                decoration: InputDecoration(labelText: 'Masukkan UID')),
            TextField(
                controller: nameCon,
                decoration: InputDecoration(labelText: 'Masukkan Name')),
            TextField(
                controller: mobileCon,
                decoration: InputDecoration(labelText: 'Masukkan Mobile')),
            TextField(
                controller: emailCon,
                decoration: InputDecoration(labelText: 'Masukkan Email')),
            TextField(
                controller: passwordCon,
                decoration: InputDecoration(labelText: 'Masukkan Password')),
            RaisedButton(
                child: Text("Update"),
                onPressed: () {
                  userServices
                      .editUser(uidCon.text, nameCon.text, mobileCon.text,
                          emailCon.text, passwordCon.text)
                      .then((result) {
                    if (result != null) {
                      Navigator.of(context).pop("datapop");
                    } else {
                      _scaffoldState.currentState.showSnackBar(SnackBar(
                        content: Text("Simpan data gagal"),
                      ));
                    }
                  });
                })
          ],
        ),
      ),
    );
  }
}
