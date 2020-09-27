import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';
import 'package:mantras/mantras.dart';

class CongratsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String mantra = Mantras().getMantra();
    RandomColor _randomColor = RandomColor();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[900],
          title: new Text("Good Job!"),
          centerTitle: true,
        ),
        body: Container(
            child: Stack (children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 50.0),
                child: new Image.asset("./images/The U.jpg"),
              ),
              new Padding(padding: EdgeInsets.all(30.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 250.0),
                child: Center(
                  child: new Text(
                  mantra,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,),
                  textAlign: TextAlign.center,
                  ),
                ),
              )),
            ],)
            )
        );
  }
}

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
      appBar: AppBar(
          title: Text("Dopamine Machine"),
          backgroundColor: Colors.purple[900],
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
              ),
              onPressed: (onPress),
            )
          ]),
      body: _buildList(),
    );
  }

  List<String> _todoList = [
    "Morning Routine",
    "Meditate",
    "Talk to Someone",
    "Drink Water",
    "Work Out",
    "Nightly Routine"
  ];
  Set<String> _done = Set<String>();

  Widget _buildList() {
    return ListView.builder(
        itemCount: _todoList.length,
        itemBuilder: (context, index) {
          final item = _todoList[index];
          final alreadyDone = _done.contains(_todoList[index]);

          RandomColor _randomColor = RandomColor();
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
                _done.remove(_todoList[index]);
              });

              // Then show a snackbar.
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text("$item dismissed")));
            },
            // Show a red background as the item is swiped away.
            background: Container(color: _randomColor.randomColor()),
            child: ListTile(
                leading: Icon(alreadyDone
                    ? Icons.check_box
                    : Icons.check_box_outline_blank),
                title: Text('$item'),
                onTap: () {
                  setState(() {
                    if (alreadyDone) {
                      _done.remove(_todoList[index]);
                    } else {
                      _done.add(_todoList[index]);
                    }

                    if (_done.length == 6) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (contex) => CongratsScreen()),
                      );
                    }
                  });
                }),
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
          appBar: new AppBar(
            title: new Text('New Task'),
            backgroundColor: Colors.purple[900],
          ),
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
