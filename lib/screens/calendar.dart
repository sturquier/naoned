import 'package:flutter/material.dart';
import 'package:naoned/models/calendar_event.dart';
import 'package:naoned/services/calendar_event.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late Future<List<CalendarEvent>> _events;

  @override
  void initState() {
    super.initState();
    _events = fetchCalendarEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: FutureBuilder<List<CalendarEvent>>(
                future: _events,
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }

                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Text(snapshot.data[index].name);
                      });
                })));
  }
}
