import 'package:e_payment/data/AuthAccount.dart';
import 'package:e_payment/data/DatabaseService.dart';
import 'package:flutter/material.dart';

import 'MainScreen.dart';

class BPJSScreen extends StatefulWidget{
  BPJSState createState() => BPJSState();
}

class BPJSState extends State<BPJSScreen>{
  final _formkey = GlobalKey<FormState>();

  List<String> BPJS = ["BPJS Kesehatan","BPJSTK Individu"];
  String selectBPJS = "BPJS Kesehatan";
  String selectNomorBPJS;
  String selectNominal;
  String error = "";

  @override
  Widget build(BuildContext context) {
    DatabaseService bpjsService = DatabaseService();

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Pembayaran BPJS",
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
                        "Tipe BPJS",
                        style:  TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 10),
                      DropdownButton(
                        value: selectBPJS,
                        isExpanded: true,
                        onChanged: (value){
                          setState(() {
                            selectBPJS = value;
                          });
                        },
                        items: BPJS.map((value){
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
                        value.length != 11
                            ? 'nomor BPJS salah. total digit yaitu 11'
                            : null,
                        onChanged: (value) {
                          setState(() => selectNomorBPJS = value);
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(

                          ),
                          labelText: 'Nomor BPJS',
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
                              bool transfer = await bpjsService.checkSaldo(
                                  AuthAccount().getCurrentUID(context),
                                  int.parse(selectNominal));
                              if (transfer) {
                                DateTime selectedDate = DateTime.now();

                                //untuk convert dari dateTime ke int
                                int time = selectedDate.millisecondsSinceEpoch;
                                await bpjsService.createBPJS(
                                    AuthAccount().getCurrentUID(context),
                                    selectBPJS, selectNomorBPJS,
                                    int.parse(selectNominal), time);
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