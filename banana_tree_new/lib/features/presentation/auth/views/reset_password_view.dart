import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final emainController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Lottie.network(
                  "https://lottie.host/ff908913-8f71-4454-a288-994d8aa979f7/JdgFU1zGW0.json",
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
                        controller: emainController,
                        decoration: const InputDecoration(
                          hintText: 'Mail',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                overlayColor: Colors.black,
                fixedSize: Size(
                  MediaQuery.widthOf(context) * .6,
                  MediaQuery.heightOf(context) * .06,
                ),
              ),
              child: const Text(
                'Send Mail',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
