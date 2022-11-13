// Copyright (c) 2021 Simform Solutions. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../extensions.dart';
import '../typedefs.dart';
import 'common_components.dart';

const weekKr = ['월','화','수','목','금','토','일'];   // customer added

/// This class defines default tile to display in day view.
class RoundedEventTile extends StatelessWidget {
  /// Title of the tile.
  final String title;

  /// Description of the tile.
  final String description;

  /// Background color of tile.
  /// Default color is [Colors.blue]
  final Color backgroundColor;

  /// If same tile can have multiple events.
  /// In most cases this value will be 1 less than total events.
  final int totalEvents;

  /// Padding of the tile. Default padding is [EdgeInsets.zero]
  final EdgeInsets padding;

  /// Margin of the tile. Default margin is [EdgeInsets.zero]
  final EdgeInsets margin;

  /// Border radius of tile.
  final BorderRadius borderRadius;

  /// Style for title
  final TextStyle? titleStyle;

  /// Style for description
  final TextStyle? descriptionStyle;

  /// This is default tile to display in day view.
  const RoundedEventTile({
    Key? key,
    required this.title,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.description = "",
    this.borderRadius = BorderRadius.zero,
    this.totalEvents = 1,
    this.backgroundColor = Colors.blue,
    this.titleStyle,
    this.descriptionStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title.isNotEmpty)
            Expanded(
              child: Text(
                title,
                style: titleStyle ??
                    TextStyle(
                      fontSize: 14,
                      color: backgroundColor.accent,
                    ),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          // if (description.isNotEmpty)
          //   Expanded(
          //     child: Padding(
          //       padding: const EdgeInsets.only(bottom: 15.0),
          //       child: Text(
          //         description,
          //         style: descriptionStyle ??
          //             TextStyle(
          //               fontSize: 12,
          //               color: backgroundColor.accent.withAlpha(200),
          //             ),
          //       ),
          //     ),
          //   ),
          if (totalEvents > 1)
            Expanded(
              child: Text(
                "+${totalEvents - 1} more",
                style: (descriptionStyle ??
                        TextStyle(
                          color: backgroundColor.accent.withAlpha(200),
                        ))
                    .copyWith(fontSize: 17),
              ),
            ),
        ],
      ),
    );
  }
}

/// A header widget to display on day view.
class DayPageHeader extends CalendarPageHeader {
  /// A header widget to display on day view.
  const DayPageHeader({
    Key? key,
    VoidCallback? onNextDay,
    AsyncCallback? onTitleTapped,
    VoidCallback? onPreviousDay,
    Color iconColor = Constants.black,
    Color backgroundColor = Constants.headerBackground,
    StringProvider? dateStringBuilder,
    required DateTime date,
    TextStyle? textStyle,
  }) : super(
          key: key,
          date: date,
          backgroundColor: backgroundColor,
          iconColor: iconColor,
          onNextDay: onNextDay,
          onPreviousDay: onPreviousDay,
          onTitleTapped: onTitleTapped,
          dateStringBuilder:
              dateStringBuilder ?? DayPageHeader._dayStringBuilder,
          textStyle: textStyle,
        );
  static String _dayStringBuilder(DateTime date, {DateTime? secondaryDate}) =>
      // "${date.day} - ${date.month} - ${date.year}";   // original
      "${date.year}년 ${date.month}월 ${date.day}일 ${weekKr[date.weekday-1]}요일";   // custom modified
}

class DefaultTimeLineMark extends StatelessWidget {
  /// Defines time to display
  final DateTime date;

  /// StringProvider for time string
  final StringProvider? timeStringBuilder;

  /// Text style for time string.
  final TextStyle? markingStyle;

  /// Time marker for timeline used in week and day view.
  const DefaultTimeLineMark({
    Key? key,
    required this.date,
    this.markingStyle,
    this.timeStringBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timeString = (timeStringBuilder != null)
        ? timeStringBuilder!(date)
        : "${((date.hour - 1) % 12) + 1} ${date.hour ~/ 12 == 0 ? "am" : "pm"}";
    return Transform.translate(
      offset: Offset(0, -7.5),
      child: Padding(
        padding: const EdgeInsets.only(right: 7.0),
        child: Text(
          timeString,
          textAlign: TextAlign.right,
          style: markingStyle ??
              TextStyle(
                fontSize: 15.0,
              ),
        ),
      ),
    );
  }
}
