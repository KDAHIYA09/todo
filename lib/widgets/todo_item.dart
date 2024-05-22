import 'package:flutter/material.dart';
import '../AppColors.dart';
import '../models/todo.dart';

// relative path ..

class ToDoItem extends StatelessWidget {

  final ToDo toDo;
  final onToDoChanged;
  final onDeleteItem;

  const ToDoItem(
      {super.key,
       required this.toDo,
       required this.onToDoChanged,
        required this.onDeleteItem,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          print('object');
          onToDoChanged(toDo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          toDo.isDone? Icons.check_box : Icons.check_box_outline_blank,
          color: blue,
        ),
        title: Text(
          toDo.todoText!,
          style: TextStyle(
            fontSize: 16,
            color: black,
            decoration: toDo.isDone? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          //for an icon at end
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 1, horizontal: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: red,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
              onPressed: (){
                print('object...... .. .. ..');
                onDeleteItem(toDo.id);
              },
              color: Colors.white,
              icon: Icon(Icons.delete),
            ),
        ),
      )
    );
  }
}
