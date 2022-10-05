import 'package:flutter/material.dart';
import 'package:project_two/model/todo.dart';
import '../constants/colors.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;
  const ToDoItem({Key? key, required this.todo, required this.onToDoChanged, required this.onDeleteItem}) : super(key: key);


  @override
  Widget build(BuildContext context){

    return Container(
       //space between tiles
       margin: EdgeInsets.only(bottom: 20),

       child: ListTile(

        // tap kaloth 
        onTap: () {
         onToDoChanged(todo);
        },

      //Tile shape
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
      ),

      contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),

      tileColor: Colors.white,

      //Box
      leading: Icon(
         todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
         color: tdBlue,
      ),
      
      //Text
      title: Text(
        todo.todoText!,
        style: TextStyle(
          fontSize: 16,
          color: tdBlack,
          decoration: todo.isDone? TextDecoration.lineThrough : null,

        ),
      ),
       


      // Start delete icon in red box
        trailing: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5),
          ),

        child: IconButton(
          color: Colors.white,
          iconSize: 18,
          icon: Icon(Icons.delete),
          onPressed: () {
            onDeleteItem(todo.id);
          },
        ),
       ),
      // End delete icon in red box


      ),

      );

  }   
}