import 'package:e_payment/data/AuthAccount.dart';
import 'package:e_payment/data/Loading.dart';
import 'package:flutter/material.dart';
import '';

import 'MainScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final AuthAccount _loginData = AuthAccount();
  String email = "";
  String password = "";
  String error = "";
  bool loading = false;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Login Akun",
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),
          ),
        ),
        body: loading ? Loading() : SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'masukan email' : null,
                      onChanged: (val){
                        setState(() => email = val);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                        ),
                        labelText: 'Email',
                        hintText: 'untuk login',
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      validator: (val) => val.length < 6 ? 'masukan password lebih dari 6 karakter' : null,
                      onChanged: (val){
                        setState(() => password = val);
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'untuk login'
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if(_formkey.currentState.validate()){
                            setState(() => loading = true);
                            dynamic result = await _loginData.signInWEmailandPassword(email,password);
                            if(result == null){
                              setState(() => error = 'gagal masuk. email atau password salah');
                              setState(() => loading = false);
                            } else {
                              Navigator.popUntil(context, (route) => route.isFirst);
                            }
                          }
                        },
                        child: Text('Masuk'),
                      ),
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    )
                  ],
                )
            )
          ),
        )
    );
  }
}