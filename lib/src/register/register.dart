// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';

// import '../login/login.dart';

// class Registration extends StatefulWidget {
//   const Registration({Key? key}) : super(key: key);

//   static const routeName = '/registration';

//   @override
//   _RegistrationState createState() => _RegistrationState();
// }

// class _RegistrationState extends State<Registration> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   String email = '';
//   String firstName = '';
//   String middleName = '';
//   String lastName = '';
//   // String passport = '';
//   // String utilityBill = '';
//   String address = '';
//   String city = '';
//   String state = '';
//   String phoneNumber = '';
//   String alternateMobileNumber = '';
//   String referralNumber = '';
//   String accountName = '';
//   String accountNumber = '';
//   String bankName = '';
//   String dataBundlePhoneNumber = '';
//   String yourTeam = '';
//   String password = '';
//   String errorMessage = '';
//   String bgImageUrl = "/images/backgrounds/bg.png";

//   File? passportImage;
//   File? utilityBillImage;

//   void register() async {
//     final form = _formKey.currentState;
//     if (form != null && form.validate()) {
//       form.save();

//       try {
//         String passportBase64 = base64Encode(await passportImage!.readAsBytes());
//         String utilityBillBase64 =
//             base64Encode(await utilityBillImage!.readAsBytes());

//         print(utilityBillBase64);
//         print(passportBase64);

//         final Map<String, String> payload = {
//           'email': email,
//           'first_name': firstName,
//           'middleName': middleName,
//           'last_name': lastName,
//           'passport': passportBase64,
//           'utilitybill': utilityBillBase64,
//           'address': address,
//           'city': city,
//           'state': state,
//           'phone_number': phoneNumber,
//           'alternatemobilenumber': alternateMobileNumber,
//           'referalnumber': referralNumber,
//           'accountname': accountName,
//           'accountnumber': accountNumber,
//           'bankname': bankName,
//           'databundlephonenumber': dataBundlePhoneNumber,
//           'yourteam': yourTeam,
//           'password': password,
//         };

//         final http.Response response = await http.post(
//           Uri.parse(
//               'https://proxy.cors.sh/https://fintecgrate.com/xooxoxo/api/fsasignup.php'),
//           headers: <String, String>{
//             'Content-Type': 'application/json; charset=UTF-8',
//             'x-cors-api-key': 'temp_5cad65143af4adbc1f2df88cd73fe8c6'
//           },
//           body: jsonEncode(payload),
//         );

//         if (response.statusCode == 200) {
//           final Map<String, dynamic> responseBody = jsonDecode(response.body);
//           if (responseBody.containsKey('status') && responseBody['status']) {
//             Navigator.pushReplacementNamed(
//               context,
//               Login.routeName,
//               arguments: {'email': email},
//             );
//           } else if (responseBody.containsKey('message')) {
//             setState(() {
//               errorMessage = responseBody['message'];
//             });
//           } else {
//             setState(() {
//               errorMessage = 'Registration failed. Please try again later.';
//             });
//           }
//         }
//       } catch (error) {
//         setState(() {
//           errorMessage = 'Error registering. Please try again.';
//         });
//       }
//     }
//   }

//   Future<void> pickPassportImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         passportImage = File(pickedFile.path);
//       });
//     }

//     print(base64Encode(await passportImage!.readAsBytes()));
//   }

