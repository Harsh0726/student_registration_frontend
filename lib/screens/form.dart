import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class StudentForm extends StatefulWidget {
  const StudentForm({Key? key}) : super(key: key);

  @override
  State<StudentForm> createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

//  final String apiUrl = "http://localhost:8000/api/students/"; 
//  in here replace the localhost with your Local IP Address

  final String apiUrl = "http://192.168.8.100:8000/api/students/";

  Dio dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Student Registration Form'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // name field
                buildTextField(
                  controller: _nameController,
                  hintText: 'Student name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the student name';
                    }
                    return null;
                  },
                ),
                // email field
                buildTextField(
                  controller: _emailController,
                  hintText: 'Email address',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the email address';
                    } else if (!RegExp(
                            r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                // contact number field
                buildTextField(
                  controller: _contactController,
                  hintText: 'Contact Number',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the student\'s contact number';
                    } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      return 'Please enter a valid 10-digit contact number';
                    }
                    return null;
                  },
                ),
                // gender field
                buildTextField(
                  controller: _genderController,
                  hintText: 'Gender',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter female/male/other';
                    }
                    return null;
                  },
                ),
                // date of birth field with date picker
                buildDatePickerField(
                  controller: _dobController,
                  hintText: 'Date of Birth',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter date of birth';
                    }
                    return null;
                  },
                ),
                // address field
                buildTextField(
                  controller: _addressController,
                  hintText: 'Address',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the student\'s address';
                    }
                    return null;
                  },
                ),
                // submit btn
                SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // submit actions
                        submitForm();
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submitForm() async {
    try {
      Map<String, dynamic> data = {
        "name": _nameController.text,
        "email": _emailController.text,
        "phone_number": _contactController.text,
        "gender": _genderController.text,
        "date_of_birth": _dobController.text,
        "address": _addressController.text,
      };

      // post request
      Response response = await dio.post(apiUrl, data: data);

      // check request success
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Student registered successfully'),
          duration: Duration(seconds: 2),
        ));

        // clear form
        _formKey.currentState!.reset();
      } else {
        // Display  error message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to create student. Please try again'),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An unexpected error occured. Please try again.'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: hintText,
        ),
        validator: validator,
      ),
    );
  }

  Widget buildDatePickerField({
    required TextEditingController controller,
    required String hintText,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (pickedDate != null) {
            controller.text = pickedDate.toLocal().toString().split(' ')[0];
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: hintText,
        ),
        validator: validator,
      ),
    );
  }
}
