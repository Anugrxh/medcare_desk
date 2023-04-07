import 'package:flutter/material.dart';

int getNumberOf10MinuteBlocks(TimeOfDay startTime, TimeOfDay endTime) {
  int startMinutes = startTime.hour * 60 + startTime.minute;
  int endMinutes = endTime.hour * 60 + endTime.minute;
  int durationMinutes = endMinutes - startMinutes;
  return (durationMinutes / 10).ceil();
}
