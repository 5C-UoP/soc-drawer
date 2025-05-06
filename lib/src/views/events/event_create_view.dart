import 'package:flutter/material.dart';
import 'package:socdrawer/src/controllers/society_controller.dart';
import 'package:socdrawer/src/models/event.dart';
import 'package:socdrawer/src/models/society.dart';

DateTime eventDateTime = DateTime.now();

class EventCreate extends StatefulWidget {
  const EventCreate({super.key});

  @override
  State<StatefulWidget> createState() {
    return EventCreateState();
  }
}

class EventCreateState extends State<EventCreate> {
  String eventName = '';
  String eventDescription = '';
  String eventLocation = '';
  late Socieity eventSociety;
  bool repeatChecked = false;
  final TextEditingController eventDescController = TextEditingController();
  final TextEditingController eventNameController = TextEditingController();
  // final newEvent = Event();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        elevation: 4,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff3a57e8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: const Text("Event Creation"),
        leading: const Icon(
          Icons.arrow_back,
          color: Color(0xff212435),
          size: 24,
        ),
      ),
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          const Align(
            alignment: Alignment(0.0, -0.9),
            child: Text(
              "Create Event:",
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0.0, -0.7),
            child: DatePicker(
              onDateSelected: (DateTime selectedDate) {
                setState(() {
                  eventDateTime = selectedDate;
                });
              },
            ),
          ),
          Align(
            alignment: const Alignment(0.1, 0.6),
            child: Checkbox(
              value: repeatChecked,
              splashRadius: 20,
              onChanged: (bool? value) {
                setState(() {
                  repeatChecked = value!;
                });
              },
            ),
          ),
          // Name TextField
          Padding(
            padding: const EdgeInsets.all(20),
            child: Align(
              alignment: const Alignment(0.0, -0.4),
              child: TextField(
                controller: eventNameController,
                obscureText: false,
                textAlign: TextAlign.left,
                maxLines: 1,
                maxLength: 50,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide:
                        const BorderSide(color: Color(0xff000000), width: 1),
                  ),
                  hintText: "Name of Event:",
                  filled: true,
                  fillColor: Color(0xfff2f2f2),
                  isDense: false,
                  contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                ),
              ),
            ),
          ),

          // Description TextField
          Padding(
            padding: const EdgeInsets.all(20),
            child: Align(
              alignment: const Alignment(0.0, -0.0),
              child: TextField(
                controller: eventDescController,
                obscureText: false,
                textAlign: TextAlign.left,
                maxLines: 5,
                maxLength: 200,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide:
                        const BorderSide(color: Color(0xff000000), width: 1),
                  ),
                  hintText: "Brief Description of Event:",
                  filled: true,
                  fillColor: Color(0xfff2f2f2),
                  isDense: false,
                  contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment(0, 0.6),
            child: Text(
              "Repeat Weekly?",
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.8),
            child: MaterialButton(
              onPressed: () {
                setState(() {
                  eventName = eventNameController.text;
                  eventDescription = eventDescController.text;
                  eventLocation = "Location";
                  eventSociety = socieities[0];
                });
                final newEvent = Event(
                  name: eventName,
                  description: eventDescription,
                  location: eventLocation,
                  society: eventSociety!,
                  dateTime: eventDateTime,
                );
                print(newEvent.toString());
              },
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
                side: BorderSide(color: Color(0xff808080), width: 1),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: const Text("Create Event"),
            ),
          ),
        ],
      ),
    );
  }
}

class DatePicker extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  const DatePicker({super.key, required this.onDateSelected});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? selectedDate;

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
    );

    setState(() {
      selectedDate = pickedDate;
      eventDateTime = selectedDate!;
    });
    widget.onDateSelected(selectedDate!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      //spacing: 20,
      children: <Widget>[
        Text(
          selectedDate != null
              ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
              : 'No date selected',
        ),
        OutlinedButton(
            onPressed: _selectDate, child: const Text('Select Date')),
      ],
    );
  }
}
