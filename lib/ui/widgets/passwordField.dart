import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.enabled,
    this.controller,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
  });

  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final bool enabled;
  final TextEditingController controller;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.fieldKey,
      controller: widget.controller,
      obscureText: _obscureText,
      cursorColor: Theme.of(context).cursorColor,
      maxLength: 8,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        filled: widget.enabled ? false : true,
        counterText: '',
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.12),
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
        enabled: widget.enabled,
        suffixIcon: GestureDetector(
          dragStartBehavior: DragStartBehavior.down,
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: widget.enabled
              ? Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  semanticLabel:
                      _obscureText ? 'Show Passowrd' : 'Hide Password',
                )
              : SizedBox(),
        ),
      ),
    );
  }
}
