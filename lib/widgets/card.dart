import 'package:flutter/material.dart';
import 'package:naoned/config/theme.dart';
import 'package:naoned/models/calendar_event.dart';

class CardWidget extends StatefulWidget {
  const CardWidget(
      {Key? key, required this.calendarEvent, required this.launchUrlCallback})
      : super(key: key);

  final CalendarEvent calendarEvent;
  final void Function(String url) launchUrlCallback;

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  bool _isDescriptionVisible = false;

  List<String> _getTags() {
    List<String> tags = [];

    tags.addAll(widget.calendarEvent.types);

    if (widget.calendarEvent.isFree) tags.add('Gratuit');

    return [
      ...{...tags}
    ];
  }

  void _toggleDescription() {
    setState(() {
      _isDescriptionVisible = !_isDescriptionVisible;
    });
  }

  void _launchUrl(String url) {
    widget.launchUrlCallback(url);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(children: [
        ListTile(
          contentPadding: const EdgeInsets.all(10),
          leading: SizedBox(
              height: 60,
              width: 60,
              child: Image.network(widget.calendarEvent.mediaUrl)),
          title: Text(widget.calendarEvent.name,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        const Divider(),
        if (widget.calendarEvent.place != '')
          Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(widget.calendarEvent.place,
                  style: const TextStyle(fontSize: 18))),
        Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 15),
            child: Wrap(
                spacing: 8,
                children: _getTags()
                    .map((String tag) => Chip(label: Text(tag)))
                    .toList())),
        if (widget.calendarEvent.description != '')
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 15),
              const Text("Plus d'informations", style: TextStyle(fontSize: 16)),
              IconButton(
                  icon: _isDescriptionVisible
                      ? const Icon(Icons.arrow_upward)
                      : const Icon(Icons.arrow_downward),
                  onPressed: () => _toggleDescription())
            ],
          ),
        if (_isDescriptionVisible)
          Padding(
              padding: const EdgeInsets.all(15),
              child: Text(widget.calendarEvent.description)),
        ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          buttonPadding: const EdgeInsets.symmetric(horizontal: 15),
          children: [
            ElevatedButton(
              onPressed: () => _launchUrl(widget.calendarEvent.calendarLink),
              style: ElevatedButton.styleFrom(
                  onPrimary: theme['white'], primary: theme['cyan900']),
              child: const Text('Calendrier'),
            ),
            if (widget.calendarEvent.websiteLink != '')
              ElevatedButton(
                  onPressed: () => _launchUrl(widget.calendarEvent.websiteLink),
                  style: ElevatedButton.styleFrom(
                      onPrimary: theme['white'], primary: theme['cyan900']),
                  child: const Text('Site web'))
          ],
        )
      ]),
    );
  }
}
