import 'dart:io';

import 'package:flutter/foundation.dart';

Future<bool> internetStatusCheck() async {
  bool isOnline = false;
  try {
    final result = await InternetAddress.lookup('example.com');
    isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } catch (error) {
    isOnline = false;
    if (kDebugMode) {
      print(error);
    }
  }

  return isOnline;
}