//   Future<void> pickUtilityBillImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         utilityBillImage = File(pickedFile.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage(bgImageUrl),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Center(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(20.0),
//               child: Form(
//                 key: _formKey,
//                 child: Center(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       const Text(
//                         'Register',
//                         style: TextStyle(
//                             fontSize: 30,
//                             color: Color.fromARGB(255, 59, 59, 59),
//                             fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 20.0),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: 'Email',
//                           border: OutlineInputBorder(),
//                         ),
//                         keyboardType: TextInputType.emailAddress,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your email';
//                           }
//                           return null;
//                         },
//                         onSaved: (value) => email = value!,
//                       ),
//                       const SizedBox(height: 10.0),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: 'First Name',
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your first name';
//                           }
//                           return null;
//                         },
//                         onSaved: (value) => firstName = value!,
//                       ),
//                       const SizedBox(height: 10.0),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: 'Middle Name',
//                           border: OutlineInputBorder(),
//                         ),
//                         onSaved: (value) => middleName = value!,
//                       ),
//                       const SizedBox(height: 10.0),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: 'Last Name',
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your last name';
//                           }
//                           return null;
//                         },
//                         onSaved: (value) => lastName = value!,
//                       ),
//                       const SizedBox(height: 10.0),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: 'Address',
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your address';
//                           }
//                           return null;
//                         },
//                         onSaved: (value) => address = value!,
//                       ),
//                       const SizedBox(height: 10.0),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: 'City',
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your city';
//                           }
//                           return null;
//                         },
//                         onSaved: (value) => city = value!,
//                       ),
//                       const SizedBox(height: 10.0),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: 'State',
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your state';
//                           }
//                           return null;
//                         },
//                         onSaved: (value) => state = value!,
//                       ),
//                       const SizedBox(height: 10.0),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: 'Phone Number',
//                           border: OutlineInputBorder(),
//                         ),
//                         keyboardType: TextInputType.phone,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your phone number';
//                           }
//                           return null;
//                         },
//                         onSaved: (value) => phoneNumber = value!,
//                       ),
//                       const SizedBox(height: 10.0),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: 'Alternate Mobile Number',
//                           border: OutlineInputBorder(),
//                         ),
//                         keyboardType: TextInputType.phone,
//                         onSaved: (value) => alternateMobileNumber = value!,
//                       ),
//                       const SizedBox(height: 10.0),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: 'Referral Number',
//                           border: OutlineInputBorder(),
//                         ),
//                         onSaved: (value) => referralNumber = value!,
//                       ),
//                       const SizedBox(height: 10.0),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: 'Account Name',
//                           border: OutlineInputBorder(),
//                         ),
//                         onSaved: (value) => accountName = value!,
//                       ),
//                       const SizedBox(height: 10.0),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: 'Account Number',
//                           border: OutlineInputBorder(),
//                         ),
//                         onSaved: (value) => accountNumber = value!,
//                       ),
//                       const SizedBox(height: 10.0),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: 'Bank Name',
//                           border: OutlineInputBorder(),
//                         ),
//                         onSaved: (value) => bankName = value!,
//                       ),
//                       const SizedBox(height: 10.0),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: 'Data Bundle Phone Number',
//                           border: OutlineInputBorder(),
//                         ),
//                         keyboardType: TextInputType.phone,
//                         onSaved: (value) => dataBundlePhoneNumber = value!,
//                       ),
//                       const SizedBox(height: 10.0),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: 'Your Team',
//                           border: OutlineInputBorder(),
//                         ),
//                         onSaved: (value) => yourTeam = value!,
//                       ),
//                       const SizedBox(height: 10.0),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: 'Password',
//                           border: OutlineInputBorder(),
//                         ),
//                         obscureText: true,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter a password';
//                           }
//                           return null;
//                         },
//                         onSaved: (value) => password = value!,
//                       ),
//                       const SizedBox(height: 20.0),
//                       ElevatedButton(
//                         onPressed: pickPassportImage,
//                         child: Text(passportImage == null
//                             ? 'Pick Passport Image'
//                             : 'Change Passport Image'),
//                       ),
//                       const SizedBox(height: 10.0),
//                       ElevatedButton(
//                         onPressed: pickUtilityBillImage,
//                         child: Text(utilityBillImage == null
//                             ? 'Pick Utility Bill Image'
//                             : 'Change Utility Bill Image'),
//                       ),
//                       const SizedBox(height: 20.0),
//                       ElevatedButton(
//                         onPressed: register,
//                         child: const Text('Register'),
//                       ),
//                       const SizedBox(height: 10.0),
//                       if (errorMessage.isNotEmpty) ...[
//                         const SizedBox(height: 20.0),
//                         Text(
//                           errorMessage,
//                           style: const TextStyle(color: Colors.red),
//                         ),
//                       ],
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }























































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
  // String password = '';
  String errorMessage = '';
  String bgImageUrl = "/images/backgrounds/bg.png";

  File? passportImage;
  File? utilityBillImage;

  int _currentStep = 0;

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
          // 'password': password,
        };

        final http.Response response = await http.post(
          Uri.parse('https://fintecgrate.com/xooxoxo/api/fsasignup.php'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'x-cors-api-key': 'temp_5cad65143af4adbc1f2df88cd73fe8c6'
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
            setState(() {
              errorMessage = responseBody['message'];
            });
          } else {
            setState(() {
              errorMessage = 'Registration failed. Please try again later.';
            });
          } 
        }
      } catch (error) {
        setState(() {
          errorMessage = 'Error registering. Please try again.';
        });
        print('Error submitting form: $error');
      }
    }
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Registration'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Navigate back to the previous page when the back button is pressed
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
                    Step(
                      title: Text('Personal Information'),
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
                    Step(
                      title: Text('Address Information'),
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
                    Step(
                      title: Text('Bank Information'),
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
                    Step(
                      title: Text('Images'),
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
                          // Display selected images here
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

























// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';

// import '../login/login.dart';

// class Registration extends StatefulWidget {
//   const Registration({Key? key}) : super(key: key);

//   static const routeName = '/registration';

//   @override
//   _RegistrationState createState() => _RegistrationState();
// }

// class _RegistrationState extends State<Registration> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   String email = '';
//   String firstName = '';
//   String middleName = '';
//   String lastName = '';
//   String address = '';
//   String city = '';
//   String state = '';
//   String phoneNumber = '';
//   String alternateMobileNumber = '';
//   String referralNumber = '';
//   String accountName = '';
//   String accountNumber = '';
//   String bankName = '';
//   String dataBundlePhoneNumber = '';
//   String yourTeam = '';
//   String password = '';
//   String errorMessage = '';
//   String bgImageUrl = "/images/backgrounds/bg.png";

//   File? passportImage;
//   File? utilityBillImage;

//   int _currentStep = 0;

//   void _next() {
//     if (_currentStep < 3) {
//       setState(() {
//         _currentStep += 1;
//       });
//     } else {
//       _submit();
//     }
//   }

//   void _prev() {
//     if (_currentStep > 0) {
//       setState(() {
//         _currentStep -= 1;
//       });
//     }
//   }

//   void _submit() async {
//     final form = _formKey.currentState;
//     if (form != null && form.validate()) {
//       form.save();

//       try {
//         String passportBase64 = base64Encode(await passportImage!.readAsBytes());
//         String utilityBillBase64 = base64Encode(await utilityBillImage!.readAsBytes());

//         final Map<String, String> payload = {
//           'email': email,
//           'first_name': firstName,
//           'middlename': middleName,
//           'last_name': lastName,
//           'passport': passportBase64,
//           'utilitybill': utilityBillBase64,
//           'address': address,
//           'city': city,
//           'state': state,
//           'phone_number': phoneNumber,
//           'alternatemobilenumber': alternateMobileNumber,
//           'referalnumber': referralNumber,
//           'accountname': accountName,
//           'accountnumber': accountNumber,
//           'bankname': bankName,
//           'databundlephonenumber': dataBundlePhoneNumber,
//           'yourteam': yourTeam,
//           // 'password': password,
//         };

//         final http.Response response = await http.post(
//           Uri.parse('https://fintecgrate.com/xooxoxo/api/fsasignup.php'),
//           headers: <String, String>{
//             'Content-Type': 'application/json',
//             'x-cors-api-key': 'temp_5cad65143af4adbc1f2df88cd73fe8c6'
//           },
//           body: jsonEncode(payload),
//         );

//         print('Response Status Code: ${response.statusCode}');
//         print('Response Body: ${response.body}');

//         if (response.statusCode == 200) {
//           final Map<String, dynamic> responseBody = jsonDecode(response.body);
//           if (responseBody.containsKey('status') && responseBody['status']) {
//             Navigator.pushReplacementNamed(
//               context,
//               Login.routeName,
//               arguments: {'email': email},
//             );
//           } else if (responseBody.containsKey('message') && !responseBody['status']) {
//             setState(() {
//               errorMessage = responseBody['message'];
//             });
//           } else {
//             setState(() {
//               errorMessage = 'Registration failed. Please try again later.';
//             });
//           }
//         }
//       } catch (error) {
//         setState(() {
//           errorMessage = 'Error registering. Please try again.';
//         });
//         print('Error submitting form: $error');
//       }
//     }
//   }

//   Future<void> _pickPassportImage() async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         passportImage = File(pickedFile.path);
//       });
//     }
//   }

//   Future<void> _pickUtilityBillImage() async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         utilityBillImage = File(pickedFile.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Registration')),
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage(bgImageUrl),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(20.0),
//             child: Form(
//               key: _formKey,
//               child: Stepper(
//                 type: StepperType.vertical,
//                 currentStep: _currentStep,
//                 onStepContinue: _next,
//                 onStepCancel: _prev,
//                 steps: <Step>[
//                   Step(
//                     title: Text('Personal Information'),
//                     content: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         TextFormField(
//                           decoration: const InputDecoration(
//                             labelText: 'Email',
//                             border: OutlineInputBorder(),
//                           ),
//                           keyboardType: TextInputType.emailAddress,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your email';
//                             }
//                             return null;
//                           },
//                           onSaved: (value) => email = value!,
//                         ),
//                         const SizedBox(height: 10.0),
//                         TextFormField(
//                           decoration: const InputDecoration(
//                             labelText: 'First Name',
//                             border: OutlineInputBorder(),
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your first name';
//                             }
//                             return null;
//                           },
//                           onSaved: (value) => firstName = value!,
//                         ),
//                         const SizedBox(height: 10.0),
//                         TextFormField(
//                           decoration: const InputDecoration(
//                             labelText: 'Middle Name',
//                             border: OutlineInputBorder(),
//                           ),
//                           onSaved: (value) => middleName = value!,
//                         ),
//                         const SizedBox(height: 10.0),
//                         TextFormField(
//                           decoration: const InputDecoration(
//                             labelText: 'Last Name',
//                             border: OutlineInputBorder(),
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your last name';
//                             }
//                             return null;
//                           },
//                           onSaved: (value) => lastName = value!,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Step(
//                     title: Text('Address Information'),
//                     content: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         TextFormField(
//                           decoration: const InputDecoration(
//                             labelText: 'Address',
//                             border: OutlineInputBorder(),
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your address';
//                             }
//                             return null;
//                           },
//                           onSaved: (value) => address = value!,
//                         ),
//                         const SizedBox(height: 10.0),
//                         TextFormField(
//                           decoration: const InputDecoration(
//                             labelText: 'City',
//                             border: OutlineInputBorder(),
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your city';
//                             }
//                             return null;
//                           },
//                           onSaved: (value) => city = value!,
//                         ),
//                         const SizedBox(height: 10.0),
//                         TextFormField(
//                           decoration: const InputDecoration(
//                             labelText: 'State',
//                             border: OutlineInputBorder(),
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your state';
//                             }
//                             return null;
//                           },
//                           onSaved: (value) => state = value!,
//                         ),
//                         const SizedBox(height: 10.0),
//                         TextFormField(
//                           decoration: const InputDecoration(
//                             labelText: 'Phone Number',
//                             border: OutlineInputBorder(),
//                           ),
//                           keyboardType: TextInputType.phone,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your phone number';
//                             }
//                             return null;
//                           },
//                           onSaved: (value) => phoneNumber = value!,
//                         ),
//                         const SizedBox(height: 10.0),
//                         TextFormField(
//                           decoration: const InputDecoration(
//                             labelText: 'Alternate Mobile Number',
//                             border: OutlineInputBorder(),
//                           ),
//                           keyboardType: TextInputType.phone,
//                           onSaved: (value) => alternateMobileNumber = value!,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Step(
//                     title: Text('Bank Information'),
//                     content: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         TextFormField(
//                           decoration: const InputDecoration(
//                             labelText: 'Referral Number',
//                             border: OutlineInputBorder(),
//                           ),
//                           onSaved: (value) => referralNumber = value!,
//                         ),
//                         const SizedBox(height: 10.0),
//                         TextFormField(
//                           decoration: const InputDecoration(
//                             labelText: 'Account Name',
//                             border: OutlineInputBorder(),
//                           ),
//                           onSaved: (value) => accountName = value!,
//                         ),
//                         const SizedBox(height: 10.0),
//                         TextFormField(
//                           decoration: const InputDecoration(
//                             labelText: 'Account Number',
//                             border: OutlineInputBorder(),
//                           ),
//                           onSaved: (value) => accountNumber = value!,
//                         ),
//                         const SizedBox(height: 10.0),
//                         TextFormField(
//                           decoration: const InputDecoration(
//                             labelText: 'Bank Name',
//                             border: OutlineInputBorder(),
//                           ),
//                           onSaved: (value) => bankName = value!,
//                         ),
//                         const SizedBox(height: 10.0),
//                         TextFormField(
//                           decoration: const InputDecoration(
//                             labelText: 'Data Bundle Phone Number',
//                             border: OutlineInputBorder(),
//                           ),
//                           keyboardType: TextInputType.phone,
//                           onSaved: (value) => dataBundlePhoneNumber = value!,
//                         ),
//                         const SizedBox(height: 10.0),
//                         TextFormField(
//                           decoration: const InputDecoration(
//                             labelText: 'Your Team',
//                             border: OutlineInputBorder(),
//                           ),
//                           onSaved: (value) => yourTeam = value!,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Step(
//                     title: Text('Images'),
//                     content: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         ElevatedButton(
//                           onPressed: _pickPassportImage,
//                           child: Text(passportImage == null ? 'Pick Passport Image' : 'Change Passport Image'),
//                         ),
//                         const SizedBox(height: 10.0),
//                         ElevatedButton(
//                           onPressed: _pickUtilityBillImage,
//                           child: Text(utilityBillImage == null ? 'Pick Utility Bill Image' : 'Change Utility Bill Image'),
//                         ),
//                         // Display selected images here
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
