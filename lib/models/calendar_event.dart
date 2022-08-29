class CalendarEvent {
  final String id;
  final String name;
  final String mediaUrl;
  final String calendarLink;
  final String websiteLink;

  const CalendarEvent(
      {required this.id,
      required this.name,
      required this.mediaUrl,
      required this.calendarLink,
      required this.websiteLink});

  factory CalendarEvent.fromJson(Map<String, dynamic> json) {
    return CalendarEvent(
        id: json['recordid'],
        name: json['fields']['nom'],
        mediaUrl: json['fields']['media_url'],
        calendarLink: json['fields']['lien_agenda'],
        websiteLink: json['fields']['url_site'] ?? '');
  }

  static CalendarEvent fromJsonModel(Map<String, dynamic> json) =>
      CalendarEvent.fromJson(json);
}
