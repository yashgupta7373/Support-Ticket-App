import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/colors.dart';
import '../widgets/custom_icon_button.dart';
import '../widgets/custom_text_form_field.dart';

class RaiseTicketScreen extends StatefulWidget {
  const RaiseTicketScreen({super.key});

  @override
  State<RaiseTicketScreen> createState() => _RaiseTicketScreenState();
}

class _RaiseTicketScreenState extends State<RaiseTicketScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _transactionIdController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  String? _selectedCategory;
  File? _selectedImage;
  final List<String> categories = ["Payment Issue", "Refund", "Login Issue", "Other"];
  final ImagePicker _picker = ImagePicker();

  // Pick or click image
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // handle submit ticket button
  void _handleSubmitTicketButton(){
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Ticket Submitted Successfully!"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Raise New Ticket",
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: IconThemeData(color: AppColors.textPrimary),
        backgroundColor: AppColors.primary,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  controller: _transactionIdController,
                  label: "Transaction ID",
                  hint: "Enter transaction ID",
                  icon: Icons.confirmation_number,
                  validator: (value) =>
                  value == null || value.isEmpty ? "Please enter transaction ID" : null,
                ),
                const SizedBox(height: 20),

                // Category dropdown
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  items: categories
                      .map((cat) =>
                      DropdownMenuItem(value: cat, child: Text(cat)))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedCategory = val;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Category",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) =>
                  value == null ? "Please select a category" : null,
                ),
                const SizedBox(height: 20),

                // Description
                CustomTextFormField(
                  controller: _descriptionController,
                  label: "Description",
                  hint: "Enter description",
                  maxLines: 4, // supports multiline
                  validator: (value) =>
                  value == null || value.isEmpty ? "Please enter description" : null,
                ),
                const SizedBox(height: 20),

                // Upload Screenshot
                Text(
                  "Upload Screenshot:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.primary),
                ),
                const SizedBox(height: 10),

                Row(
                  children: [
                    CustomIconButton(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      icon: Icons.image,
                      label: "Gallery",
                    ),
                    const SizedBox(width: 15),
                    CustomIconButton(
                      onPressed: () => _pickImage(ImageSource.camera),
                      icon: Icons.camera_alt,
                      label: "Camera",
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                // show SS if selected
                if (_selectedImage != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      _selectedImage!,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(height: 30),

                // Submit Button
                Center(
                  child: CustomIconButton(
                    onPressed: _handleSubmitTicketButton,
                    label: "Submit Ticket",
                    backgroundColor: const Color(0xFF874ECF),
                    textColor: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
