import 'package:flutter/material.dart';
import 'package:salvavidas_app/features/security/pages/security_page.dart';
import 'package:salvavidas_app/features/settings/pages/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          SecurityPage(),
          SettingsPage(),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: size.height * 0.1,
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _CustomBottomNAvigationBarItem(
              onTap: () {
                _onItemTapped(0);
              },
              path: "assets/icons/file_icon.png",
            ),
            _CustomBottomNAvigationBarItem(
              onTap: () {
                // _onItemTapped(1);
              },
              path: "assets/icons/reload_icon.png",
            ),
            _CustomBottomNAvigationBarItem(
                onTap: () {
                  // _onItemTapped(0);
                },
                path: "assets/icons/translate_icon.png"),
            _CustomBottomNAvigationBarItem(
                onTap: () {
                  // _onItemTapped(1);
                },
                path: "assets/icons/question_mark_icon.png"),
            _CustomBottomNAvigationBarItem(
                onTap: () {
                  _onItemTapped(1);
                },
                path: "assets/icons/settings_icon.png"),
          ],
        ),
      ),
    );
  }
}

class _CustomBottomNAvigationBarItem extends StatelessWidget {
  final String path;
  final VoidCallback onTap;
  const _CustomBottomNAvigationBarItem({
    required this.path,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration:
            BoxDecoration(image: DecorationImage(image: AssetImage(path))),
      ),
    );
  }
}
