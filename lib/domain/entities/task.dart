class Task {
  final int? id;
  final String name;
  final String details;
  final bool isFavourite;
  final DateTime? createdDate;
  final DateTime? updatedDate;

  Task({
    this.id,
    required this.name,
    required this.details,
    required this.isFavourite,
    this.createdDate,
    this.updatedDate,
  });

  Task copyWith({
    int? id,
    String? name,
    String? details,
    bool? isFavourite,
    DateTime? createdDate,
    DateTime? updatedDate,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      details: details ?? this.details,
      isFavourite: isFavourite ?? this.isFavourite,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
    );
  }
}
