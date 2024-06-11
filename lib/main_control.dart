// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_example/home_page.dart';
import 'package:flutter_application_example/table_page.dart';
import 'package:material_symbols_icons/symbols.dart';

class MainControl extends StatefulWidget {
  const MainControl({super.key});

  @override
  State<MainControl> createState() => MainControlState();
}

class MainControlState extends State<MainControl> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: const <Widget>[
          HomePage(),
          TablePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Symbols.home_rounded),
            label: 'หน้าแรก',
          ),
          BottomNavigationBarItem(
            icon: Icon(Symbols.calendar_view_week_rounded),
            label: 'ตารางเว็บตูน',
          ),
        ],
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 12.0,
        unselectedFontSize: 12.0,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: _onTappedBar,
        iconSize: 24.0,
        elevation: 0,
      ),
    );
  }

  void _onTappedBar(int value) {
    setState(() {
      _selectedIndex = value;
    });
    _pageController.jumpToPage(value);
  }
}
