import 'dart:io';
import 'dart:typed_data';
import 'package:banana_tree_new/features/data/datasources/auth_data_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class AddPostView extends StatefulWidget {
  const AddPostView({super.key});

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  final List<File> _files = [];
  final List<Widget> _mediaWidgets = [];
  File? _selectedFile;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _fetchMedia();
  }

  Future<void> _fetchMedia() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (!ps.isAuth) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Access to gallery was denied.')),
        );
      }
      return;
    }

    final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
    );

    if (albums.isEmpty) return;

    final List<AssetEntity> media = await albums[0].getAssetListPaged(
      page: currentPage,
      size: 60,
    );

    List<Widget> tempWidgets = [];
    for (var asset in media) {
      final file = await asset.file;
      if (file != null) _files.add(file);

      tempWidgets.add(
        FutureBuilder<Uint8List?>(
          future: asset.thumbnailDataWithSize(const ThumbnailSize(200, 200)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data != null) {
              return Image.memory(snapshot.data!, fit: BoxFit.cover);
            }
            return Container(color: Colors.grey[300]);
          },
        ),
      );
    }

    setState(() {
      _mediaWidgets.addAll(tempWidgets);
      if (_selectedFile == null && _files.isNotEmpty) _selectedFile = _files[0];
      currentPage++;
    });
  }

  Future<void> _uploadSelectedPhoto() async {
    if (_selectedFile == null) return;

    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final storageRef = FirebaseStorage.instance.ref().child(
        'posts/$fileName.jpg',
      );
      final snapshot = await storageRef.putFile(_selectedFile!);
      final downloadUrl = await snapshot.ref.getDownloadURL();

      final user = FirebaseAuth.instance.currentUser;
      // Eğer auth yoksa anonim UID veya sabit kullanıcı
      final userId = user?.uid ?? 'anonymous';
      final username = await authDataSource.value.getUsername() ?? 'Anonymous';

      await FirebaseFirestore.instance.collection('posts').add({
        'imageUrl': downloadUrl,
        'userId': userId,
        'username': username,
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Photo uploaded!')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Upload failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Post'),
        actions: [
          TextButton(
            onPressed: _uploadSelectedPhoto,
            child: const Text('Share', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Column(
        children: [
          if (_selectedFile != null)
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.file(_selectedFile!, fit: BoxFit.cover),
            ),
          const SizedBox(height: 10),
          Expanded(
            child: _mediaWidgets.isEmpty
                ? const Center(
                    child: Text('Gallery is empty or permission denied.'),
                  )
                : GridView.builder(
                    itemCount: _mediaWidgets.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                        ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedFile = _files[index];
                          });
                        },
                        child: _mediaWidgets[index],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
