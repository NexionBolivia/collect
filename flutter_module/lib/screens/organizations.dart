import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_module/data/models/KoboUserResource.dart';
import 'package:flutter_module/screens/profile.dart';
import 'package:flutter_module/service/api/get_userResources.dart';

class OrganizationsScreen extends StatefulWidget {
  @override
  _OrganizationsScreenState createState() => _OrganizationsScreenState();
}

class _OrganizationsScreenState extends State<OrganizationsScreen> {
  KoboUserResource resources;
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
      GetUserResources().fetch().then((value) {
        if (mounted)
          setState(() {
            resources = value;
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
        title: Text("Mis Organizaciones"),
      ),
      body: ListView(
        children: resources?.organizations
                ?.map((organization) => Card(
                      color: HexColor(organization.color),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              child: Center(
                                child: Text(organization.name),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: organization.profileId != "",
                            child: IconButton(
                              icon: Icon(
                                Icons.person_outline,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfilePage(
                                      profileId: organization.profileId,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ))
                ?.toList() ??
            [],
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

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
