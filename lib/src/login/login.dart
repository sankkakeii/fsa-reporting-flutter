import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../fsaForm/fsaform.dart';
import '../register/register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  static const routeName = '/login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  String password = '';
  String errorMessage = '';
  String bgImageUrl = "assets/images/backgrounds/bg.png";

  void handleLogin() async {
    try {
      // Validate email and password
      if (email.isEmpty || password.isEmpty) {
        setState(() {
          errorMessage = 'Please enter both email and password.';
        });
        return;
      }

      // Construct the payload
      final Map<String, String> payload = {
        'email': email,
        'password': password,
      };

      // Convert payload to JSON
      final String jsonPayload = jsonEncode(payload);

      // Send login request
      final http.Response response = await http.post(
        Uri.parse(
            // 'https://proxy.cors.sh/https://fintecgrate.com/xooxoxo/api/fsalogin.php'),
            'https://fintecgrate.com/xooxoxo/api/fsalogin.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-cors-api-key': 'temp_5cad65143af4adbc1f2df88cd73fe8c6'
        },
        body: jsonPayload,
      );

      if (response.statusCode == 200) {
        // Parse the response body
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (responseBody.containsKey('status') && responseBody['status']) {
          // If login successful, redirect to FSA form page using named route
          Navigator.pushReplacementNamed(
            // ignore: use_build_context_synchronously
            context,
            FSAForm.routeName,
            arguments: {'email': email}, // Pass email as an argument
          );
        } else if (responseBody.containsKey('message')) {
          // If login failed, display error message from response
          setState(() {
            errorMessage = responseBody['message'];
          });
        } else {
          // If status is not true and no message is returned, display a generic error message
          setState(() {
            errorMessage = 'Invalid email or password. Please try again.';
          });
        }
      } else {
        // If response status code is not 200, display a generic error message with status code
        setState(() {
          errorMessage = 'Failed to login. Status code: ${response.statusCode}';
        });
      }
    } catch (error) {
      // Catch any unhandled exceptions and display error message
      setState(() {
        errorMessage = 'Error logging in: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bgImageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 30,
                        color: Color.fromARGB(255, 59, 59, 59),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(color: Colors.blue),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 30.0,
                        )),
                    onPressed: handleLogin,
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 10.0),
                  TextButton(
                    onPressed: () {
                      // Navigate to the registration page
                      Navigator.pushNamed(context, Registration.routeName);
                    },
                    child: const Text('Register'),
                  ),
                  if (errorMessage.isNotEmpty) ...[
                    const SizedBox(height: 20.0),
                    Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
