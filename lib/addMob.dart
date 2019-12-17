import 'dart:io';

String getAppId() {
 if (Platform.isIOS) {
   return 'ca-app-pub-3281095153278672~8502044426';
 } else if (Platform.isAndroid) {
   return 'ca-app-pub-3281095153278672~5545257332';
 }
 return null;
}

String getAdUnitId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-3281095153278672/8314342168';
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-3281095153278672/6460552057';
  }
  return null;
}