class ToDo{
  String? id;
  String? todoText;
  late bool isDone;

  ToDo({
   required this.id,
   required this.todoText,
   this.isDone = false,
});

  static List<ToDo> todoList(){
    return [
      ToDo(id: '01', todoText: 'Add your tasks..', isDone: false),

    ];
  }

}