
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_payment/Screen/HistoryScreen.dart';
import 'package:e_payment/Screen/NewScreen.dart';
import 'package:e_payment/Screen/selection.dart';
import 'package:e_payment/data/Account.dart';
import 'package:e_payment/data/AuthAccount.dart';
import 'package:e_payment/data/DatabaseService.dart';
import 'package:e_payment/data/Loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'BPJSScreen.dart';
import 'IsiSaldoScreen.dart';
import 'PLNScreen.dart';
import 'PulsaScreen.dart';
import 'RegisterScene.dart';
import 'TransferScreen.dart';
import 'VoucherGameScreen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  MainState createState() => MainState();
}

class MainState extends State<MainScreen>{
  bool loading = true;
  final AuthAccount _mainData = AuthAccount();
  @override
  Widget build(BuildContext context) {
    DatabaseService mainService = DatabaseService();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Bayar Online Bos",
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),
        ),
        actions: [
          FlatButton.icon(

            icon: Icon(Icons.person),
            label: Text("Logout"),
            onPressed: () async {
              await _mainData.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => selection(),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: mainService.getData(_mainData.getCurrentUID(context)),
        builder: (_,snapshot){
          switch (snapshot.connectionState) {
            case ConnectionState.none: return new Text('Press button to start');
            case ConnectionState.waiting:return Loading();
            default:
              return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*Text(
                  nickname,
                  style: TextStyle(fontSize: 16),
                ),*/
                      Text(snapshot.data.data["nickname"],
                        style: TextStyle(fontSize: 16),
                      ),

                      SizedBox(height: 10),
                      Text(
                        'Cash',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text("Rp. " + snapshot.data.data["saldo"].toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 30,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: new Divider(
                              thickness: 2,
                            ),
                          )
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => IsiSaldoScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10),
                            ),
                            child: Column(
                              children: [
                                Icon(Icons.add_circle_outline),
                                SizedBox(height: 5),
                                Text('Isi Saldo'),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TransferScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10),
                            ),
                            child: Column(
                              children: [
                                Icon(Icons.arrow_circle_up),
                                SizedBox(height: 5),
                                Text('Transfer'),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HistoryScene()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10),
                            ),
                            child: Column(
                              children: [
                                Icon(Icons.history),
                                SizedBox(height: 5),
                                Text('History'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: new Divider(
                              thickness: 2,
                            ),
                          )
                      ),
                      Expanded(
                        child: GridView.count(
                            primary: false,
                            padding: const EdgeInsets.all(20),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 3,
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PLNScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.flash_on),
                                    SizedBox(height: 5),
                                    Text('PLN'),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PulsaScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.phone_android),
                                    SizedBox(height: 5),
                                    Text('Pulsa'),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VoucherGameScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.videogame_asset),
                                    SizedBox(height: 5),
                                    Text('Voucher Game'),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BPJSScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.local_hospital),
                                    SizedBox(height: 5),
                                    Text('BPJS'),
                                  ],
                                ),
                              ),
                            ]
                        ),
                      ),

                    ],
                  )
              );
          }
        }
      ),
    );
  }
}
/*
FutureBuilder(
        future: mainService.getData(_mainData.getCurrentUID(context)),
        builder: (_,snapshot){
          switch (snapshot.connectionState) {
            case ConnectionState.none: return new Text('Press button to start');
            case ConnectionState.waiting:return Text("");
            default:
              loading = false;
              return new Text('${snapshot.data.data["nickname"]}');
          }
        }
        )
 */
/*
return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Bayar Online Bos",
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),
          ),
          actions: [
            FlatButton.icon(

                icon: Icon(Icons.person),
                label: Text("Logout"),
                onPressed: () async {
                  await _mainData.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => selection(),
                    ),
                  );
              },
            ),
          ],
        ),
        body:  Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*Text(
                  nickname,
                  style: TextStyle(fontSize: 16),
                ),*/

                FutureBuilder<DocumentSnapshot>(
                  future: mainService.getData(_mainData.getCurrentUID(context)), // a Future<String> or null
                  builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none: return new Text('Press button to start');
                      case ConnectionState.waiting:return Text("");
                      default:
                        loading = false;
                        return new Text('${snapshot.data.data["nickname"]}');
                    }
                  },
                ),

                SizedBox(height: 10),
                Text(
                  'Cash',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                FutureBuilder<String>(
                  future: mainService.getDataSaldo(_mainData.getCurrentUID(context)), // a Future<String> or null
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none: return new Text('Press button to start');
                      case ConnectionState.waiting: return Text("");
                      default:
                        return new Text('Rp. ${snapshot.data}');
                    }
                  },
                ),
                SizedBox(height: 30,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: new Divider(
                        thickness: 2,
                      ),
                    )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        String data = await mainService.getDataSaldo(_mainData.getCurrentUID(context));
                        //print(data.data['nickname']);
                        print(data);

                        print(_mainData.getCurrentUID(context));

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IsiSaldoScreen(),
                          ),
                        );
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => IsiSaldoScreen()),
                        );*/
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.add_circle_outline),
                          SizedBox(height: 5),
                          Text('Isi Saldo'),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TransferScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.arrow_circle_up),
                          SizedBox(height: 5),
                          Text('Transfer'),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HistoryScene()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.history),
                          SizedBox(height: 5),
                          Text('History'),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: new Divider(
                        thickness: 2,
                      ),
                    )
                ),
                Expanded(
                  child: GridView.count(
                      primary: false,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 3,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PLNScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.flash_on),
                              SizedBox(height: 5),
                              Text('PLN'),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PulsaScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.phone_android),
                              SizedBox(height: 5),
                              Text('Pulsa'),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => VoucherGameScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.videogame_asset),
                              SizedBox(height: 5),
                              Text('Voucher Game'),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BPJSScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.local_hospital),
                              SizedBox(height: 5),
                              Text('BPJS'),
                            ],
                          ),
                        ),
                      ]
                  ),
                ),

              ],
            )
        )
    );
     */
