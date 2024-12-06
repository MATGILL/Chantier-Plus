import 'package:chantier_plus/features/construction_site%20management/presentation/pages/construction_site_home_screen_resp.dart';
import 'package:chantier_plus/features/construction_site%20management/presentation/widgets/map_display_page.dart';
import 'package:chantier_plus/features/resource_mangement/presentation/pages/resource_list_screen.dart';
import 'package:chantier_plus/features/construction_site%20management/presentation/pages/setting_screen.dart';
import 'package:flutter/material.dart';

class NavigationResp extends StatefulWidget {
  const NavigationResp({super.key});

  @override
  State<NavigationResp> createState() => _NavigationChefState();
}

class _NavigationChefState extends State<NavigationResp> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const ConstructionSiteHomeScreenResp(), // Écran principal
    MaPageResp(),
    const ResourceListScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    icon: Icon(Icons.bookmark_add),
                    label: 'ressources',
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
