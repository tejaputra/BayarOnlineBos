import 'package:e_payment/data/AuthAccount.dart';
import 'package:e_payment/data/DatabaseService.dart';
import 'package:flutter/material.dart';

import 'MainScreen.dart';

class PLNScreen extends StatefulWidget{
  @override
  _PLNScreenState createState() => _PLNScreenState();
}

class _PLNScreenState extends State<PLNScreen> {
  final _formkey = GlobalKey<FormState>();

  String selectNomorPLN;
  String selectNominal;
  String error = "";

  @override
  Widget build(BuildContext context) {
    DatabaseService plnService = DatabaseService();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Pembayaran PLN",
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
                      TextFormField(
                        validator: (value) =>
                        value.length < 11 || value.length > 12
                            ? 'nomor PLN salah. 11 atau 12 angka.'
                            : null,
                        onChanged: (value) {
                          setState(() => selectNomorPLN = value);
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(

                          ),
                          labelText: 'Nomor PLN',
                          hintText: '',
                        ),
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
                            ? 'nominal harus di isi'
                            : null,
                        onChanged: ( value) {
                          setState(() => selectNominal = value);
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(

                          ),
                          labelText: 'Nominal',
                          hintText: '',
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
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formkey.currentState.validate()) {
                              print(selectNominal);
                              bool transfer = await plnService.checkSaldo(AuthAccount().getCurrentUID(context), int.parse(selectNominal));
                              if(transfer){
                                DateTime selectedDate = DateTime.now();

                                //untuk convert dari dateTime ke int
                                int time = selectedDate.millisecondsSinceEpoch;
                                await plnService.createPLN(AuthAccount().getCurrentUID(context), selectNomorPLN,int.parse(selectNominal), time);
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