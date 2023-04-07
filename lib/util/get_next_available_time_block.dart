import 'package:flutter/material.dart';

TimeOfDay? getNextAvailableTimeBlock(
    TimeOfDay startTime, TimeOfDay endTime, int numberOfSelectedBlocks) {
  int minutes = numberOfSelectedBlocks * 10;

  DateTime possibleAvailableBlock =
      DateTime(2000, 1, 1, startTime.hour, startTime.minute)
          .add(Duration(minutes: minutes));

  DateTime limit = DateTime(2000, 1, 1, endTime.hour, endTime.minute);

  if (limit.difference(possibleAvailableBlock).inMinutes >= 10) {
    return TimeOfDay.fromDateTime(possibleAvailableBlock);
  } else {
    return null;
  }
}
