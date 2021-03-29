import 'package:e_payment/data/AuthAccount.dart';
import 'package:e_payment/data/DatabaseService.dart';
import 'package:flutter/material.dart';

import 'MainScreen.dart';

class PulsaScreen extends StatefulWidget{
  PulsaState createState() => PulsaState();
}
class PulsaState extends State<PulsaScreen>{
  final _formkey = GlobalKey<FormState>();

  List<String> kartu = ["Telkomsel","Simpati","Xl","Smartfren","Indosat","Axis","3"];
  String selectKartu = "Telkomsel";

  List<int> nominal = [10000,20000,50000,100000,200000,500000];
  int selectNominal = 10000;

  String nomorKartu;
  String error = "";
  @override
  Widget build(BuildContext context) {
    DatabaseService pulsaService = DatabaseService();

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Pembelian Pulsa",
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
                        "Kartu",
                        style:  TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 10),
                      DropdownButton(
                        value: selectKartu,
                        isExpanded: true,
                        onChanged: (value){
                          setState(() {
                            selectKartu = value;
                          });
                        },
                        items: kartu.map((value){
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
                        value.length < 10
                            ? 'nomor yang dimasukkan kurang dari 10'
                            : null,
                        onChanged: (value) {
                          setState(() => nomorKartu = value);
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(

                          ),
                          labelText: 'Nomor kartu',
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
                              bool transfer = await pulsaService.checkSaldo(
                                  AuthAccount().getCurrentUID(context), selectNominal);
                              if (transfer) {
                                DateTime selectedDate = DateTime.now();

                                //untuk convert dari dateTime ke int
                                int time = selectedDate.millisecondsSinceEpoch;
                                await pulsaService.createPulsa(AuthAccount().getCurrentUID(context),
                                    selectKartu, nomorKartu, selectNominal, time);

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