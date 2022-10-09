import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:periodictable/helper/ad.dart';

class Infopage extends StatefulWidget {
  @override
  _InfopageState createState() => _InfopageState();
}

class _InfopageState extends State<Infopage> {
  late BannerAd myBanner;
  bool isloaded = false;
  void initState() {
    super.initState();
    myBanner = BannerAd(
      adUnitId: Adhelper().getsecondpageadunit(),
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

  @override
  Widget build(BuildContext context) {
    final List data = ModalRoute.of(context)!.settings.arguments as List;
    int ele = data[1];
    List infodata = data[0];
    return Scaffold(
      appBar: AppBar(
        title: Text(data[0][ele]['field2'].toString()),
      ),
      bottomNavigationBar: ad(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Listofinfo(
              lt: 'AtomicNumber',
              rt: infodata[ele]['field1'].toString(),
            ),
            Listofinfo(
              lt: 'Element',
              rt: infodata[ele]['field2'].toString(),
            ),
            Listofinfo(
              lt: 'Symbol	',
              rt: infodata[ele]['field3'].toString(),
            ),
            Listofinfo(
              lt: 'AtomicMass',
              rt: infodata[ele]['field4'].toString(),
            ),
            Listofinfo(
              lt: 'NumberofNeutrons',
              rt: infodata[ele]['field5'].toString(),
            ),
            Listofinfo(
              lt: 'NumberofProtons',
              rt: infodata[ele]['field6'].toString(),
            ),
            Listofinfo(
              lt: 'NumberofElectrons',
              rt: infodata[ele]['field7'].toString(),
            ),
            Listofinfo(
              lt: 'Period',
              rt: infodata[ele]['field8'].toString(),
            ),
            Listofinfo(
              lt: 'Group',
              rt: infodata[ele]['field9'].toString(),
            ),
            Listofinfo(
              lt: 'Phase',
              rt: infodata[ele]['field10'].toString(),
            ),
            Listofinfo(
              lt: 'Radioactive',
              rt: infodata[ele]['field11'].toString(),
            ),
            Listofinfo(
              lt: 'Natural',
              rt: infodata[ele]['field12'].toString(),
            ),
            Listofinfo(
              lt: 'Metal',
              rt: infodata[ele]['field13'].toString(),
            ),
            Listofinfo(
              lt: 'Nonmetal',
              rt: infodata[ele]['field14'].toString(),
            ),
            Listofinfo(
              lt: 'Metalloid',
              rt: infodata[ele]['field15'].toString(),
            ),
            Listofinfo(
              lt: 'Type',
              rt: infodata[ele]['field16'].toString(),
            ),
            Listofinfo(
              lt: 'AtomicRadius',
              rt: infodata[ele]['field17'].toString(),
            ),
            Listofinfo(
              lt: 'Electronegativity',
              rt: infodata[ele]['field18'].toString(),
            ),
            Listofinfo(
              lt: 'FirstIonization',
              rt: infodata[ele]['field19'].toString(),
            ),
            Listofinfo(
              lt: 'Density',
              rt: infodata[ele]['field20'].toString(),
            ),
            Listofinfo(
              lt: 'MeltingPoint	',
              rt: infodata[ele]['field21'].toString(),
            ),
            Listofinfo(
              lt: 'BoilingPoint',
              rt: infodata[ele]['field22'].toString(),
            ),
            Listofinfo(
              lt: 'NumberOfIsotopes',
              rt: infodata[ele]['field23'].toString(),
            ),
            Listofinfo(
              lt: 'Discoverer',
              rt: infodata[ele]['field24'].toString(),
            ),
            Listofinfo(
              lt: 'Year',
              rt: infodata[ele]['field25'].toString(),
            ),
            Listofinfo(
              lt: 'SpecificHeat',
              rt: infodata[ele]['field26'].toString(),
            ),
            Listofinfo(
              lt: 'NumberofShells',
              rt: infodata[ele]['field27'].toString(),
            ),
            Listofinfo(
              lt: 'NumberofValence',
              rt: infodata[ele]['field28'].toString(),
            ),
          ],
        ),
      ),
    );
  }
}

class Listofinfo extends StatelessWidget {
  const Listofinfo({
    Key? key,
    required this.rt,
    required this.lt,
  }) : super(key: key);

  final String rt;
  final String lt;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(lt),
      trailing: Text(rt),
    );
  }
}
