class Experience {
  const Experience({
    required this.role,
    required this.company,
    required this.type,
    required this.place,
    required this.period,
    required this.bullets,
  });

  final String role;
  final String company;
  final String type;
  final String place;
  final String period;
  final List<String> bullets;
}
