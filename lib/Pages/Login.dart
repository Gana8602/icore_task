import 'package:flutter/material.dart';
import 'package:icore/Pages/Home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final String validUsername = 'Gana1234';
  final String validPassword = 'Pass@1234';

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String usernameError = '';
  String passwordError = '';
  String errorMessage = '';

  void login() {
    String enteredUsername = usernameController.text;
    String enteredPassword = passwordController.text;

    setState(() {
      usernameError =
          enteredUsername.isEmpty ? 'Please enter your username' : '';
      passwordError =
          enteredPassword.isEmpty ? 'Please enter your password' : '';
    });

    if (enteredUsername == validUsername && enteredPassword == validPassword) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
      setState(() {
        errorMessage = 'Login Successful!';
      });
    } else {
      setState(() {
        errorMessage = 'Invalid username or password. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  errorText: usernameError,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  errorText: passwordError,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: login,
                child: const Text('Login'),
              ),
              const SizedBox(height: 16),
              Text(
                errorMessage,
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
