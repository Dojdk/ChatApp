import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email, String username, String password,
      bool login, BuildContext ctx) submit;
  final bool isLoading;
  const AuthForm({Key? key, required this.submit, required this.isLoading})
      : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _username = '';
  String _password = '';
  String _email = '';
  void _trysubmit() {
    final valid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (valid) {
      _formKey.currentState!.save();
      widget.submit(
        _email.trim(),
        _username.trim(),
        _password.trim(),
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    key: const ValueKey('mail'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value!.isEmpty && !value.contains('@')) {
                        return 'Give a valid email please';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value!;
                    },
                  ),
                  TextFormField(
                    key: const ValueKey('password'),
                    decoration: const InputDecoration(labelText: 'Password'),
                    validator: (value) {
                      if (value!.isEmpty && value.length < 6) {
                        return 'Give a valid password please';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value!;
                    },
                    obscureText: true,
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('username'),
                      decoration: const InputDecoration(
                        labelText: 'UserName',
                      ),
                      validator: (value) {
                        if (value!.isEmpty && value.length < 3) {
                          return 'Give a valid username please';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _username = value!;
                      },
                    ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (widget.isLoading) const CircularProgressIndicator(),
                  if (widget.isLoading)
                    const SizedBox(
                      height: 12,
                    ),
                  if (!widget.isLoading)
                    ElevatedButton(
                        onPressed: () {
                          _trysubmit();
                        },
                        child: _isLogin
                            ? const Text('Log in')
                            : const Text('Sign up')),
                  if (!widget.isLoading)
                    TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: _isLogin
                            ? const Text('Create account')
                            : const Text('I already have an account')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
