import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class FSAForm extends StatefulWidget {
  const FSAForm({Key? key}) : super(key: key);
  static const routeName = '/fsa-form';

  @override
  _FSAFormState createState() => _FSAFormState();
}

class _FSAFormState extends State<FSAForm> {
  final _formKey = GlobalKey<FormState>();
  bool isSubmitting = false;
  String bgImageUrl = "assets/images/backgrounds/bg.png";
  String? name;
  String? contactAddress;
  String? mobile;
  String? remark;
  String? businessType;
  String? agreeToEnroll;
  String? virtualAccount;
  String? merchantBusinessName;
  DateTime? dateCreated;
  Position? currentPosition;

  String errorMessage = '';

  String fsaemail = '';

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Retrieve the email passed from the Login screen
    final Map<String, String>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
    if (args != null) {
      // Set the email value if it exists
      setState(() {
        fsaemail = args['email'] ?? '';
      });
    }

    _getCurrentLocation();
  }

  Future<void> _requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        currentPosition = position;
      });
    } catch (e) {
      // print("Error: $e");
    }
  }

  void handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isSubmitting = true;
      });

      // Construct the payload
      final Map<String, dynamic> payload = {
        'fsaphonenumber': '12345',
        'fsaemail': fsaemail,
        'name': name,
        'contactAddress': contactAddress,
        'mobile': mobile,
        'remark': remark,
        'businessType': businessType,
        'agreeToEnroll': agreeToEnroll,
        'virtualAccount': virtualAccount,
        'merchantBusinessName': merchantBusinessName,
        'dateCreated': dateCreated!.toIso8601String(),
        'currentPosition': currentPosition.toString(),
      };

      try {
        // Send the data to the endpoint
        final http.Response response = await http.post(
          Uri.parse(
              // 'https://proxy.cors.sh/https://fintecgrate.com/xooxoxo/api/fsarport.php'),
              'https://fintecgrate.com/xooxoxo/api/fsarport.php'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-cors-api-key': 'temp_5cad65143af4adbc1f2df88cd73fe8c6'
          },
          body: jsonEncode(payload),
        );

        if (response.statusCode == 200) {
          // Parse the response body
          final Map<String, dynamic> responseBody = jsonDecode(response.body);

          if (responseBody.containsKey('status') &&
              responseBody['status'] == true) {
            // If form successfully submitted, do something
            // print(responseBody['status']);
            // print(responseBody['message']);
          } else if (responseBody['status'] == false) {
            // If failed, display error message
            // print(responseBody['status']);
            // print(responseBody['message']);

            setState(() {
              errorMessage = responseBody['message'];
            });
          } else {
            // If status is not true and no message is returned, display a generic error message
            setState(() {
              errorMessage = 'Invalid email or password. Please try again.';
            });
          }

          // Reset the form
          _formKey.currentState!.reset();
          setState(() {
            isSubmitting = false;
          });
        } else {
          // Handle HTTP error
          setState(() {
            isSubmitting = false;
          });
        }
      } catch (error) {
        // Handle network or other errors
        setState(() {
          isSubmitting = false;
        });
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateCreated) {
      setState(() {
        dateCreated = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bgImageUrl),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'FSA Report',
                          style: TextStyle(
                              fontSize: 30,
                              color: Color.fromARGB(255, 59, 59, 59),
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Name/Business Name',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name/business name';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Contact Address',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your contact address';
                            }
                            return null;
                          },
                          maxLines: null,
                          onChanged: (value) {
                            setState(() {
                              contactAddress = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Mobile',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your mobile number';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                          onChanged: (value) {
                            setState(() {
                              mobile = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16.0),
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Remark',
                            border: OutlineInputBorder(),
                          ),
                          isExpanded: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a remark';
                            }
                            return null;
                          },
                          items: const [
                            DropdownMenuItem(
                              value:
                                  'Interested but App is not on Apple Store (iPhone User)',
                              child: Text(
                                  'Interested but App is not on Apple Store (iPhone User)'),
                            ),
                            DropdownMenuItem(
                              value:
                                  'Interested but does not have an Android Phone',
                              child: Text(
                                  'Interested but does not have an Android Phone'),
                            ),
                            DropdownMenuItem(
                              value:
                                  'Interested but facing Bank issues (Invalid Account)',
                              child: Text(
                                  'Interested but facing Bank issues (Invalid Account)'),
                            ),
                            DropdownMenuItem(
                              value:
                                  'Interested but facing issues with BVN Phone Number',
                              child: Text(
                                  'Interested but facing issues with BVN Phone Number'),
                            ),
                            DropdownMenuItem(
                              value:
                                  'Interested but needs time or further consideration',
                              child: Text(
                                  'Interested but needs time or further consideration'),
                            ),
                            DropdownMenuItem(
                              value: 'Interested but OTP was not received',
                              child:
                                  Text('Interested but OTP was not received'),
                            ),
                            DropdownMenuItem(
                              value:
                                  'Interested but afraid of fraud and scamming App',
                              child: Text(
                                  'Interested but afraid of fraud and scamming App'),
                            ),
                            DropdownMenuItem(
                              value:
                                  'Interested but the Boss is not available, Pls come back later',
                              child: Text(
                                  'Interested but the Boss is not available, Pls come back later'),
                            ),
                            DropdownMenuItem(
                              value:
                                  'Interested but busy now, check back later for a Sign-up',
                              child: Text(
                                  'Interested but busy now, check back later for a Sign-up'),
                            ),
                            DropdownMenuItem(
                              value:
                                  'Interested but refused to provide BVN for Signup',
                              child: Text(
                                  'Interested but refused to provide BVN for Signup'),
                            ),
                            DropdownMenuItem(
                              value:
                                  'Interested but the Merchant wants to do more research about the company and App',
                              child: Text(
                                  'Interested but the Merchant wants to do more research about the company and App'),
                            ),
                            DropdownMenuItem(
                              value: "Not interested - I don't need it",
                              child: Text("Not interested - I don't need it"),
                            ),
                            DropdownMenuItem(
                              value: "Not interested - I don't trust your App",
                              child: Text(
                                  "Not interested - I don't trust your App"),
                            ),
                            DropdownMenuItem(
                              value: "Not interested - I have Moniepoint",
                              child: Text("Not interested - I have Moniepoint"),
                            ),
                            DropdownMenuItem(
                              value: 'Successful enrolment',
                              child: Text('Successful enrolment'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              remark = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16.0),
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Merchant Business Type',
                            border: OutlineInputBorder(),
                          ),
                          isExpanded: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a business type';
                            }
                            return null;
                          },
                          items: const [
                            DropdownMenuItem(
                              value: 'POS Agents',
                              child: Text('POS Agents'),
                            ),
                            DropdownMenuItem(
                              value: 'Neighborhood Provision Shops',
                              child: Text('Neighborhood Provision Shops'),
                            ),
                            DropdownMenuItem(
                              value: 'Small & Medium Supermarkets',
                              child: Text('Small & Medium Supermarkets'),
                            ),
                            DropdownMenuItem(
                              value: 'Bukateria or Mamaput',
                              child: Text('Bukateria or Mamaput'),
                            ),
                            DropdownMenuItem(
                              value: 'Fast-Food Outlets',
                              child: Text('Fast-Food Outlets'),
                            ),
                            DropdownMenuItem(
                              value: 'Church or other religious org',
                              child: Text('Church or other religious org'),
                            ),
                            DropdownMenuItem(
                              value: 'Schools',
                              child: Text('Schools'),
                            ),
                            DropdownMenuItem(
                              value: 'Hotels',
                              child: Text('Hotels'),
                            ),
                            DropdownMenuItem(
                              value: 'Fashion Stores/Boutiques/Salons',
                              child: Text('Fashion Stores/Boutiques/Salons'),
                            ),
                            DropdownMenuItem(
                              value: 'Spare Parts dealer',
                              child: Text('Spare Parts dealer'),
                            ),
                            DropdownMenuItem(
                              value: 'Home Electronics Dealers',
                              child: Text('Home Electronics Dealers'),
                            ),
                            DropdownMenuItem(
                              value: 'Computer & Mobile Phone Shops',
                              child: Text('Computer & Mobile Phone Shops'),
                            ),
                            DropdownMenuItem(
                              value: 'Online products & services owners',
                              child: Text('Online products & services owners'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              businessType = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16.0),
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Did the Merchant Agree to Enroll?',
                            border: OutlineInputBorder(),
                          ),
                          isExpanded: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select an option';
                            }
                            return null;
                          },
                          items: const [
                            DropdownMenuItem(
                              value: 'Yes',
                              child: Text('Yes'),
                            ),
                            DropdownMenuItem(
                              value: 'No',
                              child: Text('No'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              agreeToEnroll = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText:
                                'Merchant Virtual Account Number Created',
                            border: OutlineInputBorder(),
                          ),
                          enabled: agreeToEnroll == 'Yes',
                          keyboardType: TextInputType.phone,
                          onChanged: (value) {
                            setState(() {
                              virtualAccount = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Merchant Business Name',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the merchant business name';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              merchantBusinessName = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(color: Colors.blue),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 20.0,
                              )),
                          onPressed: () =>
                              _selectDate(context), // Add this line
                          child: Text(
                            dateCreated == null
                                ? 'Select Date Created'
                                : 'Date Created: ${dateCreated!.toString().split(' ')[0]}',
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(color: Colors.blue),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 30.0,
                              )),
                          onPressed: isSubmitting ? null : handleSubmit,
                          child: isSubmitting
                              ? const CircularProgressIndicator()
                              : const Text('Submit'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
