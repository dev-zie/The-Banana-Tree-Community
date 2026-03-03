import 'package:banana_tree_new/features/data/datasources/auth_data_source.dart';
import 'package:banana_tree_new/features/presentation/auth/views/reset_password_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final mailController = TextEditingController();
  final paswdController = TextEditingController();
  String errorMessage = '';
  void popPage() {
    Navigator.pop(context);
  }

  void signIn() async {
    try {
      await authDataSource.value.signIn(
        email: mailController.text,
        password: paswdController.text,
      );
      popPage();
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? 'This is not working';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Lottie.network(
                  "https://lottie.host/77a4ce06-672b-4836-aeab-a03944d05ef2/kmXIGRTEaM.json",
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 5,
                      ),
                      child: TextField(
                        style: const TextStyle(fontSize: 24),
                        controller: mailController,
                        decoration: const InputDecoration(
                          hintText: 'Mail',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 5,
                      ),
                      child: TextField(
                        style: const TextStyle(fontSize: 24),
                        controller: paswdController,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          errorMessage,
                          style: const TextStyle(color: Colors.red),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ResetPasswordView(),
                            ),
                          );
                        },
                        child: const Text('Reset Password?'),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            ElevatedButton(
              onPressed: signIn,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                overlayColor: Colors.black,
                fixedSize: Size(
                  MediaQuery.widthOf(context) * .6,
                  MediaQuery.heightOf(context) * .06,
                ),
              ),
              child: const Text(
                'Sign In',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
