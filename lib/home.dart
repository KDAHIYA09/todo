import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import '../AppColors.dart';
import '../widgets/todo_item.dart';
import 'package:fluttertoast/fluttertoast.dart';

//relative path ..

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final todoList = ToDo.todoList();
  //to add items dynamically
  //1 make controller
  final _todoController = TextEditingController();
  //for searchbar
  List<ToDo> _foundToDo = [];

  @override
  void initState(){
    _foundToDo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backcolor,
        appBar: AppBar(
          backgroundColor: backcolor,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.menu, color: black, size: 30,),
            ],
          ),
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  searchBoax(),
                  Expanded(
                      child: ListView(

                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 50, bottom: 20),
                            child: Text(
                              'All Your Task List',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: black,
                              ),
                            ),
                          ),
                          for(ToDo todoo in _foundToDo.reversed)
                            ToDoItem(
                              toDo: todoo,
                              onToDoChanged: _handleToDoChange,
                              onDeleteItem: _deleteToDoItem ,
                            ),

                          SizedBox(
                            width: double.infinity,
                            height: 80,
                          )

                        ],
                      )
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0.0,0.0),
                              color: Colors.grey,
                              blurRadius: 10.0,
                              spreadRadius: 0.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: _todoController,
                          decoration: InputDecoration(
                            hintText: 'Add new todo task',
                            border: InputBorder.none,
                          ),
                        ),
                      )
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20, right: 20),
                    child: ElevatedButton(
                      child: Text(
                        '+',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: blue,
                        minimumSize: Size(60, 60),
                        elevation: 10,
                      ),
                      onPressed: (){
                        _addToDoItem(_todoController.text);
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        )
    );
  }

  void _deleteToDoItem(String id){
    setState(() {
      todoList.removeWhere((item) => item.id == id);
      //to remove from list
    });
  }

  void _handleToDoChange(ToDo todo){

    setState(() {

      todo.isDone = !todo.isDone;

    });

  }

  void _addToDoItem(String toDo){
    setState(() {
      if(toDo.isEmpty){
        Fluttertoast.showToast(
          msg: "Enter new message first",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }else{
        todoList.add(
            ToDo(
              id: DateTime.now().microsecondsSinceEpoch.toString(),
              todoText: toDo,
            )
        );
      }
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword){
    List<ToDo> results = [];
    if(enteredKeyword.isEmpty){
      results = todoList;
    }else{
      results = todoList.where(
              (item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase())
      ).toList();
    }

    setState(() {
      _foundToDo = results;
    });

  }

  Widget searchBoax() {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
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
              color: black,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 20,
              minWidth: 25,
            ),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(
              color: grey,
            )
        ),
      ),
    );

  }



}