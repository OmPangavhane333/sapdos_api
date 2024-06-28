import 'package:flutter/material.dart';
import 'package:sapdos/features/data/api/registration_api.dart';
import 'signup_model.dart'; 

class Screen2 extends StatefulWidget {
  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _specializationController = TextEditingController();
  TextEditingController _experienceController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  String _selectedProfile = "Doctor";

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _specializationController.dispose();
    _experienceController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() async {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String age = _ageController.text.trim();
    String phone = _phoneController.text.trim();
    String address = _addressController.text.trim();
    String specialization = _specializationController.text.trim();
    String experience = _experienceController.text.trim();
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Passwords do not match.'),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    RegistrationModel registrationModel = RegistrationModel(
      name: name,
      email: email,
      age: age,
      phone: phone,
      address: address,
      specialization: _selectedProfile == 'Doctor' ? specialization : 'Disease',
      experience: _selectedProfile == 'Doctor' ? int.tryParse(experience) ?? 0 : 0,
      password: password,
    );

    bool success = await postSignup(registrationModel: registrationModel);

    if (success) {
      Navigator.pushNamed(context, '/screen3'); 
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration failed. Please try again.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Color(0xFFE0E7FF),
              child: Center(
                child: Image.asset(
                  'assets/images/rscreen1.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Container(
                padding: EdgeInsets.all(32.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'SAPDOS',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF13235A),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF13235A),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Select your profile',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF13235A),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildProfileOption('Doctor'),
                          SizedBox(width: 16),
                          _buildProfileOption('Patient'),
                        ],
                      ),
                      SizedBox(height: 16),
                      _buildTextField(_nameController, 'Name', Icons.person),
                      SizedBox(height: 16),
                      _buildTextField(_emailController, 'Email', Icons.email),
                      SizedBox(height: 16),
                      _buildTextField(_ageController, 'Age', Icons.cake),
                      SizedBox(height: 16),
                      _buildTextField(_phoneController, 'Phone', Icons.phone),
                      SizedBox(height: 16),
                      _buildTextField(_addressController, 'Address', Icons.location_on),
                      SizedBox(height: 16),
                      _buildTextField(
                          _specializationController,
                          _selectedProfile == 'Doctor' ? 'Specialization' : 'Disease',
                          Icons.work),
                      SizedBox(height: 16),
                      _selectedProfile == 'Doctor'
                          ? _buildTextField(
                              _experienceController, 'Experience', Icons.timeline)
                          : SizedBox(),
                      SizedBox(height: 16),
                      _buildPasswordTextField(
                          _passwordController, 'Password', _isPasswordVisible),
                      SizedBox(height: 16),
                      _buildPasswordTextField(
                          _confirmPasswordController, 'Confirm Password', _isConfirmPasswordVisible),
                      SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: _isSignUpEnabled() ? _register : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF13235A),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text('SIGN-UP'),
                      ),
                      SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login'); // Replace '/login' with your login screen route
                        },
                        child: Text('Already registered? Login here.'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isSignUpEnabled() {
    return _nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _emailController.text.contains('@') &&
        _ageController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _addressController.text.isNotEmpty &&
        _specializationController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty &&
        (_selectedProfile == 'Patient' || _experienceController.text.isNotEmpty) &&
        _passwordController.text == _confirmPasswordController.text;
  }

  Widget _buildTextField(TextEditingController controller, String labelText, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField(
      TextEditingController controller, String labelText, bool isVisible) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              if (controller == _passwordController) {
                _isPasswordVisible = !_isPasswordVisible;
              } else if (controller == _confirmPasswordController) {
                _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
              }
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      obscureText: !isVisible,
    );
  }

  Widget _buildProfileOption(String profile) {
    return ChoiceChip(
      label: Text(profile),
      selected: _selectedProfile == profile,
      onSelected: (selected) {
        setState(() {
          _selectedProfile = profile;
          if (profile == 'Patient') {
            _specializationController.text = 'Disease';
            _experienceController.clear();
          } else {
            _specializationController.clear();
            _experienceController.clear();
          }
        });
      },
      selectedColor: Color(0xFF13235A),
      backgroundColor: Colors.grey[200],
      labelStyle: TextStyle(
        color: _selectedProfile == profile ? Colors.white : Colors.black,
      ),
    );
  }
}

