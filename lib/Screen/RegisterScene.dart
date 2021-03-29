import 'package:e_payment/data/AuthAccount.dart';
import 'package:e_payment/data/Loading.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  RegisterState createState() => RegisterState();
}
class RegisterState extends State<RegisterScreen> {

  AuthAccount _registerData = new AuthAccount();

  //untuk editing textfield
  final usernameTexFie = TextEditingController();
  final passwordTexFie = TextEditingController();
  final confirmPasswordTexFie = TextEditingController();
  final nicknameTexFie = TextEditingController();
  final emailTexFie = TextEditingController();
  final phoneNumberTexFie = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String confirmPassword = '';
  String nickname = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Pendaftaraan akun",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        body: loading ? Loading() : SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: Text(
                            'Registrasi akun.',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),

                        TextFormField(
                          validator: (value) =>
                          value.isEmpty
                              ? 'email tidak boleh kosong'
                              : null,
                          onChanged: (value) {
                            setState(() => email = value);
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
                          validator: (value) =>
                          value.length < 6
                              ? 'masukan password lebih dari 6 karakter'
                              : null,
                          onChanged: (value) {
                            setState(() => password = value);
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                              hintText: 'untuk login'
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          validator: (value) =>
                          value != password
                              ? 'password tidak sama'
                              : null,
                          onChanged: (value) {
                            setState(() => confirmPassword = value);
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'confirm Password',
                              hintText: ''
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          validator: (val) =>
                          val.isEmpty ? 'nickname tidak boleh kosong' : null,
                          onChanged: (val) {
                            setState(() => nickname = val);
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Nama Lengkap',
                              hintText: 'nama anda'
                          ),
                          controller: nicknameTexFie,
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formkey.currentState.validate()) {
                                setState(() => loading = true);
                                dynamic result = await _registerData.registerWEmailandPassword(email, password,nickname);
                                if (result == null) {
                                  setState(() => error = 'penulisan email salah');
                                  setState(() => loading = false);
                                } else {
                                  Navigator.popUntil(context, (route) =>
                                  route.isFirst);
                                }
                              }
                            },
                            child: Text('Daftar'),
                          ),
                        ),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        )
                      ],
                    )
                )
            )
        )
    );
  }
}