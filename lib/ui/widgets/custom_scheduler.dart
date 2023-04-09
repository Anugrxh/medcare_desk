import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../util/get_next_available_time_block.dart';
import '../../util/get_number_of_10_minute_blocks.dart';
import 'custom_alert_dialog.dart';
import 'custom_card.dart';

class CustomScheduler extends StatefulWidget {
  final int offDay; //1-7 weekdays 1:monday, 7:sunday
  final List<DateTime> booked;
  final TimeOfDay timeFrom, timeTo;
  const CustomScheduler({
    super.key,
    this.offDay = DateTime.sunday, //sunday off by default
    required this.booked,
    required this.timeFrom,
    required this.timeTo,
  });

  @override
  State<CustomScheduler> createState() => _CustomSchedulerState();
}

class _CustomSchedulerState extends State<CustomScheduler> {
  List<DateTime> dates = List<DateTime>.generate(
    120,
    (index) => DateTime.now().add(
      Duration(
        days: index,
      ),
    ),
  );

  DateTime? selectedDate;

  int takenSlots(DateTime date) {
    int takenSlots = 0;

    for (int i = 0; i < widget.booked.length; i++) {
      DateTime checkingDate = widget.booked[i];

      if (date.year == checkingDate.year &&
          date.month == checkingDate.month &&
          date.day == checkingDate.day) {
        takenSlots++;
      }
    }
    return takenSlots;
  }

  // 1 means not available <1 means available
  double slotAvailability(DateTime date) {
    int maxSlots = getNumberOf10MinuteBlocks(widget.timeFrom, widget.timeTo);

    int slots = takenSlots(date);

    return (slots / maxSlots);
  }

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: 'Select a Date',
      message:
          'Select a date to check if there are slots available and if available, click the book button to book it.',
      primaryButtonLabel: 'Select',
      width: 700,
      content: SizedBox(
        height: 400,
        child: Row(
          children: [
            SizedBox(
              width: 300,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                itemBuilder: (context, index) {
                  double availability = slotAvailability(dates[index]);
                  Color availabilityColor = Colors.green;

                  if (availability > .9) {
                    availabilityColor = Colors.red;
                  } else if (availability > .5) {
                    availabilityColor = Colors.orange;
                  }

                  return CustomCard(
                    onPressed: dates[index].weekday == widget.offDay
                        ? null
                        : () {
                            selectedDate = dates[index];
                            setState(() {});
                          },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      child: Column(
                        children: [
                          Text(
                            DateFormat('EEEE d MMMM y').format(
                              dates[index],
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: dates[index].weekday == widget.offDay
                                      ? Colors.red
                                      : Colors.black,
                                ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: SizedBox(
                                height: 4,
                                child: LinearProgressIndicator(
                                  color: dates[index].weekday == widget.offDay
                                      ? Colors.red
                                      : availabilityColor,
                                  value: dates[index].weekday == widget.offDay
                                      ? 1
                                      : availability,
                                  backgroundColor: Colors.black12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(height: 10),
                itemCount: dates.length,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      selectedDate == null
                          ? 'Select Date to check availability'
                          : getNextAvailableTimeBlock(
                                    selectedDate!,
                                    widget.timeFrom,
                                    widget.timeTo,
                                    takenSlots(selectedDate!),
                                  ) !=
                                  null
                              ? 'Next Available Slot'
                              : 'No slots available for the date, choose a different date.',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: selectedDate != null &&
                                    getNextAvailableTimeBlock(
                                          selectedDate!,
                                          widget.timeFrom,
                                          widget.timeTo,
                                          takenSlots(selectedDate!),
                                        ) !=
                                        null
                                ? Colors.black54
                                : Colors.red,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    selectedDate != null &&
                            getNextAvailableTimeBlock(
                                  selectedDate!,
                                  widget.timeFrom,
                                  widget.timeTo,
                                  takenSlots(selectedDate!),
                                ) !=
                                null
                        ? Text(
                            getNextAvailableTimeBlock(
                              selectedDate!,
                              widget.timeFrom,
                              widget.timeTo,
                              takenSlots(selectedDate!),
                            )!
                                .format(context),
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                  color: Colors.black,
                                ),
                          )
                        : const SizedBox(),
                    const SizedBox(height: 10),
                    selectedDate != null
                        ? Text(
                            DateFormat('d MMMM yyyy').format(selectedDate!),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: Colors.black54,
                                ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      primaryOnPressed: () {
        if (selectedDate != null) {
          TimeOfDay? bookingTime = getNextAvailableTimeBlock(
            selectedDate!,
            widget.timeFrom,
            widget.timeTo,
            takenSlots(selectedDate!),
          );

          if (bookingTime != null) {
            DateTime bookingDateTime = DateTime(
              selectedDate!.year,
              selectedDate!.month,
              selectedDate!.day,
              bookingTime.hour,
              bookingTime.minute,
            );

            Navigator.of(context).pop(bookingDateTime);
          } else {
            showDialog(
              context: context,
              builder: (context) => const CustomAlertDialog(
                title: 'No Slot Available!',
                message:
                    'No slot available to book for the selected day, please select a different day.',
                primaryButtonLabel: 'Ok',
              ),
            );
          }
        } else {
          showDialog(
            context: context,
            builder: (context) => const CustomAlertDialog(
              title: 'No Date Selected!',
              message: 'Select a day to book appointments.',
              primaryButtonLabel: 'Ok',
            ),
          );
        }
      },
    );
  }
}
