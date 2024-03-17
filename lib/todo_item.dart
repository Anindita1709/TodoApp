class Todo {
  String? id;
  String? todoText;
  bool isDone;

  Todo({
    required this.id,
    required this.todoText,
    this.isDone=false,
  });

  static List<Todo> todoList(){
    return [
      Todo(id:'01',todoText:"Morning Exercise",isDone:true),
      Todo(id:'02',todoText:"Eating breakfast",isDone:true),
      Todo(id:'03',todoText:"Checking Mails"),
      Todo(id:'04',todoText:"Doing DSA"),
      Todo(id:'05',todoText:"Drinking Water"),
      Todo(id:'06',todoText:"Cleaning"),
      Todo(id:'07',todoText:"Meeting"),
      Todo(id:'08',todoText:"Working 2 hours on mobile app"),
      Todo(id:'09',todoText:"Dinner with Aman"),
    ];
  }


}