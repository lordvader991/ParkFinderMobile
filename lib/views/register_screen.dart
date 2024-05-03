import 'package:flutter/material.dart';
import 'package:parkfinder/models/signup.dart';
import 'package:parkfinder/services/register.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({
    Key? key,
    required this.usernameController,
    required this.roleController,
    required this.firstNameController,
    required this.lastNameController,
    required this.genderController,
    required this.dobController,
    required this.emailController,
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
  final TextEditingController dobController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController phoneController;
  final TextEditingController countryController;
  final TextEditingController cityController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: ListView(
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
                  controller: usernameController,
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
                  controller: roleController,
                  decoration: InputDecoration(
                    hintText: "Role",
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
                  controller: firstNameController,
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
                  controller: lastNameController,
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
                TextField(
                  controller: genderController,
                  decoration: InputDecoration(
                    hintText: "Gender",
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
                  controller: dobController,
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
                const SizedBox(height: 20),
                TextField(
                  controller: emailController,
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
                  controller: passwordController,
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
                TextField(
                  controller: phoneController,
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
                const SizedBox(height: 20),
                TextField(
                  controller: countryController,
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
                const SizedBox(height: 20),
                TextField(
                  controller: cityController,
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
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(top: 3, left: 3),
                  child: ElevatedButton(
                    onPressed: () {
                      final signUpData = SignUpData(
                        username: usernameController.text,
                        role: roleController.text,
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        gender: genderController.text,
                        dateOfBirth: dobController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        phone: phoneController.text,
                        country: countryController.text,
                        city: cityController.text,
                      );
                      ApiHandler.signUp(signUpData.toJson()).then((response) {
                        // Manejar la respuesta de la API aquí
                      }).catchError((error) {
                        // Manejar errores aquí
                      });
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.purple,
                    ),
                  ),
                ),
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
      ),
    );
  }
}
