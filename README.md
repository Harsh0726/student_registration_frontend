<h3>Instructions on how to run the frontend</h3>

<br>*Before the flutter app run do these changes*<br>

In this <b>Student Registration frontend</b> Flutter project's replace "localhost" with the local IP address of your machine.<br>
For that Update the apiUrl in Flutter app's form.dart file and details.dart file:
<br><br>
ex:<br> <u>In form.dart</u> <br>
final String apiUrl = "http://your_local_ip:8000/api/students/";<br><br>
<u>In details.dart</u><br>
final response = await Dio().get('http://your_local_ip:8000/api/students');
<br><br>
Replace your_local_ip with the actual IP address you found with run 'ipconfig' in a terminal of your machine .</br>

##
</br>

# student_registration_frontend

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
