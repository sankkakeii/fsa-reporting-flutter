import 'package:flutter/material.dart';

class BankInformationStep extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Function(String) onSavedReferralNumber;
  final Function(String) onSavedAccountName;
  final Function(String) onSavedAccountNumber;
  final Function(String) onSavedBankName;
  final Function(String) onSavedDataBundlePhoneNumber;
  final Function(String) onSavedYourTeam;

  const BankInformationStep({
    Key? key,
    required this.formKey,
    required this.onSavedReferralNumber,
    required this.onSavedAccountName,
    required this.onSavedAccountNumber,
    required this.onSavedBankName,
    required this.onSavedDataBundlePhoneNumber,
    required this.onSavedYourTeam,
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
              labelText: 'Referral Number',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) => onSavedReferralNumber(value!),
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Account Name',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) => onSavedAccountName(value!),
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Account Number',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) => onSavedAccountNumber(value!),
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Bank Name',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) => onSavedBankName(value!),
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Data Bundle Phone Number',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
            onSaved: (value) => onSavedDataBundlePhoneNumber(value!),
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Your Team',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) => onSavedYourTeam(value!),
          ),
        ],
      ),
    );
  }
}
