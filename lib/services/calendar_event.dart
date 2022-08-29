import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:naoned/config/endpoints.dart';
import 'package:naoned/models/calendar_event.dart';
import 'package:naoned/utils/paginated_model.dart';

Future<PaginatedModel<CalendarEvent>> fetchCalendarEvents(
    int start, int rows, String date) async {
  final http.Response response =
      await http.get(Uri.parse('$calendarURL&start=$start&rows=$rows&q=$date'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> decodedResponse = jsonDecode(response.body);

    return PaginatedModel<CalendarEvent>.fromJson(
        decodedResponse, CalendarEvent.fromJsonModel);
  }

  throw Exception('Failed to load calendar events');
}
