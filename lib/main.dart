import 'package:flutter/material.dart';

import 'model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> _myList = List<User>();
  MyApi api = MyApi();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
