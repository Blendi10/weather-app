import 'package:flutter/material.dart';

class CityPickerSheet extends StatefulWidget {
  const CityPickerSheet({super.key});

  @override
  State<CityPickerSheet> createState() => _CityPickerSheetState();
}

class _CityPickerSheetState extends State<CityPickerSheet> {
  final TextEditingController _controller = TextEditingController();

  late List<String> _filtered;

  @override
  void initState() {
    super.initState();
    _filtered = List.of(_allCities);
    _controller.addListener(() {
      final q = _controller.text.toLowerCase();
      setState(() {
        _filtered = _allCities
            .where((c) => c.toLowerCase().contains(q))
            .toList(growable: false);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _selectCity(String city) {
    Navigator.of(context).pop(city);
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: viewInsets.bottom, top: 60),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _controller,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search city',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                itemCount: _filtered.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final city = _filtered[index];
                  return ListTile(
                    leading: const Icon(Icons.location_city),
                    title: Text(city),
                    onTap: () => _selectCity(city),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<String> _allCities = const [
    'Pristina',
    'London',
    'Paris',
    'Berlin',
    'Rome',
    'Madrid',
    'Vienna',
    'Athens',
    'Amsterdam',
    'Zurich',
    'Moscow',
    'Istanbul',
    'New York',
    'San Francisco',
    'Los Angeles',
    'Chicago',
    'Toronto',
    'Vancouver',
    'Mexico City',
    'Miami',
    'Washington D.C.',
    'São Paulo',
    'Buenos Aires',
    'Rio de Janeiro',
    'Lima',
    'Bogotá',
    'Tokyo',
    'Beijing',
    'Shanghai',
    'Seoul',
    'Bangkok',
    'Hong Kong',
    'Singapore',
    'Mumbai',
    'Delhi',
    'Jakarta',
    'Sydney',
    'Melbourne',
    'Auckland',
    'Dubai',
    'Doha',
    'Tel Aviv',
    'Riyadh',
    'Cairo',
    'Johannesburg',
    'Nairobi',
    'Casablanca',
    'Cape Town',
  ];
}
