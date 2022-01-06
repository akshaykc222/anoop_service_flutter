import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seed_sales/componets.dart';
import 'package:seed_sales/constants.dart';
import 'package:seed_sales/screens/login/provider/login_provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final userName = TextEditingController();
  final passWord = TextEditingController();
  // bool isLoading = false;
  Future<void> _is_valid() async {
    if (formKey.currentState!.validate()) {
      Provider.of<LoginProvider>(context, listen: false)
          .loign(userName.text, passWord.text, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Center(
          child: Form(
        key: formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Continue with",
                style: TextStyle(fontSize: 20, color: whiteColor),
              ),
              spacer(10),
              const Text(
                "Login",
                style: TextStyle(
                    fontSize: 30, fontWeight: FontWeight.bold, color: whiteColor),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                  width: 300,
                  child: Column(children: [
                    const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 16)),
                    TextFormField(
                      controller: userName,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter user name";
                        }
                        return null;
                      },
                      style: const TextStyle(color: whiteColor),
                      cursorColor: Colors.grey[500],
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red.shade500, width: 1)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.shade500, width: 1)),
                        // hintText: "Username", //Placeholder
                        // border: OutlineInputBorder(), //Gives Overall border
                        fillColor: Colors.grey[200],
                        // border: BorderStyle(Colors.grey),
                        labelText: "Username", //Gives Label
                        labelStyle: const TextStyle(
                          color: whiteColor,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ])),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: passWord,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Password";
                    } else if (value.length < 5) {
                      return "password need at least 5 character";
                    }
                    return null;
                  },
                  style: const TextStyle(color: whiteColor),
                  keyboardType: TextInputType.visiblePassword,
                  cursorColor: Colors.grey[500],
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.red.shade500, width: 1)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.shade500, width: 1)),
                    fillColor: Colors.grey[200],
                    labelText: 'Password',
                    labelStyle: const TextStyle(
                      color: whiteColor,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Consumer<LoginProvider>(builder: (context, snapshot, child) {
                return SizedBox(
                    width: 300,
                    height: 50,
                    // color: Colors.green,
                    child: ElevatedButton(
                      onPressed: () {
                        _is_valid();
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red[500],
                          textStyle: const TextStyle(
                            fontSize: 15,
                          )),
                      child: snapshot.loading
                          ? const Padding(
                              padding: EdgeInsets.all(2),
                              child: CircularProgressIndicator(
                                color: whiteColor,
                              ),
                            )
                          : const Text("Login"),
                    ));
              }),
              const SizedBox(
                height: 20,
              ),
              // Text("Forgot Password?",
              //     style: TextStyle(
              //       color: Colors.grey[600],
              //     )),
            ],
          ),
        ),
      )),
    ));
  }
}
