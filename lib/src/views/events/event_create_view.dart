import 'package:flutter/material.dart';
import 'package:socdrawer/src/controllers/event_controller.dart';
import 'package:socdrawer/src/controllers/user_controller.dart';
import 'package:socdrawer/src/models/event.dart';
import 'package:socdrawer/src/models/society.dart';
import 'package:socdrawer/src/models/user.dart';

class EventCreate extends StatefulWidget {
  static const routeName = '/event/create';
  final User user;

  EventCreate({super.key}) : user = getLoggedInUser()!;

  @override
  State<EventCreate> createState() => _EventCreateState();
}

class _EventCreateState extends State<EventCreate> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _locationController = TextEditingController();

  late Socieity _selectedSociety;
  DateTime _eventDate = DateTime.now();
  bool _repeatWeekly = false;
  bool _needsPayment = false;

  @override
  void initState() {
    super.initState();
    _selectedSociety = widget.user.comitteeSocieties.first;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _createEvent() {
    final name = _nameController.text.trim();
    final desc = _descController.text.trim();
    final location = _locationController.text.trim();

    if (name.isEmpty || location.isEmpty) {
      _showSnackbar('Event name and location are required.', Colors.red);
      return;
    }

    final event = Event(
      name: name,
      description: desc,
      location: location,
      society: _selectedSociety,
      dateTime: _eventDate,
      isRepeating: _repeatWeekly,
      needsPayment: _needsPayment,
    );

    createEvent(event);
    if (_repeatWeekly) {
      for (int i = 1; i < 4; i++) {
        final newEvent = Event(
          name: name,
          description: desc,
          location: location,
          society: _selectedSociety,
          isRepeating: _repeatWeekly,
          needsPayment: _needsPayment,
          dateTime: _eventDate.add(Duration(days: i * 7)),
        );
        createEvent(newEvent);
        setState(() {});
      }
    }
    Navigator.pop(context,
        event); // return a value to indivate that the state should update
    _showSnackbar('Event successfully created.', Colors.green);
  }

  void _showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _eventDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Event"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildTextInput("Event Name", _nameController, maxLength: 50),
            _buildTextInput("Event Description", _descController,
                maxLines: 5, maxLength: 200),
            _buildDatePicker(),
            _buildTextInput("Location", _locationController),
            _buildRepeatCheckbox(),
            _buildPaidCheckbox(),
            _buildSocietyDropdown(),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _createEvent,
              icon: const Icon(Icons.event),
              label: const Text("Create Event"),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextInput(String label, TextEditingController controller,
      {int maxLines = 1, int? maxLength}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          maxLength: maxLength,
          decoration: InputDecoration(
            hintText: "Enter $label".toLowerCase(),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            filled: true,
            fillColor: Colors.grey[100],
          ),
        )
      ]),
    );
  }

  Widget _buildDatePicker() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          const Text("Event Date",
              style: TextStyle(fontWeight: FontWeight.w600)),
          const Spacer(),
          OutlinedButton(
            onPressed: _pickDate,
            child: Text(
              '${_eventDate.day}/${_eventDate.month}/${_eventDate.year}',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRepeatCheckbox() {
    return Column(
      children: [
        CheckboxListTile(
          title: const Text("Repeat Weekly?"),
          value: _repeatWeekly,
          onChanged: (val) => setState(() => _repeatWeekly = val ?? false),
          contentPadding: EdgeInsets.zero,
        ),
        if (_repeatWeekly)
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "This event will repeat weekly for the next 4 weeks.",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildPaidCheckbox() {
    return Column(
      children: [
        CheckboxListTile(
          title: const Text("Requires payment?"),
          value: _needsPayment,
          onChanged: (val) => setState(() => _needsPayment = val ?? false),
          contentPadding: EdgeInsets.zero,
        ),
        if (_needsPayment)
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "This event now requires payment on union page",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildSocietyDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedSociety.name,
      items: widget.user.comitteeSocieties
          .map((s) => DropdownMenuItem(value: s.name, child: Text(s.name)))
          .toList(),
      onChanged: (newValue) {
        final society =
            widget.user.comitteeSocieties.firstWhere((s) => s.name == newValue);
        setState(() => _selectedSociety = society);
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.grey[100],
      ),
    );
  }
}
