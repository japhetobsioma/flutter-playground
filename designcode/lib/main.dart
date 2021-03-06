import 'package:designcode/model/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/lists/recent_course_list.dart';
import 'components/home_screen_navbar.dart';
import 'constants.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: kBackgroundColor,
          child: SafeArea(
            child: Column(
              children: [
                HomeScreenNavBar(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Recents',
                        style: kLargeTitleStyle,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '23 courses, more coming',
                        style: kSubtitleStyle,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                RecentCourseList(),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top: 25.0,
                    bottom: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Explore',
                        style: kTitle1Style,
                      ),
                    ],
                  ),
                ),
                ExploreCourseList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExploreCourseList extends StatelessWidget {
  const ExploreCourseList();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: exploreCourses.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: index == 0 ? 20.0 : 0.0),
            child: ExploreCourseCard(
              course: exploreCourses[index],
            ),
          );
        },
      ),
    );
  }
}

class ExploreCourseCard extends StatelessWidget {
  const ExploreCourseCard({@required this.course});

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 20.0,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          41.0,
        ),
        child: Container(
          height: 120.0,
          width: 280.0,
          decoration: BoxDecoration(
            gradient: course.background,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 32.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.courseSubtitle,
                        style: kCardSubtitleStyle,
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                      Text(
                        course.courseTitle,
                        style: kCardTitleStyle,
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      'asset/illustrations/${course.illustration}',
                      fit: BoxFit.cover,
                      height: 100.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// TODO: 010
