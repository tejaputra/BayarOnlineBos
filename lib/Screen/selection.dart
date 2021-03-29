import 'package:e_payment/Screen/MainScreen.dart';
import 'package:e_payment/Screen/NewScreen.dart';
import 'package:e_payment/data/Account.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class selection extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    final account = Provider.of<Account>(context);

    if(account == null){
      return NewScreen();
    } else {
      return MainScreen();
    }
  }
}
