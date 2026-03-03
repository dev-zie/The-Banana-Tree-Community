import 'package:banana_tree_new/features/data/datasources/auth_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  String errorMessage = '';
  final mailController = TextEditingController();
  final paswdController = TextEditingController();
  final userNameController = TextEditingController();

  void popPage() {
    Navigator.pop(context);
  }

  void register() async {
    try {
      await authDataSource.value.createAccount(
        email: mailController.text,
        password: paswdController.text,
        username: userNameController.text,
      );
      popPage();
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? 'There is an error';
      });
    } on FirebaseException catch (e) {
      setState(() {
        errorMessage = e.message ?? 'Firestore error';
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
                const Row(
                  mainAxisAlignment: .center,
                  children: [
                    Icon(Icons.key, size: 50),
                    Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: .bold,
                      ),
                    ),
                  ],
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
                        controller: userNameController,
                        decoration: const InputDecoration(
                          hintText: 'Usernames',
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
                SizedBox(height: 20),
                Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red, fontSize: 18),
                ),
              ],
            ),

            ElevatedButton(
              onPressed: register,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                overlayColor: Colors.black,
                fixedSize: Size(
                  MediaQuery.widthOf(context) * .6,
                  MediaQuery.heightOf(context) * .06,
                ),
              ),
              child: const Text(
                'Register',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
