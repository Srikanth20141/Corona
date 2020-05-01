import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

import 'drawer.dart';

class Corona {
  var local;
  var time;
  final String death;
  final String hospitalised;
  final String recovered;
  final String local_New_deaths;
  final String local_new_cases;
  final String global_total_cases;
  final String global_recovered;
  final String global_deaths;
  final String global_new_cases;
  final String global_new_deaths;

  Corona({
    this.local,
    this.time,
    this.death,
    this.hospitalised,
    this.recovered,
    this.local_New_deaths,
    this.local_new_cases,
    this.global_total_cases,
    this.global_recovered,
    this.global_deaths,
    this.global_new_cases,
    this.global_new_deaths,
  });

  factory Corona.fromJson(Map<String, dynamic> json) {
    return Corona(
      local: json['local_total_cases'],
      time: json['update_date_time'],
      death: json['local_deaths'],
      hospitalised: json['local_total_number_of_individuals_in_hospitals'],
      recovered: json['local_recovered'],
      local_New_deaths: json['local_new_deaths'],
      local_new_cases: json['local_new_cases'],
      global_total_cases: json['global_total_cases'],
      global_recovered: json['global_recovered'],
      global_deaths: json['global_deaths'],
      global_new_cases: json['global_new_cases'],
      global_new_deaths: json['global_new_deaths'],
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Corona> futureAlbum;
  String _local_active_cases;
  String _update_date_time;
  String local_deaths;
  String hospitalised;
  String recovered;
  String local_New_deaths;
  String local_new_cases;
  String global_total_cases;
  String global_recovered;
  String global_deaths;
  String global_new_cases;
  String global_new_deaths;

  @override
  void initState() {
    super.initState();
    this.getHttp();
  }

  void reload() {
    setState(() {
      this.getHttp();
    });
  }

  void getHttp() async {
    try {
      Response response = await Dio()
          .get("https://www.hpb.health.gov.lk/api/get-current-statistical");
      setState(() {
        _local_active_cases =
            (response.data['data']['local_total_cases']).toString();
        _update_date_time = (response.data['data']['update_date_time']);
        local_deaths = (response.data['data']['local_deaths']).toString();
        hospitalised = (response.data['data']
                ['local_total_number_of_individuals_in_hospitals'])
            .toString();
        recovered = (response.data['data']['local_recovered']).toString();
        local_New_deaths =
            (response.data['data']['local_new_deaths']).toString();
        local_new_cases = (response.data['data']['local_new_cases']).toString();
        global_total_cases =
            (response.data['data']['global_total_cases']).toString();
        global_recovered =
            (response.data['data']['global_recovered']).toString();
        global_deaths = (response.data['data']['global_deaths']).toString();
        global_new_cases =
            (response.data['data']['global_new_cases']).toString();
        global_new_deaths =
            (response.data['data']['global_new_deaths']).toString();
      });

      //data.add(response.data['data']);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Corona Sri Lanka App',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Schyler',
          primaryColor: Colors.red[50]),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Corona-19 Live Updates",
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
            backgroundColor: Colors.red[50],
            elevation: 0,
            actions: <Widget>[
              IconButton(
                  icon: (Icon(
                    Icons.power_settings_new,
                    color: Colors.black,
                  )),
                  onPressed: () {
                    exit(0);
                  }),
              //IconButton(icon: (Icon(Icons.refresh)), onPressed: (){null;}),
            ],
          ),
          drawer: Drawer(
            child: mainDrawer(),
          ),
          backgroundColor: Colors.red[50],
          body: Container(
            width: 400,
            height: 725,
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Sri Lanka",
                        style: TextStyle(fontSize: 17, fontFamily: 'Schyler'),
                      ),
                     // Divider(),
                      Text("Local"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Card(
                            color: Colors.purple[100],
                            elevation: 2,
                            child: Container(
                              height: 86,
                              width: 155,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    "Confirmed",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      _local_active_cases != null
                                          ? Text(
                                              _local_active_cases,
                                              style: TextStyle(
                                                  fontSize: 27,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : CircularProgressIndicator(
                                              strokeWidth: 1.5,
                                            ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.green[100],
                            elevation: 2,
                            child: Container(
                              height: 86,
                              width: 155,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text("Recovered",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                  recovered != null
                                      ? Text(
                                          recovered,
                                          style: TextStyle(
                                              fontSize: 27,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : CircularProgressIndicator(
                                          strokeWidth: 1.5,
                                        )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Card(
                            color: Colors.orange[100],
                            elevation: 2,
                            child: Container(
                              height: 86,
                              width: 155,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    "Hospitalised",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  hospitalised != null
                                      ? Text(
                                          hospitalised,
                                          style: TextStyle(
                                              fontSize: 27,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : CircularProgressIndicator(
                                          strokeWidth: 1.5,
                                        )
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.red[100],
                            elevation: 2,
                            child: Container(
                              height: 86,
                              width: 155,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text("Deaths",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                  recovered != null
                                      ? Text(
                                          local_deaths,
                                          style: TextStyle(
                                              fontSize: 27,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : CircularProgressIndicator(
                                          strokeWidth: 1.5,
                                        )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 200),
                        child: Text(_update_date_time.toString()),
                      ),
                      Text("Local confirmed case in last 24 hours"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Card(
                            color: Colors.purple[100],
                            elevation: 2,
                            child: Container(
                              height: 86,
                              width: 155,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    "New Confirmed",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  local_new_cases != null
                                      ? Text(
                                          local_new_cases,
                                          style: TextStyle(
                                              fontSize: 27,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : CircularProgressIndicator(
                                          strokeWidth: 1.5,
                                        )
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.red[100],
                            elevation: 2,
                            child: Container(
                              height: 86,
                              width: 155,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text("Deaths",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                  local_New_deaths != null
                                      ? Text(
                                          local_New_deaths,
                                          style: TextStyle(
                                              fontSize: 27,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : CircularProgressIndicator(
                                          strokeWidth: 1.5,
                                        )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                       Divider(),
                      Text("Global"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Card(
                            color: Colors.purple[100],
                            elevation: 2,
                            child: Container(
                              height: 86,
                              width: 155,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    "Confirmed",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  global_total_cases != null
                                      ? Text(
                                          global_total_cases.toString(),
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : CircularProgressIndicator(
                                          strokeWidth: 1.5,
                                        )
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.green[100],
                            elevation: 2,
                            child: Container(
                              height: 86,
                              width: 155,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text("Recovered",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                  global_recovered != null
                                      ? Text(
                                          global_recovered,
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : CircularProgressIndicator(
                                          strokeWidth: 1.5,
                                        )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Card(
                            color: Colors.orange[100],
                            elevation: 2,
                            child: Container(
                              height: 86,
                              width: 155,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    "Hospitalised",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    "N/A",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.red[100],
                            elevation: 2,
                            child: Container(
                              height: 86,
                              width: 155,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text("Deaths",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                  global_deaths != null
                                      ? Text(
                                          global_deaths,
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : CircularProgressIndicator(
                                          strokeWidth: 1.5,
                                        )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text("Global confirmed case in last 24 hours"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Card(
                            color: Colors.purple[100],
                            elevation: 2,
                            child: Container(
                              height: 86,
                              width: 155,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    "New Confirmed",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  global_new_cases != null
                                      ? Text(
                                          global_new_cases,
                                          style: TextStyle(
                                              fontSize: 27,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : CircularProgressIndicator(
                                          strokeWidth: 1.5,
                                        )
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.red[100],
                            elevation: 2,
                            child: Container(
                              height: 86,
                              width: 155,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text("Deaths",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                  global_new_deaths != null
                                      ? Text(
                                          global_new_deaths,
                                          style: TextStyle(
                                              fontSize: 27,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : CircularProgressIndicator(
                                          strokeWidth: 1.5,
                                        )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
