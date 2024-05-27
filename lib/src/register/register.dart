import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../login/login.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  static const routeName = '/registration';

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String email = '';
  String firstName = '';
  String middleName = '';
  String lastName = '';
  String address = '';
  String city = '';
  String state = '';
  String phoneNumber = '';
  String alternateMobileNumber = '';
  String referralNumber = '';
  String accountName = '';
  String accountNumber = '';
  String bankName = '';
  String dataBundlePhoneNumber = '';
  String yourTeam = '';
  String errorMessage = '';
  String bgImageUrl = "assets/images/backgrounds/bg.png";

  File? passportImage;
  File? utilityBillImage;

  int _currentStep = 0;
  bool _isSubmitting = false;

  void _next() {
    if (_currentStep < 3) {
      setState(() {
        _currentStep += 1;
      });
    } else {
      _submit();
    }
  }

  void _prev() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }

  void _submit() async {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();

      setState(() {
        _isSubmitting = true;
        errorMessage = '';
      });

      try {
        String passportBase64 = base64Encode(await passportImage!.readAsBytes());
        String utilityBillBase64 = base64Encode(await utilityBillImage!.readAsBytes());

        final Map<String, String> payload = {
          'email': email,
          'first_name': firstName,
          'middlename': middleName,
          'last_name': lastName,
          'passport': passportBase64,
          'utilitybill': utilityBillBase64,
          'address': address,
          'city': city,
          'state': state,
          'phone_number': phoneNumber,
          'alternatemobilenumber': alternateMobileNumber,
          'referalnumber': referralNumber,
          'accountname': accountName,
          'accountnumber': accountNumber,
          'bankname': bankName,
          'databundlephonenumber': dataBundlePhoneNumber,
          'yourteam': yourTeam,
        };

        final http.Response response = await http.post(
          Uri.parse('https://fintecgrate.com/xooxoxo/api/fsasignup.php'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(payload),
        );

        print('Response Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseBody = jsonDecode(response.body);
          if (responseBody.containsKey('status') && responseBody['status']) {
            Navigator.pushReplacementNamed(
              context,
              Login.routeName,
              arguments: {'email': email},
            );
          } else if (responseBody.containsKey('message') && !responseBody['status']) {
            _showErrorDialog(responseBody['message']);
          } else {
            _showErrorDialog('Registration failed. Please try again later.');
          }
        } else {
          _showErrorDialog('Registration failed. Please try again later.');
        }
      } catch (error) {
        _showErrorDialog('Error registering. Please try again.');
        print('Error submitting form: $error');
      } finally {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Registration Failed'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickPassportImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        passportImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickUtilityBillImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        utilityBillImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bgImageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
          child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Stepper(
            type: StepperType.vertical,
            currentStep: _currentStep,
            onStepContinue: _next,
            onStepCancel: _prev,
            steps: <Step>[

              // PERSONAL INFORMATION
        Step(
        title: const Text('Personal Information'),
        content: Column(
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
        onSaved: (value) => email = value!,
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
        onSaved: (value) => firstName = value!,
      ),
      const SizedBox(height: 10.0),
      TextFormField(
        decoration: const InputDecoration(
          labelText: 'Middle Name',
          border: OutlineInputBorder(),
        ),
        onSaved: (value) => middleName = value!,
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
        onSaved: (value) => lastName = value!,
      ),
          ],
        ),
        ),

              // ADDRESS INFORMATION
              Step(
                title: const Text('Address Information'),
                content: Column(
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
                      onSaved: (value) => address = value!,
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
                      onSaved: (value) => city = value!,
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
                      onSaved: (value) => state = value!,
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
                      onSaved: (value) => phoneNumber = value!,
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Alternate Mobile Number',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                      onSaved: (value) => alternateMobileNumber = value!,
                    ),
                  ],
                ),
              ),

              // BANK INFORMATION
              Step(
                title: const Text('Bank Information'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Referral Number',
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (value) => referralNumber = value!,
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Account Name',
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (value) => accountName = value!,
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Account Number',
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (value) => accountNumber = value!,
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Bank Name',
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (value) => bankName = value!,
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Data Bundle Phone Number',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                      onSaved: (value) => dataBundlePhoneNumber = value!,
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Your Team',
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (value) => yourTeam = value!,
                    ),
                  ],
                ),
              ),

              // IMAGE INFORMATION
              Step(
                title: const Text('Images'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: _pickPassportImage,
                      child: Text(passportImage == null
                          ? 'Pick Passport Image'
                          : 'Change Passport Image'),
                    ),
                    const SizedBox(height: 10.0),
                    ElevatedButton(
                      onPressed: _pickUtilityBillImage,
                      child: Text(utilityBillImage == null
                          ? 'Pick Utility Bill Image'
                          : 'Change Utility Bill Image'),
                    ),
                  ],
                ),
              ),
            ],
        ),
      ),
          ),
          ),
      ),
      bottomNavigationBar: _isSubmitting
          ? const LinearProgressIndicator()
          : Container(height: 0),
    );
  }
}