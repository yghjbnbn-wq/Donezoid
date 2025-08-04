import 'package:donezoid/models/task_model.dart';
import 'package:donezoid/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:uuid/uuid.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _notesController = TextEditingController();

  Priority _selectedPriority = Priority.medium;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  Color _selectedColor = Colors.blue;

  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  TextEditingController? _activeSpeechController;

  final List<Color> _availableColors = [
    Colors.blue, Colors.green, Colors.orange, Colors.red, Colors.purple,
    Colors.pink, Colors.teal, Colors.indigo, Colors.amber, Colors.brown,
    Colors.cyan, Colors.lime,
  ];

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// Initializes the speech-to-text plugin.
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Starts a speech recognition session for the given text controller.
  void _startListening(TextEditingController controller) async {
    await _stopListening(); // Ensure any previous session is stopped
    setState(() {
      _activeSpeechController = controller;
    });
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Stops the current speech recognition session.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      _activeSpeechController = null;
    });
  }

  /// Callback for when speech is recognized.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _activeSpeechController?.text = result.recognizedWords;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _notesController.dispose();
    _speechToText.stop();
    super.dispose();
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      final finalDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      final newTask = Task(
        id: const Uuid().v4(),
        title: _titleController.text,
        description: _descriptionController.text,
        notes: _notesController.text,
        priority: _selectedPriority,
        dueDate: finalDateTime,
        color: _selectedColor.value,
      );

      taskProvider.addTask(newTask);
      HapticFeedback.heavyImpact();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveTask,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: const OutlineInputBorder(),
                  suffixIcon: _buildMicIcon(_titleController),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description (Optional)',
                  border: const OutlineInputBorder(),
                  suffixIcon: _buildMicIcon(_descriptionController),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(
                  labelText: 'Notes (Optional)',
                  border: const OutlineInputBorder(),
                  suffixIcon: _buildMicIcon(_notesController),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              const Text('Priority', style: TextStyle(fontWeight: FontWeight.bold)),
              SegmentedButton<Priority>(
                segments: const [
                  ButtonSegment(value: Priority.low, label: Text('Low')),
                  ButtonSegment(value: Priority.medium, label: Text('Medium')),
                  ButtonSegment(value: Priority.high, label: Text('High')),
                  ButtonSegment(value: Priority.urgent, label: Text('Urgent')),
                ],
                selected: {_selectedPriority},
                onSelectionChanged: (newSelection) {
                  setState(() {
                    _selectedPriority = newSelection.first;
                  });
                },
              ),
              const SizedBox(height: 24),
              const Text('Due Date & Time', style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  TextButton.icon(
                    icon: const Icon(Icons.calendar_today),
                    label: Text(DateFormat.yMMMd().format(_selectedDate)),
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null && pickedDate != _selectedDate) {
                        setState(() {
                          _selectedDate = pickedDate;
                        });
                      }
                    },
                  ),
                  const Spacer(),
                  TextButton.icon(
                    icon: const Icon(Icons.access_time),
                    label: Text(_selectedTime.format(context)),
                    onPressed: () async {
                      final pickedTime = await showTimePicker(
                        context: context,
                        initialTime: _selectedTime,
                      );
                      if (pickedTime != null && pickedTime != _selectedTime) {
                        setState(() {
                          _selectedTime = pickedTime;
                        });
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text('Color', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _availableColors.length,
                  itemBuilder: (context, index) {
                    final color = _availableColors[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColor = color;
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: _selectedColor == color
                              ? Border.all(
                                  color: Theme.of(context).colorScheme.onSurface,
                                  width: 3)
                              : null,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(width: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMicIcon(TextEditingController controller) {
    bool isListening = _speechToText.isListening && _activeSpeechController == controller;
    return IconButton(
      icon: Icon(isListening ? Icons.mic_off : Icons.mic, color: isListening ? Colors.red : null),
      onPressed: !_speechEnabled ? null : () => isListening ? _stopListening() : _startListening(controller),
    );
  }
}
