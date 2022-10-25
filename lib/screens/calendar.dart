import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:naoned/config/theme.dart';
import 'package:naoned/models/calendar_event.dart';
import 'package:naoned/models/paginated_model.dart';
import 'package:naoned/services/calendar_event.dart';
import 'package:naoned/utils/date.dart';
import 'package:naoned/utils/loader.dart';
import 'package:naoned/widgets/card.dart';
import 'package:url_launcher/url_launcher.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _requestedDate = getCurrentDate();

  final _eventsPerRequest = 10;

  final PagingController<int, CalendarEvent> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchCalendarEvents(pageKey);
    });

    super.initState();
  }

  Future<void> _fetchCalendarEvents(int pageKey) async {
    try {
      final PaginatedModel<CalendarEvent> newEvents = await fetchCalendarEvents(
          pageKey, _eventsPerRequest, formatDate(_requestedDate, 'yyyy-MM-dd'));
      final bool isLastPage = newEvents.records.length < _eventsPerRequest;

      if (isLastPage) {
        _pagingController.appendLastPage(newEvents.records);
      } else {
        final int nextPageKey = pageKey + newEvents.records.length;
        _pagingController.appendPage(newEvents.records, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  void _openDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        initialDate: _requestedDate,
        firstDate: getFirstDayOfTheYear(),
        lastDate: getLastDayOfTheYear(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                    primary: theme['cyan400']!,
                    onPrimary: theme['white']!,
                    onSurface: theme['cyan500']!)),
            child: child!,
          );
        });

    if (pickedDate != null && pickedDate != _requestedDate) {
      setState(() {
        _requestedDate = pickedDate;
      });

      _pagingController.refresh();
    }
  }

  void _launchUrl(String url) async {
    launchUrl(Uri.parse(url)).then((bool isLaunched) => {}, onError: (e) {
      Fluttertoast.showToast(
          msg: "Impossible d'ouvrir le lien",
          backgroundColor: theme['red600'],
          textColor: theme['white']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: theme['cyan400'],
          title: const Text('Calendrier'),
          actions: [
            IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => _openDatePicker()),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(right: 15),
                child: Text(formatDate(_requestedDate, 'dd/MM/yyyy')))
          ],
        ),
        body: Center(
            child: PagedListView<int, CalendarEvent>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<CalendarEvent>(
                  firstPageProgressIndicatorBuilder: (BuildContext context) =>
                      Center(child: getLoader()),
                  newPageProgressIndicatorBuilder: (BuildContext context) =>
                      Center(
                          heightFactor: 2,
                          child: getLoader(size: LoaderSize.small)),
                  noItemsFoundIndicatorBuilder: (BuildContext context) =>
                      const Center(
                          child: Text("Aucun évènement n'a été trouvé",
                              style: TextStyle(fontSize: 20))),
                  firstPageErrorIndicatorBuilder: (BuildContext context) =>
                      Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Impossible d'afficher les évènements",
                              style: TextStyle(fontSize: 20)),
                          IconButton(
                              icon: const Icon(Icons.refresh),
                              onPressed: () => _pagingController.refresh())
                        ]),
                  ),
                  newPageErrorIndicatorBuilder: (BuildContext context) =>
                      Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Impossible d'afficher les évènements",
                              style: TextStyle(fontSize: 12)),
                          IconButton(
                              icon: const Icon(Icons.refresh),
                              onPressed: () => _pagingController.refresh())
                        ]),
                  ),
                  itemBuilder: (BuildContext context, CalendarEvent item,
                          int index) =>
                      CardWidget(
                          calendarEvent: item,
                          launchUrlCallback: (String url) => _launchUrl(url)),
                ))));
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
