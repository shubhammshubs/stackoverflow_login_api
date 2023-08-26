import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Home_page.dart';

void main() {
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final String apiUrl =
        'https://api.trifrnd.com/portal/Attend.php?apicall=login';

    final response = await http.post(Uri.parse(apiUrl), body: {
      "mobile": _mobileController.text,
      "password": _passwordController.text,
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print("Response body: ${response.body}");

      print("Decoded data: $responseData");

      if (responseData == "Login Done" ) {
        // Login successful, you can navigate to the next screen
        print("Login successful");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home_page()),
        );

      } else {
        // Login failed, show an error message
        print("Login failed");
      }

    } else {
      // Handle error if the API call was not successful
      print("API call failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _mobileController,
                decoration: InputDecoration(labelText: 'Mobile Number'),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
