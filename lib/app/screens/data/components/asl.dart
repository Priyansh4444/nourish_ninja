import 'package:flutter/material.dart';

class ASLForm extends StatefulWidget {
  final bool isASLOptional;

  const ASLForm({super.key, this.isASLOptional = false});

  @override
  _ASLFormState createState() => _ASLFormState();
}

class _ASLFormState extends State<ASLForm> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  bool _hasSymptoms = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _heightController,
          decoration: const InputDecoration(
            labelText: 'Height',
          ),
        ),
        TextField(
          controller: _weightController,
          decoration: const InputDecoration(
            labelText: 'Weight',
          ),
        ),
        if (!widget.isASLOptional)
          CheckboxListTile(
            title: const Text('Do you have any symptoms?'),
            value: _hasSymptoms,
            onChanged: (value) {
              setState(() {
                _hasSymptoms = value!;
              });
            },
          ),
      ],
    );
  }
}
