import 'package:flutter/material.dart';
import 'package:movies_app/pages/movies/movies_index.dart';
import 'package:movies_app/services/authentication_services.dart';
import 'package:movies_app/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.setSignedIn}) : super(key: key);

  final void Function(bool signedIn) setSignedIn;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _showSuccessMessage = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _loginFormKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Success message
                    if (_showSuccessMessage)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          'Account created successfully!',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    // Email TextFormField
                    TextFormField(
                      controller: _emailController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email Address',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    // Password TextFormField
                    TextFormField(
                      controller: _passwordController,
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    // Submit button
                    ElevatedButton(
                      onPressed: () async {
                        if (_loginFormKey.currentState!.validate()) {
                          try {
                            final result = await AuthenticationServices.login(
                              _emailController.text,
                              _passwordController.text,
                            );
                            widget.setSignedIn(true);
                            Navigator.pop(context);
                          } catch (e) {
                            widget.setSignedIn(false);
                          }
                        }
                      },
                      child: const Text('Log In'),
                    ),
                    const SizedBox(height: 8),
                    // Register button
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(
                              setSignedIn: (signedIn) {
                                if (signedIn) {
                                  setState(() {
                                    _showSuccessMessage = true;
                                  });
                                }
                              },
                            ),
                          ),
                        );
                      },
                      child: const Text('Register'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
