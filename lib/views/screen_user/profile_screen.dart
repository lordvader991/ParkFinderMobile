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
          // Llenar los controladores de texto con los datos actuales del usuario
          _nameController.text = _userData?['first_name'] ?? '';
          _lastNameController.text = _userData?['last_name'] ?? '';
          _phoneController.text = _userData?['phone']?.toString() ?? '';
          _emailController.text = _userData?['email'] ?? '';
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
        title: Text('My profile'),
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
              title: Text('Name'),
              subtitle: _isEditing
                  ? _buildEditableField(_nameController)
                  : Text(_userData?['first_name'] ?? ''),
            ),
            ListTile(
              title: Text('Last Name'),
              subtitle: _isEditing
                  ? _buildEditableField(_lastNameController)
                  : Text(_userData?['last_name'] ?? ''),
            ),
            ListTile(
              title: Text('Phone'),
              subtitle: _isEditing
                  ? _buildEditableField(_phoneController)
                  : Text(_userData?['phone']?.toString() ?? ''),
            ),
            ListTile(
              title: Text('Email'),
              subtitle: Text(_userData?['email'] ?? ''),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isEditing = !_isEditing;
                      });
                    },
                    child: Text(_isEditing ? 'Cancel' : 'Edit'),
                  ),
                ),
                if (_isEditing)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _saveChanges();
                      },
                      child: Text('Save Changes'),
                    ),
                  ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _logoutUser();
                    },
                    child: Text('Log Out'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField(TextEditingController controller) {
    return Container(
      width: 200,
      child: TextField(
        controller: controller,
        enabled: _isEditing,
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

  Future<void> _saveChanges() async {
    final token =
        Provider.of<TokenProvider>(context, listen: false).token ?? '';
    final updatedUserData = {
      'first_name': _nameController.text,
      'last_name': _lastNameController.text,
      'phone': _phoneController.text,
    };

    try {
      await ApiService().updateUser(token, updatedUserData);
      setState(() {
        _isEditing =
            false; // Deshabilitar el modo de edición después de guardar
      });
      // Mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saved changes successfully')),
      );
    } catch (e) {
      print('Error al guardar cambios: $e');
      // Mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving changes. Please try again.')),
      );
    }
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
