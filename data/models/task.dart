class Task {
  final int id;
  final String type;
  final int? idfalse;
  final int? idtrue;
  final String usl;
  final String? image;
  final dynamic ans; // dynamic, так как ответ может быть строкой или числом
  final double? eps;
  final String? formans;
  final List? utv;

  Task({
    required this.id,
    required this.type,
    this.idfalse,
    this.idtrue,
    required this.usl,
    this.image,
    this.ans,
    this.eps,
    this.formans,
    this.utv,
  });

  // Парсинг из JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as int,
      type: json['type'] as String,
      idfalse: json['idfalse'] as int?,
      idtrue: json['idtrue'] as int?,
      usl: json['usl'] as String,
      image: json['image'] as String?,
      ans: json['ans'],
      eps: json['eps']?.toDouble(),
      formans: json['formans'] as String?,
      utv: json['utv'] as List?,
    );
  }

  // Конвертация в JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'idfalse': idfalse,
      'idtrue': idtrue,
      'usl': usl,
      'image': image,
      'ans': ans,
      'eps': eps,
      'formans': formans,
      'utv': utv,
    };
  }

  // Метод валидации
  bool isValidType() {
    return type.isNotEmpty && type != 'unknown';
  }
}