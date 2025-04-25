import 'package:flutter/material.dart';

class EventCreate extends StatefulWidget {
  const EventCreate({super.key});

  @override
  State<StatefulWidget> createState() {
    return EventCreateState();
  }
}

class EventCreateState extends State<EventCreate> {
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
        title: const Text(
          "Event Creation",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 14,
            color: Color(0xff000000),
          ),
        ),
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
                fontStyle: FontStyle.normal,
                fontSize: 20,
                color: Color(0xff000000),
              ),
            ),
          ),
          const Align(alignment: Alignment(0.0, -0.7), child: DatePicker()),
          Align(
            alignment: const Alignment(0.8, 0.2),
            child: Checkbox(
              onChanged: (value) {},
              activeColor: Color(0xff3a57e8),
              autofocus: false,
              checkColor: Color(0xffffffff),
              hoverColor: Color(0x42000000),
              splashRadius: 20,
              value: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Align(
              alignment: const Alignment(0.0, -0.2),
              child: TextField(
                controller: TextEditingController(),
                obscureText: false,
                textAlign: TextAlign.left,
                maxLines: 5,
                maxLength: 200,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Color(0xff000000),
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide:
                        const BorderSide(color: Color(0xff000000), width: 1),
                  ),
                  hintText: "Brief Description of Event:",
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: Color(0xff000000),
                  ),
                  filled: true,
                  fillColor: Color(0xfff2f2f3),
                  isDense: false,
                  contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment(0.4, 0.2),
            child: Text(
              "Repeat Weekly?",
              textAlign: TextAlign.start,
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 14,
                color: Color(0xff000000),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

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
    });
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
