import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';

class mainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).primaryColor,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 30, bottom: 20),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('images/logo.png'), fit: BoxFit.fill),
                  ),
                ),
                Container(
                  child: Text(
                    "Ice-Apple",
                    style: TextStyle(fontSize: 22, color: Colors.black),
                  ),
                ),
                Container(
                  child: Text(
                    "iceapple26@gmail.com",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.star, color: Colors.blue),
            title: Text(
              "Rate App",
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              StoreRedirect.redirect(androidAppId: "com.iceapple.corona");
            },
          ),
          ListTile(
            leading: Icon(Icons.share, color: Colors.blue),
            title: Text(
              "Share App",
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Share.share(
                  'Download our apps to check live update of Covid-19 website https://www.facebook.com/Iceapple26/',
                  subject: 'Corona live Update App');
            },
          ),
          ListTile(
            leading: Icon(Icons.file_download, color: Colors.blue),
            title: Text(
              "Our Apps",
              style: TextStyle(fontSize: 18),
            ),
          ),
          ListTile(
            leading: Icon(Icons.pages, color: Colors.blue),
            title: Text(
              "Facebook",
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              launch("https://www.facebook.com/Iceapple26/");
            },
          ),
        ],
      ),
    );
  }
}
