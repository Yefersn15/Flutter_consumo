import 'package:flutter/material.dart';
import 'search_screen.dart';

class NavDemoPage extends StatefulWidget {
  const NavDemoPage({super.key});

  @override
  State<NavDemoPage> createState() => _NavDemoPageState();
}

class _NavDemoPageState extends State<NavDemoPage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const SearchScreen(),
    const Center(child: Text('Inicio - Demo')),
    const Center(child: Text('Perfil - Demo')),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo BottomNavigation')),
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}
