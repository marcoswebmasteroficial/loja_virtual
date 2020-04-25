import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class placesTitle extends StatelessWidget {
  final DocumentSnapshot snapshot;

  placesTitle(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 100.0,
            child: Image.network(
              snapshot.data["imagem"],
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(snapshot.data["title"],
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
                Text(snapshot.data["title"],
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 14.0)),
              ],
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
            FlatButton(
              child: Text(
                "Ver no mapa",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
              ),
              textColor: Theme.of(context).primaryColor,
              padding: EdgeInsets.zero,
              onPressed: () {
                launch("https://www.google.com/maps/search/?api=1&query=${snapshot.data["lat"]},${snapshot.data["long"]}");
              },
            ),
            FlatButton(
              child: Text(
                "Ligar",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
              ),
              textColor: Theme.of(context).primaryColor,
              padding: EdgeInsets.zero,
              onPressed: () {
                launch("tel:${snapshot.data["fone"]}");
              },
            )
          ])
        ],
      ),
    );
  }
}
