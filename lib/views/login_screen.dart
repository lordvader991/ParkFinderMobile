import 'package:flutter/material.dart';
import 'package:parkfinder/views/register_screen.dart';
import 'package:parkfinder/views/screen_user/navigation_bar.dart';

class LoginPage extends StatelessWidget {

LoginPage({super.key});
 final TextEditingController usernameController = TextEditingController();
 final TextEditingController passwordController = TextEditingController();
 final TextEditingController roleController = TextEditingController();
 final TextEditingController firstNameController = TextEditingController();
 final TextEditingController lastNameController = TextEditingController();
 final TextEditingController genderController = TextEditingController();
 final TextEditingController dobController = TextEditingController();
 final TextEditingController emailController = TextEditingController();
 final TextEditingController phoneController = TextEditingController();
 final TextEditingController countryController = TextEditingController();
 final TextEditingController cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
              _forgotPassword(context),
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return const Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Enter your credential to login"),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          decoration: InputDecoration(
              hintText: "Email",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Colors.purple.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.person)),
        ),
        const SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: Colors.purple.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.password),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NavigationBarScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.purple,
          ),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        )
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        "Forgot password?",
        style: TextStyle(color: Colors.purple),
      ),
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Dont have an account? "),
        TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  RegisterScreen(
                    usernameController: usernameController,
                    roleController: roleController,
                    firstNameController: firstNameController,
                    lastNameController: lastNameController,
                    genderController: genderController,
                    dobController: dobController,
                    emailController: emailController,
                    passwordController: passwordController,
                    phoneController: phoneController,
                    countryController: countryController,
                    cityController: cityController,
                )),
              );
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(color: Colors.purple),
            ))
      ],
    );
  }
}
