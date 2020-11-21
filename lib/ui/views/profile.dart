import 'package:custom_login/services/auth_service.dart';
import 'package:custom_login/services/profile_service.dart';
import 'package:custom_login/ui/widgets/passwordField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final emailTextField = TextEditingController();
  final passwordTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginState = Provider.of<LoginState>(context, listen: false);
    final profileState = Provider.of<ProfileState>(context, listen: false);
    emailTextField.text = loginState.email;
    passwordTextField.text = loginState.password;
    if (profileState.status == Profile.notFetched)
      profileState.getUser(loginState.id);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: buildFieldsColumn(profileState, loginState),
              ),
              buildChangeButton(context),
            ],
          ),
        ),
      ),
      floatingActionButton: buildFAB(context, loginState),
    );
  }

  Column buildFieldsColumn(ProfileState profileState, LoginState loginState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Avatar',
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(height: 8.0),
        buildProfileRow(profileState, loginState),
        SizedBox(height: 32.0),
        Text('Email'),
        SizedBox(height: 4.0),
        buildEmailTextField(),
        SizedBox(height: 16.0),
        Text('Password'),
        SizedBox(height: 4.0),
        buildDisabledPasswordField(),
      ],
    );
  }

  Row buildProfileRow(ProfileState profileState, LoginState loginState) {
    return Row(
      children: [
        CircleAvatar(
          maxRadius: 40.0,
          backgroundImage: AssetImage('assets/dp.jpg'),
        ),
        SizedBox(width: 16.0),
        profileState.status == Profile.fetching
            ? CircularProgressIndicator()
            : profileState.status == Profile.notFetched
                ? FlatButton.icon(
                    onPressed: () => profileState.getUser(loginState.id),
                    label: Text('Tap to retry'),
                    icon: Icon(Icons.refresh),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(profileState.name),
                      SizedBox(height: 8.0),
                      Text(
                        profileState.designation,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  )
      ],
    );
  }

  TextFormField buildEmailTextField() {
    return TextFormField(
      controller: emailTextField,
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

  PasswordField buildDisabledPasswordField() {
    return PasswordField(
      controller: passwordTextField,
      enabled: false,
    );
  }

  FlatButton buildChangeButton(BuildContext context) {
    return FlatButton(
      onPressed: () {},
      child: Text(
        'Change',
        style: Theme.of(context).textTheme.button.copyWith(
              color: Theme.of(context).primaryColor,
            ),
      ),
    );
  }

  RaisedButton buildFAB(BuildContext context, LoginState loginState) {
    return RaisedButton(
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 36.0,
      ),
      onPressed: () => loginState.signOut(),
      color: Theme.of(context).primaryColor,
      child: Text(
        'Log Out',
        style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }

  bool isValidateForm() {
    return formKey.currentState.validate();
  }
}
