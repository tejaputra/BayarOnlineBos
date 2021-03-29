import 'package:e_payment/Screen/MainScreen.dart';
import 'package:e_payment/data/AuthAccount.dart';
import 'package:e_payment/data/DatabaseService.dart';
import 'package:flutter/material.dart';

class IsiSaldoScreen extends StatefulWidget{
  IsiSaldoState createState() => IsiSaldoState();
}

class IsiSaldoState extends State<IsiSaldoScreen> {
  List<int> saldo = [10000,20000,50000,100000,200000,500000,1000000];
  int selectSaldo = 10000;
  List<String> bank = ["BCA","Mandiri","BNI","DBS","Sinarmas","Permata","Jatim"];
  String selectBank = "BCA";
  String selectNoRekening = "";

  final _formkey = GlobalKey<FormState>();

  DatabaseService _isiSaldoData = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Isi Saldo",
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),
          ),
        ),
        body:  SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
              key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bank",
                      style:  TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    DropdownButton(
                      value: selectBank,
                      isExpanded: true,
                      onChanged: (value){
                        setState(() {
                          selectBank = value;
                        });
                      },
                      items: bank.map((value){
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value.toString()),);
                      },
                      ).toList(),
                    ),
                    SizedBox(height: 20,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: new Divider(
                            thickness: 2,
                          ),
                        )
                    ),
                    TextFormField(
                      validator: (value) =>
                      value.length < 6
                          ? 'masukan nomor rekening lebih dari 9 angka'
                          : null,
                      onChanged: (value) {
                        setState(() => selectNoRekening = value);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(

                        ),
                        labelText: 'Nomor Rekening',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 20,
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
                      value: selectSaldo,
                      isExpanded: true,
                      onChanged: (value){
                        setState(() {
                          selectSaldo = value;
                        });
                      },
                      items: saldo.map((value){
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value.toString()),);
                      },
                      ).toList(),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            DateTime selectedDate = DateTime.now();

                            //untuk convert dari dateTime ke int
                            int time = selectedDate.millisecondsSinceEpoch;
                            //print(selectedDate);
                            //print(time);

                            //untuk convert dari int ke dateTime
                            /*selectedDate = DateTime.fromMillisecondsSinceEpoch(time);
                            print(selectedDate);*/

                            await _isiSaldoData.createSaldo(
                                AuthAccount().getCurrentUID(context), selectSaldo,
                                selectBank, selectNoRekening,time);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainScreen(),
                              ),
                            );
                          };
                        },
                        child: Text('Isi Saldo'),
                      )
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
                  ],
                ),
              )
          ),
        )
    );
  }
}