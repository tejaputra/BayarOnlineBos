import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_payment/data/AuthAccount.dart';
import 'package:e_payment/data/DatabaseService.dart';
import 'package:e_payment/data/Loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryScene extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<HistoryScene> {
  final AuthAccount _mainData = AuthAccount();
  final DatabaseService data = DatabaseService();

  List<String> history = ["Isi Saldo","Transfer","PLN","Pulsa","VoucherGame","BPJS"];
  String selectHistory = "Isi Saldo";

  @override
  Widget build(BuildContext context) {

    Future getUserSaldo(String selected) async {
      final CollectionReference dataTransactionCollection = Firestore.instance.collection('Data Transaction');

      QuerySnapshot dataUserSaldo = await dataTransactionCollection.document(_mainData.getCurrentUID(context)).collection(selected).getDocuments();

      return dataUserSaldo.documents;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("History Aktivitas",
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding:  const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  "Pilih History",
                  style:  TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                DropdownButton(
                  value: selectHistory,
                  isExpanded: true,
                  onChanged: (value){
                    setState(() {
                      selectHistory = value;
                    });
                  },
                  items: history.map((value){
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value.toString()),);
                  },
                  ).toList(),
                ),
                SizedBox(height: 30),
                Expanded(
                  child: FutureBuilder(
                      future: getUserSaldo(selectHistory),
                      builder: (_,snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting ){
                          return Center(
                            child: Loading()
                          );
                        } else if (snapshot.hasError){
                          return Center(
                              child: Text('no data'),
                          );
                        } else {
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (_,index){

                                //=================================================================
                                //history Isi Saldo dan Transfer
                                if(selectHistory == "Isi Saldo" || selectHistory == "Transfer"){
                                  return Container(
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data[index].data["bank"],
                                              style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),

                                            ),
                                            Text("rekening tujuan : " + snapshot.data[index].data["rekening"],
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text("nominal : Rp. " + snapshot.data[index].data["nominal"].toString(),
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text(
                                              DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].data["time"]).hour.toString() + " : "
                                                  + DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].data["time"]).minute.toString() + " : "
                                                  + DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].data["time"]).second.toString() + "   "
                                                  + DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].data["time"]).day.toString() + " - "
                                                  + DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].data["time"]).month.toString() + " - "
                                                  + DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].data["time"]).year.toString(),
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (selectHistory == "PLN"){

                                  //=================================================================
                                  //history PLN
                                  return Container(
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("nomor PLN  : " + snapshot.data[index].data["nomor_pln"],
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text("nominal : Rp. " + snapshot.data[index].data["nominal"].toString(),
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text(
                                              DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].data["time"]).hour.toString() + " : "
                                                  + DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].data["time"]).minute.toString() + " : "
                                                  + DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].data["time"]).second.toString() + "   "
                                                  + DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].data["time"]).day.toString() + " - "
                                                  + DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].data["time"]).month.toString() + " - "
                                                  + DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].data["time"]).year.toString(),
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (selectHistory == "Pulsa"){

                                  //=================================================================
                                  //history Pulsa
                                  return Container(
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data[index].data["kartu"],
                                              style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),

                                            ),
                                            Text("nomor kartu  : " + snapshot.data[index].data["nomor_kartu"],
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text("nominal : Rp. " + snapshot.data[index].data["nominal"].toString(),
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text(
                                              DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].data["time"]).hour.toString() + " : "
                                                  + DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].data["time"]).minute.toString() + " : "
                                                  + DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].data["time"]).second.toString() + "   "
                                                  + DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].data["time"]).day.toString() + " - "
                                                  + DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].data["time"]).month.toString() + " - "
                                                  + DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].data["time"]).year.toString(),
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (selectHistory == "VoucherGame"){

                                  //=================================================================
                                  //history Voucher Game
                                  return Container(
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data[index].data["game"],
                                              style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),

                                            ),
                                            Text("id game : " + snapshot.data[index].data["id_game"],
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text("nominal : Rp. " + snapshot.data[index].data["nominal"].toString(),
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text(
                                              DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].data["time"]).hour.toString() + " : "
                                                  + DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].data["time"]).minute.toString() + " : "
                                                  + DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].data["time"]).second.toString() + "   "
                                                  + DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].data["time"]).day.toString() + " - "
                                                  + DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].data["time"]).month.toString() + " - "
                                                  + DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].data["time"]).year.toString(),
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (selectHistory == "BPJS"){

                                  //=================================================================
                                  //history BPJS
                                  return Container(
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data[index].data["bpjs"],
                                              style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),

                                            ),
                                            Text("nomor BPJS : " + snapshot.data[index].data["no_bpjs"],
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text("nominal : Rp. " + snapshot.data[index].data["nominal"].toString(),
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text(
                                              DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].data["time"]).hour.toString() + " : "
                                                  + DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].data["time"]).minute.toString() + " : "
                                                  + DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].data["time"]).second.toString() + "   "
                                                  + DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].data["time"]).day.toString() + " - "
                                                  + DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].data["time"]).month.toString() + " - "
                                                  + DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].data["time"]).year.toString(),
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return null;
                                }
                              }
                          );
                        }
                      }
                  ),
                )
              ],
            ),
          )
        ),
      )
    );
  }
}
