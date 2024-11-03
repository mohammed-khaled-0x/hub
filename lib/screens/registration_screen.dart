import 'package:flutter/material.dart';
import 'otp_verification_screen.dart';

class RegistrationScreen extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController gradeLevelController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: birthDateController,
                decoration:
                    InputDecoration(labelText: 'Date of Birth (DD/MM/YYYY)'),
                keyboardType: TextInputType.datetime,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Grade Level'),
                items: ['Preparatory', 'Secondary']
                    .map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                    .toList(),
                onChanged: (value) {
                  gradeLevelController.text = value ?? '';
                },
              ),
              SizedBox(height: 16),
              TextField(
                controller: mobileController,
                decoration: InputDecoration(labelText: 'Student Mobile Number'),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OTPVerificationScreen(
                        mobileNumber: mobileController.text,
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        birthDate: birthDateController.text,
                        gradeLevel: gradeLevelController.text,
                      ),
                    ),
                  );
                },
                child: Text('Register'),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Already have an account? Log in'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
