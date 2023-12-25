import 'package:flutter/material.dart';
import 'package:merchant/src/constants/sizes.dart';
import 'package:merchant/src/constants/text_strings.dart';
import 'package:merchant/src/features/core/screens/dashboard/widgets/top_courses.dart';
import 'package:merchant/src/features/product/screens/categories/widgets/appbar.dart';
import 'package:merchant/src/features/product/screens/categories/widgets/category_list.dart';

import '../../../core/screens/dashboard/widgets/categories.dart';

class Category extends StatelessWidget {
  const Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Variables
    final txtTheme = Theme.of(context).textTheme;
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark; //Dark mode

    return SafeArea(
      child: Scaffold(
      appBar: CategoryAppBar(isDark: isDark),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDashboardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
      //Banners
      CategoryList(txtTheme: txtTheme, isDark: isDark),
      const SizedBox(height: tDashboardPadding),

      // //Top Course
      // Text(tDashboardTopCourses, style: txtTheme.headlineMedium?.apply(fontSizeFactor: 1.2)),
      // DashboardTopCourses(txtTheme: txtTheme, isDark: isDark)
    ])))));
  }
}
