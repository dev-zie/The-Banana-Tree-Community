import 'package:banana_tree_new/features/presentation/auth/views/sign_in_view.dart';
import 'package:banana_tree_new/features/presentation/auth/views/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpView()),
                  );
                },
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
