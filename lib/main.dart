import 'dart:io';

import 'package:flutter/material.dart';

import 'my_app.dart';


void main() {
   HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}
 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

