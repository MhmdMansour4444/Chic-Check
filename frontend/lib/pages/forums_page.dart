import 'package:flutter/material.dart';
import 'package:frontend/components/my_textfield.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class ForumsPage extends StatefulWidget {
  const ForumsPage({Key? key}) : super(key: key);

  @override
  State<ForumsPage> createState() => _ForumsPageState();
}

class _ForumsPageState extends State<ForumsPage> {
  final postController = TextEditingController();
  File? _image;
  List<Post> posts = [];
  //user
  final currentUser = "";

  void signOut() {}

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  void fetchPosts() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.1.6:8000/api/posts'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> postsData = responseData['data'];
        setState(() {
          posts = postsData.map((json) => Post.fromJson(json)).toList();
        });
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }

  void postMessage() async {
    try {
      final token = await getToken();
      final response = await http.post(
        Uri.parse('http://192.168.1.6:8000/api/posts'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
        body: {
          'content': postController.text,
        },
      );
      if (response.statusCode == 201) {
        fetchPosts();
        // Show alert
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Success"),
              content: Text("Post successful"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
        postController.clear();
      } else {
        throw Exception('Failed to post message');
      }
    } catch (e) {
      print('Error posting message: $e');
    }
  }

  void likePost(Post post) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'The Forum',
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: signOut,
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(post.content),
                          subtitle: Text('Posted by: ${post.user.username}'),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => likePost(post),
                              icon: Icon(Icons.favorite_border),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // post message
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Flexible(
                    child: MyTextField(
                      controller: postController,
                      hintText: 'Write something on the wall...',
                      obscureText: false,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      setState(() {});
                    },
                    icon: Icon(Icons.image),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: postMessage,
                    icon: Icon(Icons.arrow_circle_up),
                  ),
                ],
              ),
            ),
            Text("logged in as: "),
          ],
        ),
      ),
    );
  }
}

class Post {
  final String content;
  final User user;

  Post({required this.content, required this.user});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      content: json['content'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final String username;

  User({required this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(username: json['username']);
  }
}
