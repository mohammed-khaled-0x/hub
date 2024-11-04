import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OTPVerificationScreen extends StatelessWidget {
  final String mobileNumber;
  final String firstName;
  final String lastName;
  final String birthDate;
  final String gradeLevel;
  final TextEditingController otpController = TextEditingController();

  OTPVerificationScreen({
    required this.mobileNumber,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.gradeLevel,
  });

  Future<void> saveStudentData() async {
    await FirebaseFirestore.instance.collection('students').add({
      'firstName': firstName,
      'lastName': lastName,
      'birthDate': birthDate,
      'gradeLevel': gradeLevel,
      'mobileNumber': mobileNumber,
      'createdAt': DateTime.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter the OTP sent to $mobileNumber',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            TextField(
              controller: otpController,
              decoration: InputDecoration(labelText: 'OTP Code'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: mobileNumber,
                  smsCode: otpController.text,
                );

                try {
                  await FirebaseAuth.instance.signInWithCredential(credential);
                  await saveStudentData();
                  Navigator.popUntil(context, (route) => route.isFirst);
                } catch (e) {
                  print('Error verifying OTP: $e');
                }
              },
              child: Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}
