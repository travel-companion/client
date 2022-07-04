class Circuit {
  final String depart;
  final String dest;
  final String ref;

  Circuit({
    required this.depart,
    required this.dest,
    required this.ref,
  });

  Map<String, dynamic> toJson() => {'depart': depart, 'dest': dest, 'ref': ref};

  static Circuit fromJson(Map<String, dynamic> json) =>
      Circuit(depart: json['depart'], dest: json['dest'], ref: json['ref']);
}
