import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:naoned/config/constants.dart';
import 'package:naoned/models/calendar_event.dart';

Future<List<CalendarEvent>> fetchCalendarEvents() async {
  final response = await http.get(Uri.parse(calendarURL));

  if (response.statusCode == 200) {
    return jsonDecode(response.body)['records']
        .map((data) => CalendarEvent.fromJson(data))
        .toList();
  }

  throw Exception('Failed to load calendar events');
}
