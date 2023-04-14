import 'package:flutter/material.dart';
import 'package:wordfight/resources/auth_methods.dart';
import 'package:wordfight/screens/signup_screen.dart';
import 'package:wordfight/utils/colors.dart';
import 'package:wordfight/utils/utils.dart';

import '../widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool isLoading1 = false;

  void userSignIn() async {
    setState(() {
      isLoading = true;
    });

    String res = await AuthMethods()
        .userSignIn(emailController.text, passwordController.text);

    setState(() {
      isLoading = false;
    });

    if (res != 'success') {
      if (mounted) {
        showSnackBar(res, context);
      }
    }
  }

  void signInAnonymously() async {
    setState(() {
      isLoading1 = true;
    });
    String res = await AuthMethods().signInAnonymously();

    if (res != 'success') {
      if (mounted) {
        showSnackBar(res, context);
      }
    }

    setState(() {
      isLoading1 = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
        ),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Container(),
            ),
            InkWell(
              onTap: signInAnonymously,
              child: Container(
                width: double.infinity,
                height: 80,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  color: buttonYellow,
                ),
                child: isLoading1
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : const Text('Graj jako gość'),
              ),
            ),
            const SizedBox(
              height: 64,
            ),
            TextFieldInput(
              hintText: 'Podaj email',
              textEditingController: emailController,
              textInputType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              hintText: 'Podaj hasło',
              textEditingController: passwordController,
              textInputType: TextInputType.text,
              isPass: true,
            ),
            const SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: userSignIn,
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  color: buttonYellow,
                ),
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : const Text('Login'),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Flexible(
              flex: 2,
              child: Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text("Don't have the account"),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const SignupScreen()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
