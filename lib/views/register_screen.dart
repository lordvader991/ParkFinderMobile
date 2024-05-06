import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parkfinder/models/user.dart';
import 'package:parkfinder/services/api_service.dart';
import 'package:parkfinder/services/user_service.dart';
import 'login_screen.dart'; // Suponiendo que tienes una pantalla de inicio de sesión

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    Key? key,
    required this.usernameController,
    required this.roleController,
    required this.firstNameController,
    required this.lastNameController,
    required this.genderController,
    required this.emailController,
    required this.dobController,
    required this.passwordController,
    required this.phoneController,
    required this.countryController,
    required this.cityController,
  }) : super(key: key);

  final TextEditingController usernameController;
  final TextEditingController roleController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController genderController;
  final TextEditingController emailController;
  final TextEditingController dobController;
  final TextEditingController passwordController;
  final TextEditingController phoneController;
  final TextEditingController countryController;
  final TextEditingController cityController;

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  DateTime? _selectedDate;
  String? _selectedRole;
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 60.0),
              const Text(
                "Sign up",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Create your account",
                style: TextStyle(fontSize: 15, color: Colors.grey[700]),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: widget.usernameController,
                decoration: InputDecoration(
                  hintText: "Username",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.purple.withOpacity(0.1),
                  filled: true,
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: widget.emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.purple.withOpacity(0.1),
                  filled: true,
                  prefixIcon: const Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: widget.passwordController,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.purple.withOpacity(0.1),
                  filled: true,
                  prefixIcon: const Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              _buildDropdownWithLabel(
                label: 'Role',
                value: _selectedRole,
                onChanged: (newValue) {
                  setState(() {
                    _selectedRole = newValue;
                    widget.roleController.text = newValue!;
                  });
                },
                items: <String>['admin', 'customer', 'bidder']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: widget.firstNameController,
                decoration: InputDecoration(
                  hintText: "First Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.purple.withOpacity(0.1),
                  filled: true,
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: widget.lastNameController,
                decoration: InputDecoration(
                  hintText: "Last Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.purple.withOpacity(0.1),
                  filled: true,
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 20),
              _buildDropdownWithLabel(
                label: 'Gender',
                value: _selectedGender,
                onChanged: (newValue) {
                  setState(() {
                    _selectedGender = newValue;
                    widget.genderController.text = newValue!;
                  });
                },
                items: <String>['Female', 'Male']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: widget.dobController,
                          decoration: InputDecoration(
                            hintText: "Date of Birth",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: Colors.purple.withOpacity(0.1),
                            filled: true,
                            prefixIcon: const Icon(Icons.calendar_today),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      controller: widget.phoneController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Phone",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.purple.withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.phone),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: widget.countryController,
                      decoration: InputDecoration(
                        hintText: "Country",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.purple.withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.location_on),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      controller: widget.cityController,
                      decoration: InputDecoration(
                        hintText: "City",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.purple.withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.location_city),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Container(
                  padding: const EdgeInsets.only(top: 3, left: 3),
                  child: ElevatedButton(
                    onPressed: () {
                      final signUpData = User(
                        username: widget.usernameController.text,
                        role: widget.roleController.text,
                        firstName: widget.firstNameController.text,
                        lastName: widget.lastNameController.text,
                        gender: widget.genderController.text,
                        dateOfBirth: widget.dobController.text,
                        email: widget.emailController.text,
                        password: widget.passwordController.text,
                        phone: int.tryParse(widget.phoneController.text) ?? 0,
                        country: widget.countryController.text,
                        city: widget.cityController.text,
                      );
                      UserService(ApiService())
                          .registerUser(signUpData as User)
                          .then((_) {
                        print("Guardado correctamente");
                        // Limpiar campos del formulario
                        _clearFormFields();
                        // Navegar de regreso a la pantalla de inicio de sesión
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                LoginPage(), // Suponiendo que tienes una pantalla de inicio de sesión
                          ),
                        );
                      }).catchError((error) {
                        print("Error al guardar: $error");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(error.toString())),
                        );
                      });
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      backgroundColor: Colors.purple,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.purple),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownWithLabel({
    required String label,
    required String? value,
    required Function(String?) onChanged,
    required List<DropdownMenuItem<String>> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButton<String>(
          value: value,
          onChanged: (newValue) {
            onChanged(newValue);
          },
          items: items,
          style: TextStyle(color: Colors.purple),
          underline: Container(
            height: 2,
            color: Colors.purple,
          ),
          dropdownColor: Colors.white,
          isExpanded: true,
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate!);
        widget.dobController.text = formattedDate;
      });
    }
  }

  void _clearFormFields() {
    widget.usernameController.clear();
    widget.roleController.clear();
    widget.firstNameController.clear();
    widget.lastNameController.clear();
    widget.genderController.clear();
    widget.emailController.clear();
    widget.dobController.clear();
    widget.passwordController.clear();
    widget.phoneController.clear();
    widget.countryController.clear();
    widget.cityController.clear();
  }
}
