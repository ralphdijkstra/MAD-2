import 'package:flutter/material.dart';
import 'package:movies_app/services/authentication_services.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.setSignedIn}) : super(key: key);

  final void Function(bool signedIn) setSignedIn;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
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
              key: _registerFormKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Name TextFormField
                    TextFormField(
                      controller: _nameController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
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
                        if (_registerFormKey.currentState!.validate()) {
                          try {
                            final result = await AuthenticationServices.register(
                              _emailController.text,
                              _passwordController.text,
                              _nameController.text,
                            );
                            if (result) {
                              // Registration success
                              widget.setSignedIn(true); // Go back to the login page
                            } else {
                              // Registration failed
                              widget.setSignedIn(false);
                            }
                          } catch (e) {
                            // Error occurred during registration
                            widget.setSignedIn(false);
                          }
                        }
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