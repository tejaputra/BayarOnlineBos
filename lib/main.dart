import 'package:e_payment/Screen/selection.dart';
import 'package:e_payment/data/Account.dart';
import 'package:e_payment/data/AuthAccount.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screen/LoginScene.dart';
import 'Screen/NewScreen.dart';
import 'Screen/RegisterScene.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return StreamProvider<Account>.value(
        value: AuthAccount().account,
        child: MaterialApp(
          home: selection(),
        )
    );
  }
}






