import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/todo.dart';
import 'package:my_app/todo_item.dart';

class Home extends StatefulWidget {
  Home({Key?key}):super(key:key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = Todo.todoList();
  final _todoController = TextEditingController();
  List<Todo> _foundTodo = [];

  @override
  void initState(){
    _foundTodo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children:[
            Icon(Icons.menu,color:Colors.black,size:30,),
            Container(
                height:40,
                width:40,
                child:ClipRRect(
                    child:Image.asset('assets/images/boy.jpg'),
                  borderRadius:BorderRadius.circular(20),
                ))
          ])
      ),
      body:Stack(
        children: [Container(
          padding:EdgeInsets.symmetric(horizontal:20,vertical:15),
          child:Column(
            children:[
              Container(
                padding:EdgeInsets.symmetric(horizontal:15),
                decoration:BoxDecoration(
                  color:Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child:TextField(
                  onChanged: (value)=>_runFilter(value),
                  decoration:InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    prefixIcon: Icon(
                      Icons.search,
                      color:Colors.black,
                      size:20,
                    ),
                    prefixIconConstraints: BoxConstraints(
                      maxHeight: 20,
                      minWidth: 20,
                    ),
                      border:InputBorder.none,
                      hintText:'Search',
                      hintStyle: TextStyle(
                        color:Colors.grey,
                      )
                  ),
                )
              ),
              Expanded(
                child: ListView(
                  children:[
                    Container(
                      margin:EdgeInsets.only(top:50,bottom:20),
                      child: Text(
                        'Todo List',
                        style:TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        )
                      )
                    ),
                    for(Todo todo in _foundTodo.reversed)
                    TodoItem(todo:todo,onToDoChanged: _handleToDoChange,onDeleteItem: _deleteToDoItem,),
                  ],
                ),
              ),
            ]
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
            child: Row(
              children:[
                Expanded(child: Container(
                  margin:EdgeInsets.only(bottom:20,right:20,left:20),
                  padding: EdgeInsets.symmetric(horizontal:20,vertical:5 ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow:const [BoxShadow(
                      color:Colors.grey,
                      offset:Offset(0.0,0.0),
                      blurRadius: 10.0,
                      spreadRadius: 0.0,
                    )],
                      borderRadius:BorderRadius.circular(10),
                  ),
                  child:TextField(
                      controller: _todoController,
                    decoration:InputDecoration(
                      hintText: "Add new item",
                      border:InputBorder.none,
                    )
                  )
                )),
                Container(
                  margin:EdgeInsets.only(bottom:20,right:20),
                  child: ElevatedButton(
                    child: Text(
                        '+',
                      style:TextStyle(
                        fontSize: 40,),),
                    onPressed:(){
                      _addToDoItem(_todoController.text);
                    },
                    style:ElevatedButton.styleFrom(
                     minimumSize:Size(60,60),
                        elevation:10,
                    )
                  ),
                ),
              ]
            ),
          )
        ],
      ),
    );
  }
  void _handleToDoChange (Todo todo){
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id){
    setState(() {
      todosList.removeWhere((element) => element.id==id);
    });
  }

  void _addToDoItem(String todo){
    setState(() {
      todosList.add(Todo(id:DateTime.now().millisecondsSinceEpoch.toString(),todoText: todo));

    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword){
    List<Todo> results=[];
    if(enteredKeyword.isEmpty){
      results =todosList;
    }else{
      results= todosList
          .where((item)=>item.todoText!
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundTodo = results;
    });
  }
}


