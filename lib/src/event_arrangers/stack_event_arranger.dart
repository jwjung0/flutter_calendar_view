// Copyright (c) 2021 Simform Solutions. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of 'event_arrangers.dart';

class StackEventArranger<T extends Object?> extends EventArranger<T> {
  /// This class will provide method that will arrange
  /// all the events overlap
  const StackEventArranger();

  @override
  List<OrganizedCalendarEventData<T>> arrange({
    required List<CalendarEventData<T>> events,
    required double height,
    required double width,
    required double heightPerMinute,
  }) {
    final arrangedEvents = <OrganizedCalendarEventData<T>>[];

    for (final event in events) {
      final startTime = event.startTime ?? DateTime.now();
      final endTime = event.endTime ?? startTime;

      assert(
      !(endTime.getTotalMinutes <= startTime.getTotalMinutes),
      "Assertion fail for event: \n$event\n"
          "startDate must be less than endDate.\n"
          "This error occurs when you does not provide startDate or endDate in "
          "CalendarEventDate or provided endDate occurs before startDate.");

      final eventStart = startTime.getTotalMinutes;
      final eventEnd = endTime.getTotalMinutes;

      final top = eventStart * heightPerMinute;
      final bottom = height - eventEnd * heightPerMinute;

      final newEvent = OrganizedCalendarEventData<T>(
        top: top,
        bottom: bottom,
        left: 0,
        right: 0,
        startDuration: startTime.copyFromMinutes(eventStart),
        endDuration: endTime.copyFromMinutes(eventEnd),
        events: [event],
      );
      arrangedEvents.add(newEvent);
    }
    return arrangedEvents;
  }
}
