import 'package:flutter/material.dart';
import 'package:project_two/constants/colors.dart';
import 'package:project_two/widgets/todo_item.dart';
import 'package:project_two/model/todo.dart';

class Home extends StatefulWidget {
   Home ({Key? key}) : super(key: key);

   @override
   State<Home> createState() => _HomeState();
   
   }
  class _HomeState extends State<Home> {
     final todosList = ToDo.todoList();
     List<ToDo> _foundToDo = [];
     final _todoController = TextEditingController();

  
  @override
  void initState(){
    _foundToDo = todosList;
    super.initState();
  }




  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: tdBGColor,

      appBar: _buildAppBar(), // appbar as function


      body: Stack(
       
          children: [

      Container(

        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),


        child: Column(

          children: [
            
            searchBox(), //serachbox as Widgets
            

            Expanded(
              
              
              child: ListView(
               children: [
                
                // start head text
                 Container(
                  margin: EdgeInsets.only(
                    top: 50,
                    bottom: 20,
                 ),
                child: Text(
                  'All ToDos',
                   style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                   ),
                   ),
                ),
                
                // End head text

                for (ToDo todoo in _foundToDo.reversed)
                ToDoItem(
                  todo: todoo,
                  onToDoChanged: _handleToDoChange,
                  onDeleteItem:  _deleteToDoItem,
                
                ),
               ],


            ),

 
            )
          ],
          ),
      ),

      // Start bottom elements in one Row
      Align(
      alignment: Alignment.bottomCenter,
      child: Row(children: [
        Expanded(
          child: Container(
             margin: EdgeInsets.only(
              bottom: 28,
              right: 20,
              left: 20,
             ),

            
            padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
            ),


          // start of Text box

            decoration: BoxDecoration(
               color: Colors.white,
               boxShadow: const [
                
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.1, 0.3),
                  blurRadius: 10.0,
                  spreadRadius: 0.0,
               ),

          ],

            borderRadius: BorderRadius.circular(10),
            ),
            
            child: TextField(
                  controller: _todoController,
                  decoration: InputDecoration(
                  hintText: 'Add a new todo item',
                  border: InputBorder.none),
               ),
            ),
          // End of text box
          ),
          

          // start of plus button
          Container(
            margin: EdgeInsets.only(bottom: 20,right: 20,),
            child: ElevatedButton(
              child: Text('+', style: TextStyle(fontSize: 40,),),
              onPressed: () { _addToDoItem(_todoController.text);},
              style: ElevatedButton.styleFrom(
                primary: tdBlue,
                minimumSize: Size(60, 60),
                elevation: 10,
              ),
            ),
          ),
          // End of plus button
          ]),
        
         ),
         ],
      ),
    );
    
    }


    void _handleToDoChange(ToDo todo){

      setState((){

        todo.isDone = !todo.isDone;
      });
      }
      
    void _deleteToDoItem(String id){

        setState((){

          todosList.removeWhere((item) => item.id == id);
        });
      }
    
    void _addToDoItem(String toDo){
        
        setState((){
        todosList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(), 
        todoText: toDo));
    });

       _todoController.clear();
    }



   void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if(enteredKeyword.isEmpty){
      results = todosList;
    } else {

       results =todosList

         .where((item) => item.todoText!
           .toLowerCase()
           .contains(enteredKeyword.toLowerCase()))
           .toList();
    }
  
   setState(() {
     _foundToDo = results;
   });

   }







//start widget searchbox

Widget searchBox(){
  return Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                   color: Colors.white, borderRadius: BorderRadius.circular(28)),

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
              );
}

//End widget searchbox



// start AppBar function

AppBar _buildAppBar(){

  return AppBar(
        backgroundColor: tdBGColor,
        elevation: 0,

        title: Row(
          
          //app bar create space between tabs icon and profile icon
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          //left top icon
          children: [
            Icon(Icons.menu,
            color: tdBlack,
            size: 30,),

          //profile icon in container
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Image.asset('assets/images/avatar.png'),
            ),
          )     
            
            ]
            ),
  );
            
}

// End AppBar function

}