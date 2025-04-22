import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'support.dart';
import 'profile.dart';
import 'auth_screen.dart'; // Import the AuthScreen

class SensorDashboard extends StatefulWidget {
  @override
  _SensorDashboardState createState() => _SensorDashboardState();
}

class _SensorDashboardState extends State<SensorDashboard> {
  late DatabaseReference _sensorRef;
  Map<String, dynamic> _sensorData = {
    'temperature': 0.0,
    'humidity': 0.0,
    'distance': 0,
    'soil_moisture': 0,
  };

  @override
  void initState() {
    super.initState();
    _setupFirebase();
  }

  void _setupFirebase() {
    _sensorRef = FirebaseDatabase.instance.reference().child('sensors');
    _sensorRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        final data = Map<String, dynamic>.from(event.snapshot.value as dynamic);
        setState(() {
          _sensorData = {
            'temperature': data['temperature']?.toDouble() ?? 0.0,
            'humidity': data['humidity']?.toDouble() ?? 0.0,
            'distance': data['distance'] ?? 0,
            'soil_moisture': data['soil_moisture'] ?? 0,
          };
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F3460),
      appBar: AppBar(
        title: Text('Smart Farming Dashboard'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Color(0xFF1A1A2E),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green, Colors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.help_outline, color: Colors.white),
                title: Text(
                  'Help & Support',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HelpSupportPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.person, color: Colors.white),
                title: Text(
                  'Profile',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DeveloperProfile()),
                  );
                },
              ),
              Divider(color: Colors.white.withOpacity(0.3)),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.white),
                title: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A1A2E),
              Color(0xFF16213E),
              Color(0xFF0F3460),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildSensorCard(
                      'Temperature',
                      '${_sensorData['temperature'].toStringAsFixed(1)}°C',
                      Icons.thermostat,
                      Colors.orange[200]!,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildSensorCard(
                      'Humidity',
                      '${_sensorData['humidity'].toStringAsFixed(1)}%',
                      Icons.water_drop,
                      Colors.blue[200]!,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              _buildDistanceCard(_sensorData['distance']),
              SizedBox(height: 16),
              _buildSoilMoistureCard(_sensorData['soil_moisture']),
              SizedBox(height: 16),
              _buildStatusIndicator(_sensorData['soil_moisture']),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSensorCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Color(0xFF1E1E2E).withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, size: 40, color: color),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDistanceCard(int distance) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Color(0xFF1E1E2E).withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.straighten, size: 40, color: Colors.purple[200]),
                SizedBox(width: 10),
                Text(
                  'Distance',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              '$distance cm',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.purple[200],
              ),
            ),
            SizedBox(height: 10),
            LinearProgressIndicator(
              value: distance / 200,
              backgroundColor: Colors.grey[800],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.purple[200]!),
              minHeight: 10,
              borderRadius: BorderRadius.circular(5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSoilMoistureCard(int moisture) {
    Color moistureColor = moisture > 70
        ? Colors.green[300]!
        : moisture > 30
        ? Colors.orange[300]!
        : Colors.red[300]!;

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Color(0xFF1E1E2E).withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.grass, size: 40, color: moistureColor),
                SizedBox(width: 10),
                Text(
                  'Soil Moisture',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              '$moisture%',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: moistureColor,
              ),
            ),
            SizedBox(height: 10),
            LinearProgressIndicator(
              value: moisture / 100,
              backgroundColor: Colors.grey[800],
              valueColor: AlwaysStoppedAnimation<Color>(moistureColor),
              minHeight: 10,
              borderRadius: BorderRadius.circular(5),
            ),
            SizedBox(height: 10),
            Text(
              moisture > 70
                  ? 'Soil is wet'
                  : moisture > 30
                  ? 'Soil is moist'
                  : 'Soil is dry',
              style: TextStyle(
                fontSize: 16,
                color: moistureColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(int moisture) {
    bool needsWater = moisture < 30;

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: needsWater
          ? Colors.red[900]!.withOpacity(0.8)
          : Colors.green[900]!.withOpacity(0.8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              needsWater ? Icons.warning : Icons.check_circle,
              color: needsWater ? Colors.red[100] : Colors.green[100],
              size: 40,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                needsWater
                    ? 'Plants need water! (Moisture: $moisture%)'
                    : 'Soil moisture is good (Moisture: $moisture%)',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}