import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Image imgUp = Image.asset('images/button2.png');
  Image imgDown = Image.asset('images/button1.png');
  Image img;
  int counter;

  @override
  void initState() {
    super.initState();
    img = imgUp;
    counter = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TO-DO"), actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.black,
          ),
          onPressed: (onPress),
        )
      ]),
      body: _buildList(),
    );
  }

  List<String> _todoList = ["Work Out", "Brush Teeth", "Take out the Trash"];
  Set<String> _done = Set<String>();

  Widget _buildList() {
    return ListView.separated(
        itemCount: _todoList.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, item) {
          return _buildRow(_todoList[item]);
        });
  }

  Widget _buildRow(String todo) {
    final alreadyDone = _done.contains(todo);
    return ListTile(
        leading:
            Icon(alreadyDone ? Icons.check_box : Icons.check_box_outline_blank),
        title: Text(todo, style: TextStyle(fontSize: 20.0)),
        onTap: () {
          setState(() {
            if (alreadyDone) {
              _done.remove(todo);
            } else {
              _done.add(todo);
            }
          });
        });
  }

  void _addTodoItem(String task) {
    // Only add the task if the user actually entered something
    if (task.length > 0) {
      // Putting our code inside "setState" tells the app that our state has changed, and
      // it will automatically re-render the list
      setState(() => _todoList.add(task));
    }
  }

  void onPress() {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        return new Scaffold(
          appBar: new AppBar(title: new Text('New Task')),
          body: new TextField(
              autofocus: true,
              onSubmitted: (task) {
                _addTodoItem(task);
                Navigator.pop(context);
              },
              decoration: new InputDecoration(
                  hintText: 'Enter a new Task',
                  contentPadding: const EdgeInsets.all(16.0))),
        );
      }),
    );
  }
}
