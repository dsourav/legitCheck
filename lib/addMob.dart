import 'dart:io';

String getAppId() {
 if (Platform.isIOS) {
   return '';
 } else if (Platform.isAndroid) {
   return '';
 }
 return null;
}

String getAdUnitId() {
  if (Platform.isIOS) {
    return '';
  } else if (Platform.isAndroid) {
    return '';
  }
  return null;
}
