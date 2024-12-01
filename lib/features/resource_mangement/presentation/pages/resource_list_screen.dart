import 'package:chantier_plus/features/resource_mangement/domain/entities/resource_type.dart';
import 'package:flutter/material.dart';
import 'package:chantier_plus/features/resource_mangement/presentation/pages/create_resource_screen.dart';

class ResourceListScreen extends StatefulWidget {
  const ResourceListScreen({super.key});

  @override
  State<ResourceListScreen> createState() => _ResourceListScreenState();
}

class _ResourceListScreenState extends State<ResourceListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: ResourceType.values.length,
      vsync: this,
    );
    _pageController = PageController(initialPage: _tabController.index);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _pageController.jumpToPage(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Ressources'),
        bottom: TabBar(
          controller: _tabController,
          tabs: ResourceType.values
              .map((type) => Tab(text: type.name.toUpperCase()))
              .toList(),
        ),
      ),
      body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            _tabController.animateTo(index);
          },
          children: [
            //TODO replace by the corrects widget !!
            Center(
              child: Text('"hello'),
            ),
            Center(
              child: Text('"hello2'),
            )
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreateResourceScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
