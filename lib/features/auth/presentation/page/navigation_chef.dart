import 'package:chantier_plus/features/construction_site%20management/presentation/pages/construction_site_home_screen_chef.dart';
import 'package:chantier_plus/features/construction_site%20management/presentation/pages/setting_screen.dart';
import 'package:flutter/material.dart';

class NavigationChef extends StatefulWidget {
  const NavigationChef({super.key});

  @override
  State<NavigationChef> createState() => _NavigationChefState();
}

class _NavigationChefState extends State<NavigationChef> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const ConstructionSiteListScreenChef(), // Écran principal
    const Center(child: Text('Map Screen')),
    const SettingsScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _screens[_currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Material(
          elevation: 15,
          borderRadius: BorderRadius.circular(25),
          color: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // Couleur de la barre
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: NavigationBar(
                height: 60,
                backgroundColor: Colors.white,
                selectedIndex: _currentIndex,
                onDestinationSelected: _onItemTapped,
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.map),
                    label: 'Map',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.settings),
                    label: 'settings',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
