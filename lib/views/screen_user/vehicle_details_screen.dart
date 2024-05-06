import 'package:flutter/material.dart';
import 'package:parkfinder/models/cars.dart';
import 'package:parkfinder/services/car_service.dart';
import 'package:parkfinder/services/token_provider.dart';
import 'package:provider/provider.dart';
import 'package:parkfinder/models/cars_extension.dart';

class VehicleDetails extends StatefulWidget {
  final String vehicleId;

  const VehicleDetails({Key? key, required this.vehicleId}) : super(key: key);

  @override
  _VehicleDetailsState createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  final VehicleService _vehicleService = VehicleService();
  late Cars _vehicleDetails = Cars(
    brand: '',
    model: '',
    year: 0,
    color: '',
    dimensions: Dimensions(height: 0, width: 0, length: 0),
    numberPlate: '',
    userId: '',
  );

  late TextEditingController _brandController;
  late TextEditingController _modelController;
  late TextEditingController _yearController;
  late TextEditingController _colorController;
  late TextEditingController _heightController;
  late TextEditingController _widthController;
  late TextEditingController _lengthController;
  late TextEditingController _numberPlateController;

  late Cars _originalVehicleDetails;

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _fetchVehicleDetails();
    _brandController = TextEditingController();
    _modelController = TextEditingController();
    _yearController = TextEditingController();
    _colorController = TextEditingController();
    _heightController = TextEditingController();
    _widthController = TextEditingController();
    _lengthController = TextEditingController();
    _numberPlateController = TextEditingController();
  }

  @override
  void dispose() {
    _brandController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _colorController.dispose();
    _heightController.dispose();
    _widthController.dispose();
    _lengthController.dispose();
    _numberPlateController.dispose();
    super.dispose();
  }

  Future<void> _fetchVehicleDetails() async {
    try {
      String? token = Provider.of<TokenProvider>(context, listen: false).token;
      if (token != null) {
        Cars vehicleDetails =
            await _vehicleService.getVehicleById(widget.vehicleId, token);
        setState(() {
          _vehicleDetails = vehicleDetails;
          _originalVehicleDetails = vehicleDetails;
          _brandController.text = _vehicleDetails.brand;
          _modelController.text = _vehicleDetails.model;
          _yearController.text = _vehicleDetails.year.toString();
          _colorController.text = _vehicleDetails.color;
          _heightController.text = _vehicleDetails.dimensions.height.toString();
          _widthController.text = _vehicleDetails.dimensions.width.toString();
          _lengthController.text = _vehicleDetails.dimensions.length.toString();
          _numberPlateController.text = _vehicleDetails.numberPlate;
        });
        print('Vehicle ID: ${widget.vehicleId}');
        print('Token: $token');
      } else {
        print('Token is null');
      }
    } catch (error) {
      print('Error fetching vehicle details: $error');
    }
  }

  void _cancelEditing() {
    setState(() {
      _isEditing = false;
      _brandController.text = _originalVehicleDetails.brand;
      _modelController.text = _originalVehicleDetails.model;
      _yearController.text = _originalVehicleDetails.year.toString();
      _colorController.text = _originalVehicleDetails.color;
      _heightController.text =
          _originalVehicleDetails.dimensions.height.toString();
      _widthController.text =
          _originalVehicleDetails.dimensions.width.toString();
      _lengthController.text =
          _originalVehicleDetails.dimensions.length.toString();
      _numberPlateController.text = _originalVehicleDetails.numberPlate;
    });
  }

  Future<void> _updateVehicle() async {
    try {
      String? token = Provider.of<TokenProvider>(context, listen: false).token;
      if (token != null) {
        Cars updatedVehicle = Cars(
          id: _vehicleDetails.id,
          userId: _vehicleDetails.userId,
          brand: _brandController.text,
          model: _modelController.text,
          year: int.parse(_yearController.text),
          color: _colorController.text,
          dimensions: Dimensions(
            height: int.parse(_heightController.text),
            width: int.parse(_widthController.text),
            length: int.parse(_lengthController.text),
          ),
          numberPlate: _numberPlateController.text,
        );

        await _vehicleService.updateVehicle(
            updatedVehicle.id!, updatedVehicle.toJson(), token);

        setState(() {
          _vehicleDetails = updatedVehicle;
          _isEditing = false;
        });
      } else {
        print('Token is null');
      }
    } catch (error) {
      print('Error updating vehicle details: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildDetailRow('Brand', _brandController),
            _buildDetailRow('Model', _modelController),
            _buildDetailRow('Year', _yearController),
            _buildDetailRow('Color', _colorController),
            _buildDetailRow('Height', _heightController),
            _buildDetailRow('Width', _widthController),
            _buildDetailRow('Length', _lengthController),
            _buildDetailRow('Number Plate', _numberPlateController),
            SizedBox(height: 20),
            _isEditing ? _buildActionButtons() : _buildEditButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          _isEditing
              ? TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                )
              : Text(
                  controller.text,
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
        ],
      ),
    );
  }

  Widget _buildEditButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () => setState(() => _isEditing = true),
        child: Text('Edit Details'),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: _updateVehicle,
          child: Text('Save Changes'),
        ),
        ElevatedButton(
          onPressed: _cancelEditing,
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
