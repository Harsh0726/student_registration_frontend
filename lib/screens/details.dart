import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(title: const Text('Registered Students:')),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: FutureBuilder<List<StudentDetails>>(
            future: fetchAllStudentDetails(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Loading indicator while fetching data
              } else if (snapshot.hasError) {
                print('Error: ${snapshot.error}');
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text(
                    'No data found'); // Handle case where data is null or empty
              } else {
                // Display DataTable with fetched data
                return DataTable(
                  columns: const [
                    DataColumn(label: Text("ID")),
                    DataColumn(label: Text("Name")),
                    DataColumn(label: Text("Email address")),
                    DataColumn(label: Text("Phone number")),
                    DataColumn(label: Text("Gender")),
                    DataColumn(label: Text("Date of birth")),
                    DataColumn(label: Text("Address")),
                  ],
                  rows: snapshot.data!.map((student) {
                    return DataRow(cells: [
                      DataCell(Text(student.id.toString())),
                      DataCell(Text(student.name)),
                      DataCell(Text(student.email)),
                      DataCell(Text(student.phoneNumber)),
                      DataCell(Text(student.gender)),
                      DataCell(Text(student.dateOfBirth)),
                      DataCell(Text(student.address)),
                    ]);
                  }).toList(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

Future<List<StudentDetails>> fetchAllStudentDetails() async {

//  in here .get('http://localhost:8000/api/students/') -> replace the localhost with your Local IP Address
  final response = await Dio().get('http://192.168.147.190:8000/api/students');

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON
    Iterable<dynamic> data = response.data;
    List<StudentDetails> studentList =
        data.map((json) => StudentDetails.fromJson(json)).toList();
    return studentList;
  } else {
    // If the server did not return a 200 OK response, throw an exception.
    throw Exception('Failed to load student details');
  }
}

class StudentDetails {
  final int id;
  final String name;
  final String email;
  final String phoneNumber;
  final String gender;
  final String dateOfBirth;
  final String address;

  StudentDetails({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.dateOfBirth,
    required this.address,
  });

  factory StudentDetails.fromJson(Map<String, dynamic> json) {
    return StudentDetails(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      gender: json['gender'],
      dateOfBirth: json['date_of_birth'],
      address: json['address'],
    );
  }
}
