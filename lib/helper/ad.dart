import 'dart:io';

class Adhelper {
  String getfirstpageadunit() {
    if (Platform.isAndroid) {
      String androidadunit = 'ca-app-pub-6812988945725571/8091708161';
      return androidadunit;
    } else {
      throw Error();
    }
  }

  String getsecondpageadunit() {
    if (Platform.isAndroid) {
      String androidadunit = 'ca-app-pub-6812988945725571/2320329125';
      return androidadunit;
    } else {
      throw Error();
    }
  }
}
