import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;
  String _username = 'john_doe';
  String _name = 'John';
  String _lastName = 'Doe';
  String _phone = '123-456-7890';
  String _email = 'john.doe@example.com';

  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = _name;
    _lastNameController.text = _lastName;
    _phoneController.text = _phone;
    _emailController.text = _email;
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
                '$_username',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text('Nombre'),
              subtitle: _isEditing
                  ? _buildEditableField(_nameController)
                  : Text(_name),
            ),
            ListTile(
              title: Text('Apellido'),
              subtitle: _isEditing
                  ? _buildEditableField(_lastNameController)
                  : Text(_lastName),
            ),
            ListTile(
              title: Text('Teléfono'),
              subtitle: _isEditing
                  ? _buildEditableField(_phoneController)
                  : Text(_phone),
            ),
            ListTile(
              title: Text('Email'),
              subtitle: _isEditing
                  ? _buildEditableField(_emailController)
                  : Text(_email),
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
                    // Aquí deberías manejar el logout
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

  Widget _buildEditableField(TextEditingController controller) {
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

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
