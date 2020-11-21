import 'package:custom_login/auth_model.dart';
import 'package:custom_login/ui/widgets/passwordField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final emailTextField = TextEditingController();
  final passwordTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<LoginState>(context);
    return Scaffold(
      key: scaffoldKey,
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
                buildEmailTextField(user),
                SizedBox(height: 16.0),
                Text('Password'),
                SizedBox(height: 4.0),
                buildPasswordField(user),
                SizedBox(height: 16.0),
                buildLoginButton(context, user),
                SizedBox(height: 16.0),
                buildForgotPasswordButton(context, user),
                buildORWidget(),
                SizedBox(height: 8.0),
                buildExploreAppButton(context, user)
              ],
            ),
          ),
        ),
      ),
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

  TextFormField buildEmailTextField(LoginState user) {
    return TextFormField(
      controller: emailTextField,
      enabled: user.status == LoginStatus.Authenticating ? false : true,
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

  PasswordField buildPasswordField(LoginState user) {
    return PasswordField(
      controller: passwordTextField,
      enabled: user.status == LoginStatus.Authenticating ? false : true,
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

  Row buildLoginButton(BuildContext context, LoginState user) {
    return Row(
      children: [
        Expanded(
          child: RaisedButton(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            onPressed: user.status == LoginStatus.Authenticating
                ? null
                : () {
                    if (isValidateForm()) {
                      doLogin(user);
                    }
                  },
            color: Theme.of(context).primaryColor,
            child: user.status == LoginStatus.Authenticating
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

  void doLogin(LoginState user) async {
    if (!await user.signIn(emailTextField.text, passwordTextField.text))
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Something is wrong"),
      ));
  }

  Center buildForgotPasswordButton(BuildContext context, LoginState user) {
    return Center(
      child: FlatButton(
        onPressed: user.status == LoginStatus.Authenticating ? null : () {},
        child: Text(
          'Forgot Password',
          style: Theme.of(context).textTheme.button.copyWith(
                color: user.status == LoginStatus.Authenticating
                    ? Colors.grey
                    : Theme.of(context).primaryColor,
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

  Row buildExploreAppButton(BuildContext context, LoginState user) {
    return Row(
      children: [
        Expanded(
          child: OutlineButton(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            onPressed: user.status == LoginStatus.Authenticating
                ? null
                : () {
                    if (isValidateForm()) {
                      return;
                    } else {
                      // doLogin();
                    }
                  },
            color: Theme.of(context).primaryColor,
            child: user.status == LoginStatus.Authenticating
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
