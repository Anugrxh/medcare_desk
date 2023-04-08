import 'package:flutter/material.dart';

TimeOfDay? getNextAvailableTimeBlock(DateTime date, TimeOfDay startTime,
    TimeOfDay endTime, int numberOfSelectedBlocks) {
  int minutes = numberOfSelectedBlocks * 10;

  DateTime currentDateTime = DateTime.now();

  DateTime possibleAvailableBlock = DateTime(
    date.year,
    date.month,
    date.day,
    startTime.hour,
    startTime.minute,
  ).add(Duration(minutes: minutes));

  DateTime limit = DateTime(
    date.year,
    date.month,
    date.day,
    endTime.hour,
    endTime.minute,
  );

  if (limit.difference(possibleAvailableBlock).inMinutes >= 10) {
    if (date.year == currentDateTime.year &&
        date.month == currentDateTime.month &&
        date.day == currentDateTime.day) {
      while (possibleAvailableBlock.isBefore(currentDateTime) &&
          possibleAvailableBlock.isBefore(limit)) {
        possibleAvailableBlock =
            possibleAvailableBlock.add(const Duration(minutes: 10));
      }

      if (possibleAvailableBlock.isAfter(currentDateTime) &&
          limit.difference(possibleAvailableBlock).inMinutes >= 10) {
        return TimeOfDay.fromDateTime(possibleAvailableBlock);
      } else {
        return null;
      }
    } else {
      return TimeOfDay.fromDateTime(possibleAvailableBlock);
    }
  } else {
    return null;
  }
}
