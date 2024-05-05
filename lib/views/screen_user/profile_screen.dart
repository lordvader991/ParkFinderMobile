import 'package:flutter/material.dart';
import 'package:parkfinder/services/api_service.dart';
import 'package:parkfinder/views/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:parkfinder/services/token_provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? _userData;
  bool _isEditing = false;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    String? authToken =
        Provider.of<TokenProvider>(context, listen: false).token;
    _fetchUserData(authToken);
  }

  Future<void> _fetchUserData(String? token) async {
    if (token != null) {
      print('Token recibido: $token'); // Imprimir el token recibido
      try {
        final userData = await ApiService().getUserData(token);
        setState(() {
          _userData = userData["data"];
        });
      } catch (e) {
        print('Error fetching user data: $e');
      }
    } else {
      print('Token es nulo'); // Manejo del caso en que el token sea nulo
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                _userData?['username'] ?? '',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text('Nombre'),
              subtitle: _isEditing
                  ? _buildEditableField(
                      _nameController, _userData?['first_name'])
                  : Text(_userData?['first_name'] ?? ''),
            ),
            ListTile(
              title: Text('Apellido'),
              subtitle: _isEditing
                  ? _buildEditableField(
                      _lastNameController, _userData?['last_name'])
                  : Text(_userData?['last_name'] ?? ''),
            ),
            ListTile(
              title: Text('Teléfono'),
              subtitle: _isEditing
                  ? _buildEditableField(_phoneController, _userData?['phone'])
                  : Text(_userData?['phone']?.toString() ?? ''),
            ),
            ListTile(
              title: Text('Email'),
              subtitle: _isEditing
                  ? _buildEditableField(_emailController, _userData?['email'])
                  : Text(_userData?['email'] ?? ''),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isEditing = !_isEditing;
                    });
                  },
                  child: Text(_isEditing ? 'Guardar' : 'Editar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _logoutUser();
                  },
                  child: Text('Log Out'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField(
      TextEditingController controller, String? initialValue) {
    controller.text = initialValue ?? '';
    return Container(
      width: 200,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  void _logoutUser() {
    ApiService().logoutUser().then((response) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Logout Successful"),
          content: Text(response["data"]["message"]),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
      Provider.of<TokenProvider>(context, listen: false).clearToken();
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text("Failed to logout. Please try again."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
