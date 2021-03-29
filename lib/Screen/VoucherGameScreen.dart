import 'package:e_payment/data/AuthAccount.dart';
import 'package:e_payment/data/DatabaseService.dart';
import 'package:flutter/material.dart';

import 'MainScreen.dart';

class VoucherGameScreen extends StatefulWidget{
  VoucherGameState createState() => VoucherGameState();
}
class VoucherGameState extends State<VoucherGameScreen>{
  final _formkey = GlobalKey<FormState>();

  List<String> game = ["Mobile Legend","PUBG","Garena Free Fire","Genshin Impact","Clash of Clans","Rise of Kingdoms: Lost Crusade","Lords Mobile: Kindom Wars"];
  String selectGame = "Mobile Legend";

  String selectID;

  List<int> nominal = [10000,20000,50000,100000,200000,500000,1000000];
  int selectNominal = 10000;
  String error = "";
  @override
  Widget build(BuildContext context) {
    DatabaseService transferService = DatabaseService();

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Voucher Game",
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formkey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Game",
                        style:  TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 10),
                      DropdownButton(
                        value: selectGame,
                        isExpanded: true,
                        onChanged: (value){
                          setState(() {
                            selectGame = value;
                          });
                        },
                        items: game.map((value){
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value.toString()),);
                        },
                        ).toList(),
                      ),
                      SizedBox(height: 30,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: new Divider(
                              thickness: 2,
                            ),
                          )
                      ),
                      TextFormField(
                        validator: (value) =>
                        value.isEmpty
                            ? 'id game harus di isi'
                            : null,
                        onChanged: (value) {
                          setState(() => selectID = value);
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(

                          ),
                          labelText: 'ID Game',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 30,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: new Divider(
                              thickness: 2,
                            ),
                          )
                      ),
                      Text(
                        "Nominal",
                        style:  TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 10),
                      DropdownButton(
                        value: selectNominal,
                        isExpanded: true,
                        onChanged: (value){
                          setState(() {
                            selectNominal = value;
                          });
                        },
                        items: nominal.map((value){
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value.toString()),);
                        },
                        ).toList(),
                      ),
                      SizedBox(height: 30,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: new Divider(
                              thickness: 2,
                            ),
                          )
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formkey.currentState.validate()) {
                              bool transfer = await transferService.checkSaldo(
                                  AuthAccount().getCurrentUID(context), selectNominal);
                              if (transfer) {
                                DateTime selectedDate = DateTime.now();

                                //untuk convert dari dateTime ke int
                                int time = selectedDate.millisecondsSinceEpoch;
                                await transferService.createVoucherGame(AuthAccount().getCurrentUID(
                                    context), selectGame, selectID, selectNominal, time);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MainScreen(),
                                  ),
                                );
                              } else {
                                setState(() => error = 'Saldo tidak mencukupi.');
                              }
                            }
                          },
                          child: Text('Bayar'),
                        ),
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainScreen(),
                                ),
                              );
                            },
                            child: Text('Back'),
                          )
                      ),
                    ]
                ),
              )
          ),
        )
    );
  }
}