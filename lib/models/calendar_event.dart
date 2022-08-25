class CalendarEvent {
  final String id;
  final String name;
  final String date;

  const CalendarEvent(
      {required this.id, required this.name, required this.date});

  factory CalendarEvent.fromJson(Map<String, dynamic> json) {
    return CalendarEvent(
      id: json['recordid'],
      name: json['fields']['nom'],
      date: json['fields']['date'],
    );
  }
}
