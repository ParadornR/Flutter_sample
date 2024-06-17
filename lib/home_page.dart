import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';
import 'package:flutter_application_example/dummy.dart';
import 'package:flutter_application_example/styles.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedCategory = 0;
  final LoopPageController _categoryBarController = LoopPageController(
    initialPage: 0,
    viewportFraction: 1 / 3.7,
  );
  final LoopPageController _categoryPageController = LoopPageController(
    initialPage: 0,
    viewportFraction: 1 / 1,
  );

  void _jumpToPage(int pageIndex) {
    _categoryBarController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    _categoryPageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _categoryBarController.dispose();
    _categoryPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Symbols.search),
            Text('Kakao'),
            Icon(Symbols.menu),
          ],
        ),
      ),
      body: Stack(
        children: [
          categoryPage(),
          categorybar(),
        ],
      ),
    );
  }

  Widget categorybar() {
    final category = context.read<Dummy>().category;
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: LoopPageView.builder(
            itemCount: category.length,
            controller: _categoryBarController,
            onPageChanged: (indexBar) {
              _jumpToPage(_selectedCategory);
            },
            itemBuilder: (_, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    log('indexBar:$index');
                    _selectedCategory = index;
                  });
                  _jumpToPage(_selectedCategory);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: _selectedCategory == index
                        ? ColorStyles.green_400
                        : ColorStyles.grey_800,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Center(
                    child: Text(
                      '${category[index]['category']}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _selectedCategory == index
                            ? Colors.white
                            : ColorStyles.grey_400,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const Expanded(flex: 15, child: SizedBox()),
      ],
    );
  }

  Widget categoryPage() {
    final category = context.read<Dummy>().category;
    return LoopPageView.builder(
      itemCount: category.length,
      controller: _categoryPageController,
      onPageChanged: (indexPage) {
        _jumpToPage(_selectedCategory);
      },
      itemBuilder: (_, indexPage) {
        if (indexPage == 0) return page(indexPage);
        if (indexPage == 1) {
          return page(indexPage);
        } else {
          return const Placeholder();
        }
      },
    );
  }

  Widget buildEventWidget(String event) {
    Color bgColor;
    Widget child;
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 0);
    double containerHeight = 24.0; // Set a fixed height for all containers
    switch (event) {
      case 'top1':
        bgColor = Colors.red;
        child = const Text(
          '1           -',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: 14,
          ),
        );
        break;
      case 'ตั๋วฟรี':
        bgColor = Colors.yellow;
        padding = const EdgeInsets.symmetric(horizontal: 6);
        child = const Icon(
          Symbols.schedule_rounded,
          color: Colors.black,
          size: 14,
          weight: 900,
        );
        break;
      case 'ใหม่':
        bgColor = Colors.red;
        child = const Text(
          textAlign: TextAlign.center,
          'N',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: 14,
          ),
        );
        break;
      case 'กิจกรรม':
        bgColor = ColorStyles.purple_600;
        child = Text(
          event,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: 14,
          ),
        );
        break;
      default:
        bgColor = Colors.black;
        child = Text(
          event,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: 14,
          ),
        );
        break;
    }

    return Container(
      height: containerHeight, // Ensure the same height for all containers
      margin: const EdgeInsets.all(1.0),
      padding: padding,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(child: child), // Centering the child
    );
  }

  Widget page(int index) {
    final category = context.read<Dummy>().category;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 1.85,
            margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            color: ColorStyles.grey_900,
            child: Column(
              children: [
                const SizedBox(height: 48), // เปลี่ยนจาก Expanded เป็น SizedBox
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ColorStyles.grey_700,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          '${category[index]['item'][0]['name']}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          textAlign: TextAlign.center,
                          '${category[index]['item'][0]['description']}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            category[index]['item'][0]['event'].length,
                            (indexList) {
                              return buildEventWidget(category[index]['item'][0]
                                  ['event'][indexList]);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // number of items in each row
              mainAxisSpacing: 4.0, // spacing between rows
              crossAxisSpacing: 4.0, // spacing between columns
              childAspectRatio: 0.5,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            itemCount: category[index]['item'].length - 1,
            itemBuilder: (context, indexitem) {
              return Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: ColorStyles.grey_800,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: category[index]['item'][indexitem + 1]
                                  ['event'] !=
                              null
                          ? List.generate(
                              category[index]['item'][indexitem + 1]['event']
                                  .length,
                              (indexList) {
                                var eventItem = category[index]['item']
                                    [indexitem + 1]['event'][indexList];
                                return eventItem == null
                                    ? const SizedBox() // หรือ widget ที่ต้องการแสดงแทน
                                    : buildEventWidget(eventItem);
                              },
                            )
                          : [], // ถ้า event เป็น null ให้สร้าง List ว่าง
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Stack(
                              children: <Widget>[
                                Text(
                                  textAlign: TextAlign.center,
                                  '${category[index]['item'][indexitem + 1]['name']}',
                                  style: TextStyle(
                                    overflow: TextOverflow.clip,
                                    fontSize: 20,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 6
                                      ..color = Colors.black,
                                  ),
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  '${category[index]['item'][indexitem + 1]['name']}',
                                  style: TextStyle(
                                    overflow: TextOverflow.clip,
                                    fontSize: 20,
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
