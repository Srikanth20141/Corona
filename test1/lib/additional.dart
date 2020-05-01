import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Additional extends StatefulWidget {
  @override
  _AdditionalState createState() => _AdditionalState();
}

class _AdditionalState extends State<Additional> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    void _launchURL() async {
      const url = 'https://www.facebook.com/Iceapple26/';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    super.setState(fn);
  }
}
