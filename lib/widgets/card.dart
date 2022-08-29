import 'package:flutter/material.dart';
import 'package:naoned/models/calendar_event.dart';

class CardWidget extends StatelessWidget {
  const CardWidget(
      {Key? key, required this.calendarEvent, required this.launchUrlCallback})
      : super(key: key);

  final CalendarEvent calendarEvent;
  final void Function(String url) launchUrlCallback;

  void _onButtonPressed(String url) {
    launchUrlCallback(url);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        Image.network(calendarEvent.mediaUrl),
        Stack(
          children: [
            Text(
              calendarEvent.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            ButtonBar(
              children: [
                TextButton(
                    onPressed: () =>
                        _onButtonPressed(calendarEvent.calendarLink),
                    child: const Text('Calendar')),
                if (calendarEvent.websiteLink != '')
                  TextButton(
                      onPressed: () =>
                          _onButtonPressed(calendarEvent.websiteLink),
                      child: const Text('Website'))
              ],
            )
          ],
        )
      ]),
    );
  }
}
