import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/api_service.dart';
import 'package:weather_app/services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _cityController = TextEditingController();
  Weather? _weather;
  bool _isLoading = false;

  Future<void> _fetchWeather() async {
    setState(() => _isLoading = true);
    try {
      final weather = await ApiService().fetchWeather(_cityController.text);
      setState(() => _weather = weather);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await Provider.of<AuthService>(context, listen: false).signOut();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _cityController,
                      decoration: const InputDecoration(
                        labelText: 'Enter City',
                        hintText: 'e.g. London',
                      ),
                    ),
                  ),
                  IconButton(
                    icon:
                        _isLoading
                            ? const CircularProgressIndicator()
                            : const Icon(Icons.search),
                    onPressed: _isLoading ? null : _fetchWeather,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _weather == null
                  ? const Text('Search for a city to get weather')
                  : Column(
                    children: [
                      Text('City: ${_weather!.city}'),
                      Text('Temperature: ${_weather!.temperature}°C'),
                      Text('Condition: ${_weather!.description}'),
                    ],
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
