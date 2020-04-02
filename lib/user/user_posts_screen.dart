import 'package:flutter/material.dart';

import 'model.dart';

class UserPostsPage extends StatefulWidget {
  final String userId;
  UserPostsPage({this.userId});
  @override
  _UserPostsPageState createState() => _UserPostsPageState();
}

class _UserPostsPageState extends State<UserPostsPage> {
  List<UserPost> _myList = List<UserPost>();
  MyApi api = MyApi();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : _myList == null
          ? Center(
        child: Text(
          'Unable to fetch users',
          style: Theme.of(context)
              .textTheme
              .title
              .copyWith(color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: _myList.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4.0,
            child: ListTile(
              title: Text(_myList[index].title),
              subtitle: Text(_myList[index].body),
            ),
          );
        },
      ),
    );
  }

  void _fetchPosts() async {
    try {
      setState(() {
        _isLoading = true;
      });
      var list = await api.getUserPosts(widget.userId);
      setState(() {
        _myList = list;
      });
    } catch (ex) {
      setState(() {
        _myList = null;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}