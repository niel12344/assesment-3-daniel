import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF2E7D32), // Dark green
                Color(0xFF388E3C), // Medium green
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8F5E9), // Very light green
              Color(0xFFC8E6C9), // Light green
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Smart Farming Assistance',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20), // Dark green
                ),
              ),
              const SizedBox(height: 20),

              // FAQs Section
              _buildSectionHeader('Frequently Asked Questions'),
              _buildFAQItem(
                context,
                'How do I set up soil sensors?',
                'Go to Devices > Add New Sensor > Follow the pairing instructions. Ensure Bluetooth is enabled and the sensor is in pairing mode.',
              ),
              _buildFAQItem(
                context,
                'Why is my irrigation not activating automatically?',
                'Check your moisture threshold settings and ensure your weather data connection is active. The system may delay irrigation if rain is forecasted.',
              ),
              _buildFAQItem(
                context,
                'How accurate are the crop health predictions?',
                'Our AI models have 92% accuracy based on field tests. Accuracy improves as you provide more data about your specific farm conditions.',
              ),

              const SizedBox(height: 30),

              // Contact Support Section
              _buildSectionHeader('Contact Support'),
              _buildContactOption(
                Icons.email,
                'Email Us',
                'support@smartfarm.com',
                Color(0xFFD32F2F), // Red
                    () => _launchEmail('support@smartfarm.com'),
              ),
              _buildContactOption(
                Icons.phone,
                'Call Support',
                '0127272345',
                Color(0xFF1976D2), // Blue
                    () => _launchPhone('0127272345'),
              ),
              _buildContactOption(
                Icons.chat_bubble_outline,
                'Live Chat',
                'Available 8AM-8PM',
                Color(0xFF7B1FA2), // Purple
                    () => _showLiveChat(context),
              ),

              const SizedBox(height: 30),

              // Video Tutorials Section
              _buildSectionHeader('Video Tutorials'),
              _buildVideoCard(
                'Setting Up Your Smart Farm',
                'https://youtu.be/example1',
                Icons.settings,
                Color(0xFFF57C00), // Orange
              ),
              _buildVideoCard(
                'Interpreting Sensor Data',
                'https://youtu.be/example2',
                Icons.analytics,
                Color(0xFF0288D1), // Light blue
              ),
              _buildVideoCard(
                'Automated Irrigation Guide',
                'https://youtu.be/example3',
                Icons.opacity,
                Color(0xFF0097A7), // Teal
              ),

              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Still need help? Our team is available 24/7 for critical farm issues',
                  style: TextStyle(
                    color: Color(0xFF455A64), // Dark grey-blue
                    fontStyle: FontStyle.italic,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoCard(String title, String url, IconData icon, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Color(0xFFE8F5E9).withOpacity(0.7), // Semi-transparent light green
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _launchURL(url),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF1B5E20), // Dark green
                  ),
                ),
              ),
              Icon(Icons.play_circle_fill, color: color),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color(0xFF2E7D32), // Dark green
        ),
      ),
    );
  }

  Widget _buildFAQItem(BuildContext context, String question, String answer) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Color(0xFFE8F5E9).withOpacity(0.7), // Semi-transparent light green
      child: ExpansionTile(
        title: Text(
          question,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF1B5E20), // Dark green
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              answer,
              style: TextStyle(color: Color(0xFF455A64)), // Dark grey-blue
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactOption(IconData icon, String title, String subtitle, Color color, VoidCallback onTap) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Color(0xFFE8F5E9).withOpacity(0.7), // Semi-transparent light green
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B5E20), // Dark green
          ),
        ),
        subtitle: Text(subtitle, style: TextStyle(color: Color(0xFF455A64))),
        trailing: Icon(Icons.chevron_right, color: color),
        onTap: onTap,
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchEmail(String email) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Smart Farming App Support',
    );
    if (await canLaunchUrl(params)) {
      await launchUrl(params);
    }
  }

  Future<void> _launchPhone(String phone) async {
    final Uri params = Uri(
      scheme: 'tel',
      path: phone,
    );
    if (await canLaunchUrl(params)) {
      await launchUrl(params);
    }
  }

  void _showLiveChat(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Live Chat Support',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20), // Dark green
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Our agents are available 8AM-8PM daily. Would you like to start a chat?',
                style: TextStyle(color: Color(0xFF455A64)), // Dark grey-blue
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Describe your issue',
                  labelStyle: TextStyle(color: Color(0xFF455A64)), // Dark grey-blue
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFFDEE2E6)), // Light gray
                  ),

                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text(
                      'CANCEL',
                      style: TextStyle(color: Color(0xFF455A64)), // Dark grey-blue
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2E7D32), // Dark green
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('START CHAT'),
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Connecting you to an agent...'),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}