import 'package:banana_tree_new/features/presentation/comment/views/comment_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:banana_tree_new/features/presentation/upload/views/add_post_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), centerTitle: true),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final post = docs[index].data() as Map<String, dynamic>;

              final username =
                  post.containsKey('username') && post['username'] != null
                  ? post['username'] as String
                  : 'Anonymous';

              final createdAt =
                  post.containsKey('createdAt') && post['createdAt'] != null
                  ? (post['createdAt'] as Timestamp).toDate().toString()
                  : '';

              return Card(
                margin: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(title: Text(username), subtitle: Text(createdAt)),
                    if (post.containsKey('imageUrl') &&
                        post['imageUrl'] != null)
                      Image.network(post['imageUrl']),
                    Row(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('posts')
                              .doc(docs[index].id)
                              .collection('comments')
                              .snapshots(),
                          builder: (context, snapshot) {
                            int commentCount = 0;
                            if (snapshot.hasData) {
                              commentCount = snapshot.data!.docs.length;
                            }
                            return Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.comment),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            CommentView(postId: docs[index].id),
                                      ),
                                    );
                                  },
                                ),
                                Text('$commentCount'), // yorum sayısı
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPostView()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
