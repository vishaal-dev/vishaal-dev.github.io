import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vishal_portfolio/app_theme.dart';
import 'package:vishal_portfolio/controllers/form_controller.dart';
import 'package:vishal_portfolio/widgets/custom_button.dart';

class ContactForm extends StatelessWidget {
  const ContactForm({super.key});

  @override
  Widget build(BuildContext context) {
    final FormController formController = Get.find<FormController>();
    
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Obx(() {
          if (formController.isSubmitted.value) {
            return _buildSuccessMessage(context, formController);
          } else {
            return _buildForm(context, formController);
          }
        }),
      ),
    );
  }
  
  Widget _buildForm(BuildContext context, FormController controller) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Form Title
          Text(
            'Send Me a Message',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          
          // Name Field
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Name',
              hintText: 'Enter your name',
              prefixIcon: const Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            validator: controller.validateName,
            onSaved: (value) => controller.name.value = value ?? '',
          ),
          const SizedBox(height: 16),
          
          // Email Field
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your email',
              prefixIcon: const Icon(Icons.email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            validator: controller.validateEmail,
            onSaved: (value) => controller.email.value = value ?? '',
          ),
          const SizedBox(height: 16),
          
          // Message Field
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Message',
              hintText: 'Enter your message',
              prefixIcon: const Icon(Icons.message),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            maxLines: 5,
            validator: controller.validateMessage,
            onSaved: (value) => controller.message.value = value ?? '',
          ),
          const SizedBox(height: 24),
          
          // Submit Button
          Obx(() => controller.isSubmitting.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : CustomButton(
                text: 'Send Message',
                onPressed: controller.submitForm,
                icon: Icons.send,
                isFullWidth: true,
              ),
          ),
          
          // Error Message
          Obx(() => controller.hasError.value
            ? Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  controller.errorMessage.value,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSuccessMessage(BuildContext context, FormController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 64,
        ),
        const SizedBox(height: 16),
        Text(
          'Message Sent Successfully!',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Thank you for reaching out. I will get back to you as soon as possible.',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        CustomButton(
          text: 'Send Another Message',
          onPressed: controller.resetForm,
          isOutlined: true,
        ),
      ],
    );
  }
}
