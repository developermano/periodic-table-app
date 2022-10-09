import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:periodictable/helper/ad.dart';
import 'package:periodictable/infopage.dart';
import 'package:periodictable/sqlite/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  Sqldb().init();
  runApp(MaterialApp(
    home: Firstpage(),
    debugShowCheckedModeBanner: false,
  ));
}

class Firstpage extends StatefulWidget {
  @override
  _FirstpageState createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  final myController = TextEditingController();

  late Future<List<dynamic>> atomlist;
  var futurewidget;
  var snap;
  late BannerAd myBanner;
  bool isloaded = false;

  void initState() {
    atomlist = getatomictable();
    super.initState();
    myBanner = BannerAd(
      adUnitId: Adhelper().getfirstpageadunit(),
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(onAdLoaded: (_) {
        setState(() {
          isloaded = true;
        });
      }, onAdFailedToLoad: (_, error) {
        print(error);
      }),
    );

    myBanner.load();
  }

  Widget ad() {
    if (isloaded == true) {
      return Container(
          alignment: Alignment.center,
          child: AdWidget(ad: myBanner),
          width: myBanner.size.width.toDouble(),
          height: myBanner.size.height.toDouble());
    } else {
      return Text('ad');
    }
  }

  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 30),
            child: Column(
              children: [
                TextField(
                  onChanged: (input) {
                    setState(() {
                      futurewidget = elementinfo(input, snap, context);
                    });
                  },
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'Enter atomic number'),
                  keyboardType: TextInputType.number,
                  controller: myController,
                ),
              ],
            ),
          ),
          preferredSize: Size(double.infinity, 75)),
      bottomNavigationBar: ad(),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Container(
          child: FutureBuilder(
              future: atomlist,
              builder: (context, AsyncSnapshot snapshot) {
                snap = snapshot;
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return snapshot.hasData
                      ? elementinfo(myController.text, snapshot, context)
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                }
              }),
        ),
      ),
    );
  }
}

Widget elementinfo(var inputext, AsyncSnapshot snapshot, context) {
  bool isint;
  try {
    int.parse(inputext);
    isint = true;
  } catch (FormatException) {
    isint = false;
  }

  if (isint) {
    int index = int.parse(inputext) - 1;
    return ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Infopage(),
                  settings: RouteSettings(arguments: [snapshot.data, index])));
        },
        leading: Container(
            padding: EdgeInsets.only(top: 15),
            child: Text(snapshot.data[index]['field1'])),
        title: Text(snapshot.data[index]['field2'].toString()),
        trailing: Text(snapshot.data[index]['field3'].toString()),
        subtitle: Text(
          snapshot.data[index]['field24'].toString(),
        ));
  } else {
    return listofelements(snapshot);
  }
}

Widget listofelements(AsyncSnapshot snapshot) {
  return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        return ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Infopage(),
                      settings:
                          RouteSettings(arguments: [snapshot.data, index])));
            },
            leading: Container(
                padding: EdgeInsets.only(top: 15),
                child: Text(snapshot.data[index]['field1'])),
            title: Text(snapshot.data[index]['field2'].toString()),
            trailing: Text(snapshot.data[index]['field3'].toString()),
            subtitle: Text(
              snapshot.data[index]['field24'].toString(),
            ));
      });
}

Future<List> getatomictable() async {
  var databasesPath = await getDatabasesPath();
  var path = join(databasesPath, "periodic_table_list.db");

  var db = await openDatabase(path, readOnly: true);
  var list = await db.rawQuery('SELECT * FROM periodictable');

  return list;
}
