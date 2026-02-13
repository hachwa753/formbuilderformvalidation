import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: FormBuilder(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FormBuilderTextField(
                    name: 'email',
                    decoration: InputDecoration(labelText: "email"),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: "Email is mandatory",
                      ),
                      FormBuilderValidators.email(
                        errorText: "Invalid email format",
                      ),
                    ]),
                  ),
                  FormBuilderTextField(
                    name: 'password',
                    decoration: InputDecoration(labelText: "Password"),
                    obscureText: true,

                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: "Password can not be empty",
                      ),
                      FormBuilderValidators.minLength(
                        6,
                        errorText: "Minimum 6 characters required",
                      ),
                      FormBuilderValidators.password(),
                    ]),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final formState = _formKey.currentState;
                      if (formState?.saveAndValidate() ?? false) {
                        final values = formState!.value;
                        print(values);
                      }
                    },
                    child: Text("Login"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
