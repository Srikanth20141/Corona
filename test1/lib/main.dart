import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';

class Corona {
  var local;
  var time;
  final String death;
  final String hospitalised;
  final String recovered;
  final String localNewDeaths;
  final String localNewCases;
  final String globalTotalCases;
  final String globalRecovered;
  final String globalDeaths;
  final String globalNewCases;
  final String globalNewDeaths;

  Corona({
    this.local,
    this.time,
    this.death,
    this.hospitalised,
    this.recovered,
    this.localNewDeaths,
    this.localNewCases,
    this.globalTotalCases,
    this.globalRecovered,
    this.globalDeaths,
    this.globalNewCases,
    this.globalNewDeaths,
  });

  factory Corona.fromJson(Map<String, dynamic> json) {
    return Corona(
      local: json['local_total_cases'],
      time: json['update_date_time'],
      death: json['local_deaths'],
      hospitalised: json['local_total_number_of_individuals_in_hospitals'],
      recovered: json['local_recovered'],
      localNewDeaths: json['local_new_deaths'],
      localNewCases: json['local_new_cases'],
      globalTotalCases: json['global_total_cases'],
      globalRecovered: json['global_recovered'],
      globalDeaths: json['global_deaths'],
      globalNewCases: json['global_new_cases'],
      globalNewDeaths: json['global_new_deaths'],
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
  String local;
  String time;
  String death;
  String hospitalised;
  String recovered;
  String localNewDeaths;
  String localNewCases;
  String globalTotalCases;
  String globalRecovered;
  String globalDeaths;
  String globalNewCases;
  String globalNewDeaths;

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
        local = (response.data['data']['local_total_cases']).toString();
        time = (response.data['data']['update_date_time']);
        death = (response.data['data']['local_deaths']).toString();
        hospitalised = (response.data['data']
                ['local_total_number_of_individuals_in_hospitals'])
            .toString();
        recovered = (response.data['data']['local_recovered']).toString();
        localNewDeaths = (response.data['data']['local_new_deaths']).toString();
        localNewCases = (response.data['data']['local_new_cases']).toString();
        globalTotalCases =
            (response.data['data']['global_total_cases']).toString();
        globalRecovered =
            (response.data['data']['global_recovered']).toString();
        globalDeaths = (response.data['data']['global_deaths']).toString();
        globalNewCases = (response.data['data']['global_new_cases']).toString();
        globalNewDeaths =
            (response.data['data']['global_new_deaths']).toString();
      });
    } catch (e) {}
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
                      Text("Local"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CardCount(
                              numberCount: local,
                              text: 'Confirmed',
                              color: Colors.purple[100]),
                          CardCount(
                              numberCount: recovered,
                              text: 'Recovered',
                              color: Colors.green[100]),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CardCount(
                              numberCount: hospitalised,
                              text: 'Hospitalised',
                              color: Colors.orange[100]),
                          CardCount(
                              numberCount: death,
                              text: 'Deaths',
                              color: Colors.red[100]),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 200),
                        child: Text(time.toString()),
                      ),
                      Text("Local confirmed case in last 24 hours"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CardCount(
                              numberCount: localNewCases,
                              text: 'New Confirmed',
                              color: Colors.purple[100]),
                          CardCount(
                              numberCount: localNewDeaths,
                              text: 'Deaths',
                              color: Colors.red[100]),
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
                          CardCount(
                              numberCount: globalTotalCases,
                              text: 'Confirmed',
                              color: Colors.purple[100]),
                          CardCount(
                              numberCount: globalRecovered,
                              text: 'Recovered',
                              color: Colors.green[100]),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CardCount(
                              numberCount: 'N/A',
                              text: 'Hospitalised',
                              color: Colors.orange[100]),
                          CardCount(
                              numberCount: globalDeaths,
                              text: 'Deaths',
                              color: Colors.red[100]),
                        ],
                      ),
                      Text("Global confirmed case in last 24 hours"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CardCount(
                              numberCount: globalNewCases,
                              text: 'New Confirmed',
                              color: Colors.purple[100]),
                          CardCount(
                              numberCount: globalNewDeaths,
                              text: 'Deaths',
                              color: Colors.red[100]),
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

class CardCount extends StatelessWidget {
  final String numberCount;
  final String text;
  final Color color;

  CardCount({Key key, this.numberCount, this.color, this.text})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 2,
      child: Container(
        height: 86,
        width: 155,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                numberCount != null
                    ? Text(
                        numberCount,
                        style: TextStyle(
                            fontSize: 27, fontWeight: FontWeight.bold),
                      )
                    : CircularProgressIndicator(
                        strokeWidth: 1.5,
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
