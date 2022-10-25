class CalendarEvent {
  final String id;
  final String name;
  final String description;
  final List<String> types;
  final String place;
  final String mediaUrl;
  final String calendarLink;
  final String websiteLink;
  final bool isFree;

  const CalendarEvent(
      {required this.id,
      required this.name,
      required this.description,
      required this.types,
      required this.place,
      required this.mediaUrl,
      required this.calendarLink,
      required this.websiteLink,
      required this.isFree});

  factory CalendarEvent.fromJson(Map<String, dynamic> json) {
    return CalendarEvent(
        id: json['recordid'],
        name: json['fields']['nom'],
        description: json['fields']['description'].split('.').join('.\r\n'),
        types: json['fields']['type']
            .split(',')
            .where((String type) => type.isNotEmpty)
            .toList(),
        place: json['fields']['lieu'] ?? '',
        mediaUrl: json['fields']['media_url'] ?? '',
        calendarLink: json['fields']['lien_agenda'],
        websiteLink: json['fields']['url_site'] ?? '',
        isFree: json['fields']['gratuit'] == 'oui' ? true : false);
  }

  static CalendarEvent fromJsonModel(Map<String, dynamic> json) =>
      CalendarEvent.fromJson(json);
}
