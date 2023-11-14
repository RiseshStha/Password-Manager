import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool _obscureTextPassword = true;
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   backgroundColor: Colors.yellow,
    //   body: Center(
    //     child: Container(
    //       height: 200,
    //       // width: MediaQuery.of(context).size.width,
    //       // alignment: Alignment.center,
    //       color: Colors.blue,
    //       padding: const EdgeInsets.all(20),
    //       child: Column(
    //         children: [
    //           const SizedBox(
    //             height: 10,
    //           ),
    //           const Text("Welcome to Password Manager"),
    //           const SizedBox(
    //             height: 30,
    //           ),
    //           TextFormField(
    //             obscureText: _obscureTextPassword,
    //             style: const TextStyle(fontFamily: 'WorkSansSemiBold', fontSize: 16.0, color: Colors.black),
    //             decoration: InputDecoration(
    //               enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
    //               focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
    //               prefixIcon: const Icon(
    //                 Icons.lock,
    //                 size: 22.0,
    //                 color: Colors.black,
    //               ),
    //               hintText: 'Password',
    //               hintStyle: const TextStyle(fontFamily: 'WorkSansSemiBold', fontSize: 17.0),
    //               suffixIcon: GestureDetector(
    //                 onTap: () {
    //                   setState(() {
    //                     _obscureTextPassword = !_obscureTextPassword;
    //                   });
    //                 },
    //                 child: Icon(
    //                   _obscureTextPassword ? Icons.visibility : Icons.visibility_off,
    //                   size: 20.0,
    //                   color: Colors.black,
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    return Scaffold(
      body : Column(
        children: [
        TextFormField(
                    obscureText: _obscureTextPassword,
                    style: const TextStyle(fontFamily: 'WorkSansSemiBold', fontSize: 16.0, color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      prefixIcon: const Icon(
                        Icons.lock,
                        size: 22.0,
                        color: Colors.black,
                      ),
                      hintText: 'Password',
                      hintStyle: const TextStyle(fontFamily: 'WorkSansSemiBold', fontSize: 17.0),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureTextPassword = !_obscureTextPassword;
                          });
                        },
                        child: Icon(
                          _obscureTextPassword ? Icons.visibility : Icons.visibility_off,
                          size: 20.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
        ],
      ),
    );
  }
}
