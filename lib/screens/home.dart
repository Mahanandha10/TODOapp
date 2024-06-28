import 'package:flutter/material.dart';
import '../model/todo.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();
  int _selectedIndex = 0;

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Close the drawer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      drawer: _buildDrawer(),
      body: _selectedIndex == 0 ? _buildHomeBody() : _buildSettingsBody(),
      floatingActionButton: _selectedIndex == 0 ? _buildFloatingActionButton() : null,
    );
  }

  Widget _buildHomeBody() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemCount: _foundToDo.length,
        itemBuilder: (context, index) {
          ToDo todo = _foundToDo[index];
          return ToDoItem(
            todo: todo,
            onToDoChanged: _handleToDoChange,
            onDeleteItem: _deleteToDoItem,
          );
        },
      ),
    );
  }

  Widget _buildSettingsBody() {
    return Center(
      child: Text('Settings'),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "TODO",
            style: TextStyle(
              color: tdBlack,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    onChanged: (value) => _runFilter(value),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      prefixIcon: Icon(
                        Icons.search,
                        color: tdBlack,
                        size: 20,
                      ),
                      prefixIconConstraints: BoxConstraints(
                        maxHeight: 20,
                        minWidth: 25,
                      ),
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: TextStyle(color: tdGrey),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              height: 40,
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/avatar.jpeg'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: tdBlue,
            ),
            child: Text(
              'TODO List',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              _onItemTapped(0);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              _onItemTapped(1);
            },
          ),
          
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        _showAddToDoDialog(context);
      },
      backgroundColor: tdBlue,
      tooltip: 'Add Item',
      child: Icon(Icons.add),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
      _foundToDo.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    if (toDo.isNotEmpty) {
      setState(() {
        final newTodo = ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDo,
        );
        todosList.add(newTodo);
        _foundToDo = todosList; // Ensure _foundToDo reflects the updated todosList
      });
      _todoController.clear();
    }
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  void _showAddToDoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add ToDo'),
          content: TextField(
            controller: _todoController,
            decoration: InputDecoration(
              hintText: 'Enter TODO',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                _addToDoItem(_todoController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
