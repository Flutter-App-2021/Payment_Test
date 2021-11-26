import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.signup, this.isLoading, this.login);

  final bool isLoading;
  final Future<void> Function(String email, String phoneNo, String password,
      bool isLogin, BuildContext ctx) signup;
  final Future<void> Function(String email, String password) login;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  dynamic _userEmail = '';
  dynamic _userPhoneNo = '';
  dynamic _userPassword;

  signUpFn() {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (isValid!) {
      _formKey.currentState?.save();
      widget.signup(
        _userEmail?.trim(),
        _userPhoneNo?.trim(),
        _userPassword?.trim(),
        _isLogin,
        context,
      );
    }
  }

  logInFn() {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (isValid!) {
      _formKey.currentState?.save();
      widget.login(
        _userEmail?.trim(),
        _userPassword?.trim()
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Builder(
      builder: (context) {
        return Center(
          child: Card(
            margin: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        key: ValueKey('email'),
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        enableSuggestions: false,
                        validator: (value) {
                          if (value?.isEmpty == null || !value!.contains('@')) {
                            return 'Please Enter valid Email Address.';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                        ),
                        onSaved: (value) {
                          _userEmail = value;
                        },
                      ),
                      if (!_isLogin)
                        TextFormField(
                            key: ValueKey('phoneNo'),
                            autocorrect: true,
                            textCapitalization: TextCapitalization.words,
                            enableSuggestions: false,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Mobile Number.';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Mobile Number',
                            ),
                            onSaved: (value) {
                              _userPhoneNo = value;
                            }),
                      TextFormField(
                          key: ValueKey('password'),
                          validator: (value) {
                            if (value?.isEmpty == null || value!.length < 7) {
                              return 'Password must be atleast 7 characters long';
                            }
                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                          ),
                          onSaved: (value) {
                            _userPassword = value;
                          }),
                      SizedBox(
                        height: 12,
                      ),
                      if (widget.isLoading) CircularProgressIndicator(),
                      if (!widget.isLoading)
                        _isLogin
                            ? ElevatedButton(
                                onPressed: logInFn, child: Text('Login'))
                            : ElevatedButton(
                                child: Text('Sign Up'),
                                onPressed: signUpFn,
                              ),
                      if (!widget.isLoading)
                        TextButton(
                          child: Text(_isLogin
                              ? 'Create a new account'
                              : 'I already have an account'),
                          style: TextButton.styleFrom(primary: Colors.deepPurple),
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
