class Circuit {
  final String name;

  const Circuit({
    required this.name,
  });

  // factory Circuit.fromJson(Map<String, dynamic> json) =>
  //     Circuit(name: json['name']);
  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) ||
  //     other is Circuit &&
  //         runtimeType == other.runtimeType &&
  //         name == other.name;

  // @override
  // int get hashCode => name.hashCode;
}
