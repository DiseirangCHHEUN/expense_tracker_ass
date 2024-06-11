class Category {
  final int? id;
  final String? enName;
  final String? khName;
  final String? cateType;
  final String? iconCode;
  final String? color;
  final int? isDefault;

  Category({
    this.id,
    required this.enName,
    required this.khName,
    required this.cateType,
    required this.iconCode,
    required this.color,
    required this.isDefault,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'enName': enName,
      'khName': khName,
      'cateType': cateType,
      'iconCode': iconCode,
      'color': color,
      'isDefault': isDefault
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      enName: map['enName'],
      khName: map['khName'],
      cateType: map['cateType'],
      iconCode: map['iconCode'],
      color: map['color'],
      isDefault: map['isDefault'],
    );
  }
}
