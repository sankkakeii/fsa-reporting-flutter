import 'package:flutter/material.dart';

class PersonalInformationStep extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Function(String) onSavedEmail;
  final Function(String) onSavedFirstName;
  final Function(String) onSavedMiddleName;
  final Function(String) onSavedLastName;

  const PersonalInformationStep({
    Key? key,
    required this.formKey,
    required this.onSavedEmail,
    required this.onSavedFirstName,
    required this.onSavedMiddleName,
    required this.onSavedLastName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
            onSaved: (value) => onSavedEmail(value!),
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'First Name',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your first name';
              }
              return null;
            },
            onSaved: (value) => onSavedFirstName(value!),
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Middle Name',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) => onSavedMiddleName(value!),
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Last Name',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your last name';
              }
              return null;
            },
            onSaved: (value) => onSavedLastName(value!),
          ),
        ],
      ),
    );
  }
}
