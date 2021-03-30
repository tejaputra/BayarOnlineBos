import 'package:e_payment/data/AuthAccount.dart';
import 'package:e_payment/data/DatabaseService.dart';
import 'package:flutter/material.dart';

import 'MainScreen.dart';

class TransferScreen extends StatefulWidget{
  TransferState createState() => TransferState();
}
class TransferState extends State<TransferScreen>{
  final _formkey = GlobalKey<FormState>();

  List<int> Nominal = [10000,20000,50000,100000,200000,500000,1000000];
  int selectNominal = 10000;
  List<String> bank = ["BCA","Mandiri","BNI","DBS","Sinarmas","Permata","Jatim"];
  String selectBank = "BCA";
  String selectNoRekening = "";
  String error = '';

  @override
  Widget build(BuildContext context) {
    DatabaseService transferService = DatabaseService();

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Transfer",
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
                          child: new Divider(),
                        )
                    ),
                    Text(
                      "Nominal",
                      style:  TextStyle(fontSize: 20),
                    ),
                    DropdownButton(
                      value: selectNominal,
                      isExpanded: true,
                      onChanged: (value){
                        setState(() {
                          selectNominal = value;
                        });
                      },
                      items: Nominal.map((value){
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value.toString()),);
                      },
                      ).toList(),
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
                            bool transfer = await transferService.checkSaldo(AuthAccount().getCurrentUID(context), selectNominal);
                            if(transfer){
                              DateTime selectedDate = DateTime.now();

                              //untuk convert dari dateTime ke int
                              int time = selectedDate.millisecondsSinceEpoch;
                              await transferService.createTransfer(AuthAccount().getCurrentUID(context), selectBank,selectNoRekening,selectNominal, time);
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
                        child: Text('Transfer'),
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
                  ],
                ),
              )
          ),
        )
    );
  }
}