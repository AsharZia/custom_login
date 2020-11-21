import 'package:custom_login/services/auth_service.dart';
import 'package:custom_login/ui/widgets/passwordField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailTextField = TextEditingController();
  final passwordTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Initialize login state
    final state = Provider.of<LoginState>(context);
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
                buildEmailTextField(state),
                SizedBox(height: 16.0),
                Text('Password'),
                SizedBox(height: 4.0),
                buildPasswordField(state),
                SizedBox(height: 16.0),
                buildLoginButton(context, state),
                SizedBox(height: 16.0),
                buildForgotPasswordButton(context, state),
                buildORWidget(),
                SizedBox(height: 8.0),
                buildExploreAppButton(context)
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

  TextFormField buildEmailTextField(LoginState state) {
    return TextFormField(
      controller: emailTextField,
      enabled: state.status == LoginStatus.authenticating ? false : true,
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

  PasswordField buildPasswordField(LoginState state) {
    return PasswordField(
      controller: passwordTextField,
      enabled: state.status == LoginStatus.authenticating ? false : true,
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

  Row buildLoginButton(BuildContext context, LoginState state) {
    return Row(
      children: [
        Expanded(
          child: RaisedButton(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            // When user presses button, login state is changing from un-authenticated to authenticating
            onPressed: state.status == LoginStatus.authenticating
                ? null
                : () {
                    if (isValidateForm()) {
                      doLogin(state);
                    }
                  },
            color: Theme.of(context).primaryColor,
            child: state.status == LoginStatus.authenticating
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

  void doLogin(LoginState state) async {
    // Call signIn method with login state
    await state.signIn(emailTextField.text, passwordTextField.text);
  }

  Center buildForgotPasswordButton(BuildContext context, LoginState state) {
    return Center(
      child: FlatButton(
        onPressed: state.status == LoginStatus.authenticating ? null : () {},
        child: Text(
          'Forgot Password',
          style: Theme.of(context).textTheme.button.copyWith(
                color: state.status == LoginStatus.authenticating
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

  Row buildExploreAppButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlineButton(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            onPressed: () {},
            color: Theme.of(context).primaryColor,
            child: Text(
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
