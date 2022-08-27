// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store/views/widgets/snackbar.dart';

import '../../widgets/auth_widget.dart';

class CustomerLogin extends StatefulWidget {
  const CustomerLogin({Key? key}) : super(key: key);

  @override
  State<CustomerLogin> createState() => _CustomerLoginState();
}

class _CustomerLoginState extends State<CustomerLogin> {
  late String email;
  late String password;

  bool processing = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  bool passwordVisible = true;

  void logIn() async {
    setState(() {
      processing = true;
    });
    if (_formKey.currentState!.validate()) {
      try {
        //Đăng ký tài khoản
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        _formKey.currentState!.reset();

        Navigator.pushReplacementNamed(context, '/user_screen');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          setState(() {
            processing = false;
          });
          MessageHandler.showSnackSar(
              _scaffoldKey, 'No user found for that email.');
        } else if (e.code == 'wrong-password') {
          setState(() {
            processing = false;
          });
          MessageHandler.showSnackSar(
              _scaffoldKey, 'Wrong password provided for that user.');
        }
      }
    } else {
      setState(() {
        processing = false;
      });
      MessageHandler.showSnackSar(_scaffoldKey, 'Please fill all fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AuthHeader(
                        lable: 'Log In',
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            } else if (value.isValidEmail() == false) {
                              return 'invalid email!';
                            } else if (value.isValidEmail() == true) {
                              return null;
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                          decoration: textFormDecoration.copyWith(
                            labelText: 'Email Address',
                            hintText: 'Enter your Email',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          obscureText: passwordVisible,
                          decoration: textFormDecoration.copyWith(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                              icon: Icon(
                                passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.lightBlue,
                              ),
                            ),
                            labelText: 'Password',
                            hintText: 'Enter your password',
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forget password ?',
                            style: TextStyle(
                                fontSize: 18, fontStyle: FontStyle.italic),
                          )),
                      HaveAcount(
                        haveaccount: 'Don\'t Have Account? ',
                        actionLabel: 'Sign Up',
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/customer_register');
                        },
                      ),
                      processing == true
                          ? const Center(child: CircularProgressIndicator())
                          : AuthMainButton(
                              labelbutton: 'Log In',
                              onPressed: () {
                                logIn();
                              },
                            )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
