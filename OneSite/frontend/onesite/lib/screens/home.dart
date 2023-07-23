import 'package:onesite/helper.dart';
import 'package:flutter/material.dart';

class InstagramFeedPage extends StatelessWidget {
  final List<Post> posts = [
    Post(
      username: 'john_doe',
      imageUrl: 'https://example.com/image1.jpg',
      caption: 'This is the first post!',
    ),
    Post(
      username: 'jane_smith',
      imageUrl: 'https://example.com/image2.jpg',
      caption: 'Check out this amazing photo!',
    ),
    // Add more posts as needed
  ];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return Home();
        },
      ),
    );
  }
}

class Post {
  final String username;
  final String imageUrl;
  final String caption;

  Post({required this.username, required this.imageUrl, required this.caption});
}

class Home extends StatefulWidget {


  const Home({Key? key,  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 50,
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  // You can use a NetworkImage for the user's profile picture
                  backgroundImage: NetworkImage('https://example.com/avatar.jpg'),
                ),
                title: Text('my name'),
              ),
              Image.network('https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&w=1000&q=80',height: 200,),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('widget.post.caption'),
              ),
              Row(children: [Icon(Icons.abc)],)
            ],
          ),
        ),
         Card(
          elevation: 50,
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  // You can use a NetworkImage for the user's profile picture
                  backgroundImage: NetworkImage('https://example.com/avatar.jpg'),
                ),
                title: Text('my name'),
              ),
              Image.network('https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&w=1000&q=80' ,height: 200,),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('widget.post.caption'),
              ),
              Row(children: [Icon(Icons.abc)],)
            ],
          ),
        ),
      ],
    );
  }
}
