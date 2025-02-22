class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'Morning Excercise', isDone: true ),
      ToDo(id: '02', todoText: 'Buy Groceries', isDone: true ),
      ToDo(id: '03', todoText: 'Check Emails', ),
      ToDo(id: '04', todoText: 'Team Meeting', ),
      ToDo(id: '05', todoText: 'Work on mobile apps for 2 hour', ),
      ToDo(id: '06', todoText: 'Dinner with Jenny', ),
      ToDo(id: '07', todoText: 'Team Meet', ),
      ToDo(id: '08', todoText: 'outing', ),
      ToDo(id: '09', todoText: 'picnic', ),
      ToDo(id: '10', todoText: 'Team Meeting', ),
      ToDo(id: '11', todoText: 'office meet', ),
    ];
  }
}