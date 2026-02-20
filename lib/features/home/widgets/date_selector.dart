import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DateSelector extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const DateSelector({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  Future<void> _showCalendarDialog(BuildContext context) async {
    DateTime focusedDay = selectedDate;
    DateTime? pickedDate;

    await showDialog<DateTime>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              content: SizedBox(
                width: double.maxFinite,
                height: 400,
                child: TableCalendar(
                  firstDay: DateTime(2000),
                  lastDay: DateTime(2101),
                  focusedDay: focusedDay,
                  selectedDayPredicate: (day) =>
                      isSameDay(pickedDate ?? selectedDate, day),
                  calendarFormat: CalendarFormat.month,
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Month',
                  },
                  calendarStyle: CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: HeaderStyle(
                    titleTextStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  onDaySelected: (selected, focused) {
                    setDialogState(() {
                      pickedDate = selected;
                      focusedDay = focused;
                    });
                    Navigator.of(context).pop();
                  },
                  onPageChanged: (focused) {
                    focusedDay = focused;
                  },
                ),
              ),
            );
          },
        );
      },
    );

    if (pickedDate != null && !isSameDay(pickedDate!, selectedDate)) {
      onDateSelected(pickedDate!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: () => _showCalendarDialog(context),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: 'Date',
            labelStyle: GoogleFonts.poppins(color: Colors.grey.shade800),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(DateFormat('dd-MM-yyyy').format(selectedDate)),
              const Icon(Icons.calendar_today),
            ],
          ),
        ),
      ),
    );
  }
}
