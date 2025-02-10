
class Tasks {
    final List<Task> tasks;

    Tasks({
        required this.tasks,
    });

    factory Tasks.fromJson(Map<String, dynamic> json) => Tasks(
        tasks: List<Task>.from(json["tasks"].map((x) => Task.fromJson(x))),
    );

  get title => null;

    Map<String, dynamic> toJson() => {
        "tasks": List<dynamic>.from(tasks.map((x) => x.toJson())),
    };
}

class Task {
    final int id;
    final String title;
    final String description;
    final DateTime dueDate;
    final int status;
    final int personId;
    final DateTime createdAt;
    final DateTime updatedAt;

    Task({
        required this.id,
        required this.title,
        required this.description,
        required this.dueDate,
        required this.status,
        required this.personId,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        dueDate: DateTime.parse(json["due_date"]),
        status: json["status"],
        personId: json["person_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "due_date": "${dueDate.year.toString().padLeft(4, '0')}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}",
        "status": status,
        "person_id": personId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
