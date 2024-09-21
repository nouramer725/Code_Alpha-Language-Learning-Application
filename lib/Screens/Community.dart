import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ForumScreen extends StatefulWidget {
  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  final List<Post> _posts = [];

  // Default posts to display
  List<Post> defaultPosts = [
    Post(
        title: 'Understanding Flutter Basics',
        content: 'In this post, we will explore the fundamental concepts of Flutter, including widgets, state management, and layouts. Flutter allows developers to create beautiful UIs quickly.',
        likes: 5,
        comments: ['Great post!', 'Very informative.']
    ),
    Post(
        title: 'Tips for Effective Dart Programming',
        content: 'Dart is the programming language behind Flutter. Here are some tips to improve your Dart skills: use strong typing, leverage async programming, and familiarize yourself with the collection types.',
        likes: 3,
        comments: ['Interesting!', 'Thanks for sharing.']
    ),
    Post(
        title: 'State Management in Flutter',
        content: 'Managing state in Flutter can be challenging. In this article, we will discuss different state management solutions like Provider, Riverpod, and Bloc to help you choose the right one for your app.',
        likes: 8,
        comments: ['I agree!', 'Well said.']
    ),
    Post(
        title: 'Building Responsive Layouts',
        content: 'Creating responsive layouts is crucial for modern apps. Learn how to use MediaQuery and LayoutBuilder to design UIs that adapt to different screen sizes and orientations.',
        likes: 2,
        comments: ['Nice!', 'Good read.']
    ),
    Post(
        title: 'Integrating APIs in Flutter',
        content: 'In this post, we’ll cover how to fetch data from APIs in Flutter using the http package. We will build a simple app that displays data from a public API.',
        likes: 1,
        comments: ['Helpful!']
    ),
    Post(
        title: 'Debugging Flutter Applications',
        content: 'Debugging is an essential part of development. Here are some techniques and tools to help you debug your Flutter applications effectively, including using DevTools and logging.',
        likes: 4,
        comments: ['Very useful.', 'Thanks!']
    ),
    Post(
        title: 'Animations in Flutter',
        content: 'Animations can enhance the user experience. Learn how to create stunning animations in Flutter using the AnimationController and Tween classes.',
        likes: 7,
        comments: ['Loved it!', 'Informative.']
    ),
    Post(
        title: 'Best Practices for Flutter Development',
        content: 'Follow these best practices to improve your Flutter development process: keep your code clean, use proper state management, and write unit tests to ensure reliability.',
        likes: 6,
        comments: ['Great insights!']
    ),
    Post(
        title: 'Understanding Flutter Widgets',
        content: 'Widgets are the building blocks of Flutter applications. This post explains the difference between Stateless and Stateful widgets and how to use them effectively.',
        likes: 0,
        comments: ['Looking forward to more!']
    ),
    Post(
        title: 'Deploying Flutter Apps',
        content: 'Learn how to deploy your Flutter applications to both iOS and Android platforms. We’ll cover the necessary steps and best practices for a smooth deployment.',
        likes: 10,
        comments: ['Excellent post!', 'Very helpful.']
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? postsJson = prefs.getString('posts');

    if (postsJson != null) {
      List<dynamic> jsonList = json.decode(postsJson);
      List<Post> loadedPosts = jsonList.map((json) => Post.fromJson(json)).toList();
      setState(() {
        _posts.addAll(loadedPosts);
      });
    } else {
      setState(() {
        _posts.addAll(defaultPosts); // Load default posts if no saved posts
      });
    }
  }

  Future<void> _savePosts() async {
    final prefs = await SharedPreferences.getInstance();
    final String postsJson = json.encode(_posts.map((post) => post.toJson()).toList());
    await prefs.setString('posts', postsJson);
  }

  void _addPost(String title, String content) {
    final newPost = Post(title: title, content: content);
    setState(() {
      _posts.add(newPost);
    });
    _savePosts();
  }

  void _likePost(int index) {
    setState(() {
      if (!_posts[index].hasLiked) {
        _posts[index].likes++;
        _posts[index].hasLiked = true;
        if (_posts[index].hasDisliked) {
          _posts[index].dislikes--;
          _posts[index].hasDisliked = false;
        }
      }
    });
    _savePosts();
  }

  void _dislikePost(int index) {
    setState(() {
      if (!_posts[index].hasDisliked) {
        _posts[index].dislikes++;
        _posts[index].hasDisliked = true;
        if (_posts[index].hasLiked) {
          _posts[index].likes--;
          _posts[index].hasLiked = false;
        }
      }
    });
    _savePosts();
  }

  void _addComment(int index, String comment) {
    setState(() {
      _posts[index].comments.add(comment);
    });
    _savePosts();
  }

  void _deletePost(int index) {
    setState(() {
      _posts.removeAt(index);
    });
    _savePosts();
  }

  void _openAddPostDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        String title = '';
        String content = '';
        return AlertDialog(
          title: const Text('Add New Post'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                onChanged: (value) {
                  title = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Content'),
                onChanged: (value) {
                  content = value;
                },
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (title.isNotEmpty && content.isNotEmpty) {
                  _addPost(title, content);
                  Navigator.of(ctx).pop();
                }
              },
              child: const Text('Add'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[300],
              ),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Delete Post'),
          content: const Text('Are you sure you want to delete this post?'),
          actions: [
            TextButton(
              onPressed: () {
                _deletePost(index);
                Navigator.of(ctx).pop();
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Community Forum')),
        actions: [
         IconButton(
           icon: CircleAvatar(child: const Icon(Icons.add),backgroundColor: Colors.red[200],
           ),
              onPressed: _openAddPostDialog,
            ),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: _posts.length,
            itemBuilder: (ctx, index) {
              return GestureDetector(
                onLongPress: () => _showDeleteConfirmationDialog(index),
                child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(_posts[index].title),
                          subtitle: Text(_posts[index].content),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.thumb_up),
                                  color: _posts[index].hasLiked ? Colors.blue : null,
                                  onPressed: () => _likePost(index),
                                ),
                                Text('${_posts[index].likes}'),
                                const SizedBox(width: 10),
                                IconButton(
                                  icon: const Icon(Icons.thumb_down),
                                  color: _posts[index].hasDisliked ? Colors.red : null,
                                  onPressed: () => _dislikePost(index),
                                ),
                                Text('${_posts[index].dislikes}'),
                              ],
                            ),
                            IconButton(
                              icon: const Icon(Icons.comment),
                              onPressed: () {
                                String comment = '';
                                showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return AlertDialog(
                                      title: const Text('Add Comment'),
                                      content: TextField(
                                        onChanged: (value) {
                                          comment = value;
                                        },
                                        decoration: const InputDecoration(labelText: 'Comment'),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            if (comment.isNotEmpty) {
                                              _addComment(index, comment);
                                              Navigator.of(ctx).pop();
                                            }
                                          },
                                          child: const Text('Add'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        const Divider(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _posts[index].comments
                              .map((comment) => Text(comment))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class Post {
  String title;
  String content;
  int likes;
  int dislikes;
  bool hasLiked = false;
  bool hasDisliked = false;
  List<String> comments;

  Post({
    required this.title,
    required this.content,
    this.likes = 0,
    this.dislikes = 0,
    List<String>? comments,
  }) : comments = comments ?? [];

  Map<String, dynamic> toJson() => {
    'title': title,
    'content': content,
    'likes': likes,
    'dislikes': dislikes,
    'hasLiked': hasLiked,
    'hasDisliked': hasDisliked,
    'comments': comments,
  };

  factory Post.fromJson(Map<String, dynamic> json) {
    final post = Post(
      title: json['title'],
      content: json['content'],
      likes: json['likes'],
      dislikes: json['dislikes'],
      comments: List<String>.from(json['comments']),
    );
    post.hasLiked = json['hasLiked'];
    post.hasDisliked = json['hasDisliked'];
    return post;
  }
}
