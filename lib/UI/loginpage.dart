import 'package:fk_demo/Auth/authentication.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 7,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/login_bg.jpg'),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: screenheight,
                maxWidth: screenwidth,
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: screenwidth,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      padding: const EdgeInsets.fromLTRB(10, 25, 10, 10),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            width: screenwidth,
                            child: const Text(
                              'Log in',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 27.5,
                              ),
                            ),
                          ),
                          const EmailForm(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EmailForm extends StatefulWidget {
  const EmailForm({super.key});

  @override
  State<EmailForm> createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    var emailTextController = TextEditingController();
    var passTextController = TextEditingController();

    return Container(
      height: screenheight * 0.4,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFormField(
              controller: emailTextController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'someone@email.com',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 5,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email Field Cannot be Empty';
                } else if (RegExp(
                      r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$',
                    ).hasMatch(value) !=
                    true) {
                  return 'Please enter a valid email';
                }
              },
            ),
            //TODO: Validation for password (RegEx)
            TextFormField(
              controller: passTextController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '*******',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 5,
                ),
              ),
              obscureText: true,
            ),
            SizedBox(
              width: screenwidth - 20,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context
                        .read<AuthServices>()
                        .emailSignIn(
                          email: emailTextController.text,
                          password: passTextController.text,
                        )
                        .then((value) => Navigator.pop(context));
                  }
                },
                child: const Text("Submit"),
              ),
            ),
            SizedBox(
              width: screenwidth - 20,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 5,
                    ),
                    Text('Sign Up'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
