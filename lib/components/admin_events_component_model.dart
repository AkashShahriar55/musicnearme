import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'admin_events_component_widget.dart' show AdminEventsComponentWidget;
import 'package:flutter/material.dart';

class AdminEventsComponentModel
    extends FlutterFlowModel<AdminEventsComponentWidget> {
  ///  Local state fields for this component.

  String currentSelectedDate = '01/02/2000';

  DateTime? currentSelectedDay;

  int? selectedView = 0;

  List<EventObjStruct> foundDates = [];
  void addToFoundDates(EventObjStruct item) => foundDates.add(item);
  void removeFromFoundDates(EventObjStruct item) => foundDates.remove(item);
  void removeAtIndexFromFoundDates(int index) => foundDates.removeAt(index);
  void insertAtIndexInFoundDates(int index, EventObjStruct item) =>
      foundDates.insert(index, item);
  void updateFoundDatesAtIndex(int index, Function(EventObjStruct) updateFn) =>
      foundDates[index] = updateFn(foundDates[index]);

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in adminEventsComponent widget.
  List<EventsRecord>? eventsQuery;
  // Stores action output result for [Custom Action - createEventListAction] action in adminEventsComponent widget.
  List<EventObjStruct>? newEvents;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Stores action output result for [Firestore Query - Query a collection] action in Icon widget.
  List<EventsRecord>? eventsQueryAfterDeleteListview;
  // Stores action output result for [Custom Action - createEventListAction] action in Icon widget.
  List<EventObjStruct>? newEventsAfterDeleteListView;
  // State field(s) for Calendar widget.
  DateTimeRange? calendarSelectedDay;
  // Stores action output result for [Firestore Query - Query a collection] action in Icon widget.
  List<EventsRecord>? eventQueryAfterDeleteCalendar;
  // Stores action output result for [Custom Action - createEventListAction] action in Icon widget.
  List<EventObjStruct>? newEventsAfterDeleteCalendar;

  @override
  void initState(BuildContext context) {
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
  }

  @override
  void dispose() {}
}
