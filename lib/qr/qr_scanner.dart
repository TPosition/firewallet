import 'dart:async';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';

Future<String> qrScan() async {
  try {
    return await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      'Cancel',
      true,
      ScanMode.QR,
    );
  } on PlatformException {
    return 'Failed to get platform version.';
  }
}
