import 'package:flutter/material.dart';

class AddressInformationStep extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Function(String) onSavedAddress;
  final Function(String) onSavedCity;
  final Function(String) onSavedState;
  final Function(String) onSavedPhoneNumber;
  final Function(String) onSavedAlternateMobileNumber;

  const AddressInformationStep({
    Key? key,
    required this.formKey,
    required this.onSavedAddress,
    required this.onSavedCity,
    required this.onSavedState,
    required this.onSavedPhoneNumber,
    required this.onSavedAlternateMobileNumber,
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
              labelText: 'Address',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your address';
              }
              return null;
            },
            onSaved: (value) => onSavedAddress(value!),
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'City',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your city';
              }
              return null;
            },
            onSaved: (value) => onSavedCity(value!),
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'State',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your state';
              }
              return null;
            },
            onSaved: (value) => onSavedState(value!),
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
            onSaved: (value) => onSavedPhoneNumber(value!),
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Alternate Mobile Number',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
            onSaved: (value) => onSavedAlternateMobileNumber(value!),
          ),
        ],
      ),
    );
  }
}
