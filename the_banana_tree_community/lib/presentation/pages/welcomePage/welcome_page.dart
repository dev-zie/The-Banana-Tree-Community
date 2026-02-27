import 'package:flutter/material.dart';
import 'package:the_banana_tree_community/presentation/pages/welcomePage/widgets/sign_in_up_button_widget.dart';
import 'package:the_banana_tree_community/presentation/pages/welcomePage/widgets/textfield_widget.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Text(
                textAlign: TextAlign.center,
                'Welcome To Community',
                style: TextStyle(fontSize: 48),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 120.0),
              child: TextfieldWidget(
                hintText: 'Email',
                type: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: TextfieldWidget(
                hintText: 'Password',
                type: TextInputType.text,
              ),
            ),
            SizedBox(height: 20,),
            SignInUpButtonWidget(
              text: 'Sign in',
              color: Color.fromARGB(255, 19, 154, 24),
            ),
            SizedBox(height: 10,),
            SignInUpButtonWidget(
              text: 'Sign Up',
              color: Color.fromARGB(255, 7, 77, 13),
            ),
          ],
        ),
      ),
    );
  }
}
