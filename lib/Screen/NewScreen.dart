import 'package:flutter/material.dart';

import 'LoginScene.dart';
import 'RegisterScene.dart';

class NewScreen extends StatefulWidget {
  @override
  NewState createState() => NewState();
}
class NewState extends State<NewScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Bayar Online Bos",
            style: TextStyle(fontSize: 30),
          ),
        ),
        body:  SingleChildScrollView(
            child:Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image(
                    image: AssetImage('assets/icons/intro2.png'),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Nikmati berbagai layanan dan kemudahan dalam pembayaran dalam genggaman tangan anda.",
                      textDirection: TextDirection.ltr,
                      maxLines: 5,
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      },
                      child: Text('Login'),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterScreen()),
                        );
                      },
                      child: Text('Register'),
                    ),
                  ),
                ],
              )
          )
        )
    );
  }
}