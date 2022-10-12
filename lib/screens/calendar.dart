import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
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
          pageKey, _eventsPerRequest, getCurrentDate());
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

  void _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, CalendarEvent>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<CalendarEvent>(
        firstPageProgressIndicatorBuilder: (context) =>
            Center(child: getLoader()),
        newPageProgressIndicatorBuilder: (context) =>
            Center(heightFactor: 2, child: getLoader(size: LoaderSize.small)),
        itemBuilder: (context, item, index) => CardWidget(
            calendarEvent: item,
            launchUrlCallback: (String url) => _launchUrl(url)),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
