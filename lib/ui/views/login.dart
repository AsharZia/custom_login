import 'package:custom_login/bloc/models/login.dart';
import 'package:custom_login/bloc/viewModels/auth_model.dart';
import 'package:custom_login/ui/shared/passwordField.dart';
import 'package:custom_login/ui/views/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  final emailTextField = TextEditingController();
  final passwordTextField = TextEditingController();
  AuthModel authBloc;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthModel>(
      builder: (context, bloc, child) {
        this.authBloc = bloc;
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTitleWidget(context),
                    SizedBox(height: 32.0),
                    Text('Email'),
                    SizedBox(height: 4.0),
                    buildEmailTextField(),
                    SizedBox(height: 16.0),
                    Text('Password'),
                    SizedBox(height: 4.0),
                    buildPasswordField(),
                    SizedBox(height: 16.0),
                    buildLoginButton(context),
                    SizedBox(height: 16.0),
                    buildForgotPasswordButton(context),
                    buildORWidget(),
                    SizedBox(height: 8.0),
                    buildExploreAppButton(context)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Center buildTitleWidget(BuildContext context) {
    return Center(
      child: Text(
        'Welcome',
        style: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(color: Color(0xFF4B4C4B)),
      ),
    );
  }

  TextFormField buildEmailTextField() {
    return TextFormField(
      controller: emailTextField,
      enabled: isLoading ? false : true,
      keyboardType: TextInputType.emailAddress,
      validator: (email) {
        if (email.isEmpty) {
          return 'Email is required';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.12),
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        hintText: 'e.g. johndoe@mail.com',
      ),
    );
  }

  PasswordField buildPasswordField() {
    return PasswordField(
      controller: passwordTextField,
      enabled: isLoading ? false : true,
      hintText: 'enter password',
      validator: (password) {
        if (password.isEmpty) {
          return 'Password is required';
        } else {
          return null;
        }
      },
    );
  }

  Row buildLoginButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RaisedButton(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            onPressed: isLoading
                ? null
                : () {
                    if (isValidateForm()) {
                      doLogin();
                    } else {
                      return;
                    }
                  },
            color: Theme.of(context).primaryColor,
            child: isLoading
                ? SizedBox(
                    height: 24.0,
                    width: 24.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  )
                : Text(
                    'Login',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(color: Colors.white),
                  ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ],
    );
  }

  void doLogin() async {
    var req = LoginRequest(
      email: emailTextField.text,
      password: passwordTextField.text,
    );

    await authBloc.doLogin(req);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => ProfileScreen(
          password: passwordTextField.text,
        ),
      ),
    );
  }

  Center buildForgotPasswordButton(BuildContext context) {
    return Center(
      child: FlatButton(
        onPressed: isLoading ? null : () {},
        child: Text(
          'Forgot Password',
          style: Theme.of(context).textTheme.button.copyWith(
                color: isLoading ? Colors.grey : Theme.of(context).primaryColor,
              ),
        ),
      ),
    );
  }

  bool isValidateForm() {
    return formKey.currentState.validate();
  }

  Widget buildORWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(children: <Widget>[
        buildDivider(true),
        Text(
          'or',
          style: TextStyle(color: Color(0xFF4B4C4B)),
        ),
        buildDivider(false),
      ]),
    );
  }

  Expanded buildDivider(bool isRightPadded) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(
          right: isRightPadded ? 8.0 : 0.0,
          left: isRightPadded ? 0.0 : 8.0,
        ),
        child: Divider(color: Color(0xFF4B4C4B)),
      ),
    );
  }

  Row buildExploreAppButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlineButton(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            onPressed: isLoading
                ? null
                : () {
                    if (isValidateForm()) {
                      return;
                    } else {
                      // doLogin();
                    }
                  },
            color: Theme.of(context).primaryColor,
            child: isLoading
                ? SizedBox(
                    height: 24.0,
                    width: 24.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  )
                : Text(
                    'Explore The App',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(color: Colors.black54),
                  ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ],
    );
  }
}
