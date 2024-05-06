import 'package:flutter/material.dart';
import 'package:frontend/components/my_textfield.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

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

  void fetchPosts() async {
    // Mock post for testing
    final mockPost =
        Post(content: 'This is a mock post', user: User(username: 'MockUser'));

    // Simulating fetching posts from the server
    setState(() {
      posts.add(mockPost);
    });

    // Uncomment below lines when integrating with real API
    // final response = await http.get(Uri.parse('YOUR_API_ENDPOINT_HERE'));
    // if (response.statusCode == 200) {
    //   final List<dynamic> responseData = json.decode(response.body);
    //   setState(() {
    //     posts = responseData.map((json) => Post.fromJson(json)).toList();
    //   });
    // } else {
    //   throw Exception('Failed to load posts');
    // }
  }

  void postMessage() async {
    final uri = Uri.parse('YOUR_API_ENDPOINT_HERE');
    final request = http.MultipartRequest('POST', uri);
    request.fields['forum_id'] = 'YOUR_FORUM_ID_HERE';
    request.fields['content'] = postController.text;
    if (_image != null) {
      request.files.add(
        await http.MultipartFile.fromPath('image', _image!.path),
      );
    }
    final response = await request.send();
    if (response.statusCode == 201) {
      fetchPosts();
    } else {
      throw Exception('Failed to post message');
    }
  }

  void likePost(Post post) {
    // Implement like functionality here
  }

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
                  SizedBox(width: 10), // Adjust spacing between icons
                  IconButton(
                    onPressed: postMessage,
                    icon: Icon(Icons.arrow_circle_up),
                  ),
                ],
              ),
            ),
            //logged  in as
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
