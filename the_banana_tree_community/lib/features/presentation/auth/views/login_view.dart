import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:the_banana_tree_community/features/presentation/auth/views/sign_in_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'The Banana Community',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Lottie.network(
            "https://lottie.host/77a4ce06-672b-4836-aeab-a03944d05ef2/kmXIGRTEaM.json",
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignInView()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  overlayColor: Colors.black,
                  fixedSize: Size(
                    MediaQuery.widthOf(context) * .9,
                    MediaQuery.heightOf(context) * .06,
                  ),
                ),
                child: const Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 39, 45, 39),
                  fixedSize: Size(
                    MediaQuery.widthOf(context) * .9,
                    MediaQuery.heightOf(context) * .06,
                  ),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
