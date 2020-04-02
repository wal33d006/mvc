import 'package:flutter/material.dart';
import 'package:mvc/user/user_posts_screen.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'model.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> _myList = List<User>();
  MyApi api = MyApi();
  var _darkTheme = true;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    (value)
        ? themeNotifier.setTheme(darkTheme)
        : themeNotifier.setTheme(lightTheme);
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Switch(
            onChanged: (value) {
              setState(() {
                _darkTheme = value;
              });
              onThemeChanged(value, themeNotifier);
            },
            value: _darkTheme,
          ),
        ],
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
                    return ListTile(
                      title: Text(_myList[index].name),
                      subtitle: Text(_myList[index].email),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => UserPostsPage(
                              userId: _myList[index].id.toString(),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }

  void _fetchData() async {
    try {
      setState(() {
        _isLoading = true;
      });
      var list = await api.getUsers();
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
