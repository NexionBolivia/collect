import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_module/data/models/profile.dart';
import 'package:flutter_module/screens/edit_profile/edit_profile.dart';
import 'package:flutter_module/service/api/get_profile.dart';

class ProfilePage extends StatefulWidget {
  final String profileId;

  const ProfilePage({Key key, @required this.profileId}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Profile profile;
  bool refreshing = false;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  _refresh() {
    if (!refreshing) {
      setState(() {
        refreshing = true;
      });
      GetProfile(widget.profileId).fetch().then((value) {
        if (mounted)
          setState(() {
            profile = value;
            refreshing = false;
          });
      }).catchError((error) {
        log("$error");
        if (mounted)
          setState(() {
            refreshing = false;
          });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
        actions: [
          !refreshing
              ? IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfilePage(
                          profile: profile,
                        ),
                        settings: RouteSettings(name: "EditProfilePage"),
                      ),
                    ).then((value) {
                      if (value != null) _refresh();
                    });
                  })
              : Container()
        ],
      ),
      body: Column(
        children: [
          profile != null
              ? Expanded(
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 50),
                            child: Column(
                              children: [
                                Text(profile.formation),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                          Card(
                            margin: EdgeInsets.all(5),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Column(
                                children: [
                                  InfoDetail(
                                    icon: Icons.directions,
                                    description: profile.address,
                                  ),
                                  Divider(),
                                  InfoDetail(
                                    icon: Icons.phone,
                                    description: profile.phone,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            margin: EdgeInsets.all(5),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Text(
                                          "Número de tecnicos y/o profesionales: "),
                                      Text(
                                        "${profile.professionals}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Número total de empleados: "),
                                      Text(
                                        "${profile.employes}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Card(
                            margin: EdgeInsets.all(5),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Text("Departamento: "),
                                      Text(
                                        profile.department,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Provincia: "),
                                      Text(
                                        profile.province,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Municipio: "),
                                      Text(
                                        profile.municipality,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            margin: EdgeInsets.all(5),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Text(
                                          "Numero total de conexiones de agua potable: "),
                                      Text(
                                        "${profile.waterConnections}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          "Numero de conexiones con medidor: "),
                                      Text(
                                        "${profile.connectionsWithMeter}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          "Numero de conexiones sin medidor: "),
                                      Text(
                                        "${profile.connectionsWithoutMeter}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Numero de piletas publicas: "),
                                      Text(
                                        "${profile.publicPools}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Numero de letrinas: "),
                                      Text(
                                        "${profile.latrines}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          "Continuidad del servicio  hr/dia: "),
                                      Text(
                                        "${profile.serviceContinuity}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refresh,
        tooltip: 'Refresh',
        child: refreshing
            ? CircularProgressIndicator(backgroundColor: Colors.white)
            : Icon(Icons.refresh),
      ),
    );
  }
}

class InfoDetail extends StatelessWidget {
  InfoDetail({
    Key key,
    @required this.icon,
    @required this.description,
  }) : super(key: key);
  final IconData icon;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Icon(
              icon,
              color: Colors.lightBlue,
              size: 30,
            ),
          ),
          Expanded(
            child: Text(
              description,
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
          )
        ],
      ),
    );
  }
}
