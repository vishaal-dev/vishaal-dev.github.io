import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormController extends GetxController {
  // Form key for validation
  final formKey = GlobalKey<FormState>();
  
  // Form fields
  final RxString name = ''.obs;
  final RxString email = ''.obs;
  final RxString message = ''.obs;
  
  // Form state
  final RxBool isSubmitting = false.obs;
  final RxBool isSubmitted = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  
  // Validate email format
  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegExp.hasMatch(email);
  }
  
  // Validate form fields
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }
  
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!isValidEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }
  
  String? validateMessage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your message';
    }
    return null;
  }
  
  // Submit form
  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      
      isSubmitting.value = true;
      hasError.value = false;
      errorMessage.value = '';
      
      try {
        // Simulate API call with delay
        await Future.delayed(const Duration(seconds: 2));
        
        // In a real app, you would send the form data to a backend service here
        // For now, we'll just simulate a successful submission
        isSubmitted.value = true;
        
        // Reset form after successful submission
        formKey.currentState!.reset();
        name.value = '';
        email.value = '';
        message.value = '';
      } catch (e) {
        hasError.value = true;
        errorMessage.value = 'An error occurred. Please try again.';
      } finally {
        isSubmitting.value = false;
      }
    }
  }
  
  // Reset form state
  void resetForm() {
    isSubmitted.value = false;
    hasError.value = false;
    errorMessage.value = '';
  }
}
