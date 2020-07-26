import 'package:crud_exercise1/add_user.dart';
import 'package:crud_exercise1/model/UserModel.dart';
import 'package:crud_exercise1/services/user_services.dart';
import 'package:crud_exercise1/update_user.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserServices userServices;

  refresh(){
    setState(() {});
  }

  gotoAddUser()async{
    var a = await Navigator.push(context, MaterialPageRoute(builder: (context)=> AddUser()));
    print("DAPAT DATA POP $a");
    if (a != null) {
      refresh();
    }
  }

  gotoUpdateUser(UserModel userData)async{
    var a = await Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateUser(userModel: userData,)));
    print("DAPAT DATA POP $a");
    if (a != null) {
      refresh();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userServices = UserServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text("Cobak CRUD bisa refresh"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
       gotoAddUser();
      },child: Icon(Icons.add),),
      body: SingleChildScrollView(
        child: Container(
            child: FutureBuilder(
                future: userServices.getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                          "Something wrong with message: ${snapshot.error.toString()}"),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    List<UserModel> userData = snapshot.data;
                    // print("DATANEE : ${snapshot.data}");
                    return buildColumn(userData);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                })),
      ),
    );
  }

  Column buildColumn(List<UserModel> userData) {
    return Column(
      children: <Widget>[
        ListView.builder(
            shrinkWrap: true,
            itemCount: userData.length,
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.ac_unit),
                        title: Text(userData[index].name),
                        subtitle: Text(userData[index].email),
                      ),
                      ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: const Text('Update'),
                            onPressed: () {
                              gotoUpdateUser(userData[index]);
                            },
                          ),
                          FlatButton(
                              child: const Text('Delete'),
                              onPressed: () {
                                String name = userData[index].name;
                                userServices.deleteUser(name).then((result) {
                                  if (result != null) {
                                    _scaffoldState.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text("Hapus data berhasil"),
                                    ));
                                    setState(() {});
                                  } else {
                                    print("ui dlete gagal");
                                  }
                                });
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            })
      ],
    );
  }
}
