import 'package:flutter/material.dart';

class AddTaskForm extends StatelessWidget {
  AddTaskForm({Key? key, required this.onFormSave}) : super(key: key);

  final Function(
    String title,
    String description,
    int hour,
    int minute,
  ) onFormSave;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _timeController = "24";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Text(
              "Add task",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              value: _timeController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: List.generate(
                48,
                (index) => DropdownMenuItem(
                  value: index.toString(),
                  child: Text("${index ~/ 2}:${index % 2 == 0 ? "00" : "30"}"),
                ),
              ),
              onChanged: (value) {
                _timeController = value as String;
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  onFormSave(
                    _titleController.text,
                    _descriptionController.text,
                    int.parse(_timeController) ~/ 2,
                    (int.parse(_timeController) % 2) * 30,
                  );
                }
              },
              child: const Text("Add"),
            ),
          ],
        ),
      ),
    );
  }
}
