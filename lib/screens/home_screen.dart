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
  // Set<String> _done = Set<String>();

  Widget _buildList() {
    return ListView.builder(
        itemCount: _todoList.length,
        itemBuilder: (context, index) {
          final item = _todoList[index];

          return Dismissible(
            // Each Dismissible must contain a Key. Keys allow Flutter to
            // uniquely identify widgets.
            key: Key(item),
            // Provide a function that tells the app
            // what to do after an item has been swiped away.
            onDismissed: (direction) {
              // Remove the item from the data source.
              setState(() {
                _todoList.removeAt(index);
              });

              // Then show a snackbar.
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text("$item dismissed")));
            },
            // Show a red background as the item is swiped away.
            background: Container(color: Colors.red),
            child: ListTile(title: Text('$item')),
          );
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
