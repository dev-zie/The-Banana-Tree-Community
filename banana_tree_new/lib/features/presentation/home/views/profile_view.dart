import 'package:banana_tree_new/features/data/datasources/auth_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  void popPage() {
    Navigator.pop(context);
  }

  String username = 'Loading...';

  @override
  void initState() {
    super.initState();
    fetchUsername();
  }

  void fetchUsername() async {
    final name = await authDataSource.value.getUsername();
    if (name != null) {
      setState(() {
        username = name;
      });
    }
  }

  void logout() async {
    try {
      await authDataSource.value.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  final AuthDataSource _authDataSource = AuthDataSource();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile'), centerTitle: false),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.greenAccent, width: 1.5),
              ),
              child: Column(
                children: [
                  Text(
                    username,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _authDataSource.currentUser!.email ?? "nullim",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
            TextButton(
              onPressed: logout,
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.redAccent, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
