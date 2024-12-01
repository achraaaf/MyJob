import 'package:flutter/material.dart';
import 'package:flutter_application_1/job_seeker_views/Home/view/HomeScreen.dart';
import 'package:flutter_application_1/job_seeker_views/pages/messages.dart';
import 'package:flutter_application_1/job_seeker_views/pages/profile/profile_page.dart';
import 'package:flutter_application_1/job_seeker_views/pages/savedJobs/view/saved_jobs.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';

class BottomNavigationBarJobseekerApp extends StatelessWidget {
  const BottomNavigationBarJobseekerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavigationBarJobseeker(),
    );
  }
}

class BottomNavigationBarJobseeker extends StatefulWidget {
  const BottomNavigationBarJobseeker({super.key, this.wantedPage});
  final int? wantedPage;

  @override
  State<BottomNavigationBarJobseeker> createState() =>
      Jobseeker_NavigationBar();
}

class Jobseeker_NavigationBar extends State<BottomNavigationBarJobseeker> {
  void initState() {
    super.initState();
    _selectedIndex = widget.wantedPage ?? 0; // Use wantedPage if provided
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    SavedJobs(),
    Messages(),
    Messages(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, bottom: 17, top: 10),
        child: GNav(
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          selectedIndex: _selectedIndex,
          backgroundColor: Colors.white,
          gap: 8,
          activeColor: Colors.white,
          iconSize: 30,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 11),
          duration: Duration(milliseconds: 600),
          tabBackgroundColor: Colors.black,
          color: Colors.grey[900],
          tabActiveBorder: Border.all(color: Colors.black, width: 0.5),
          tabs: [
            GButton(
              icon: Iconsax.home,
              text: "Home",
            ),
            GButton(
              icon: Iconsax.save_2,
              text: "Saved Jobs",
            ),
            GButton(
              icon: Iconsax.briefcase,
              text: "Applications",
            ),
            GButton(
              icon: Iconsax.message_notif,
              text: "Messages",
            ),
            GButton(
              icon: Iconsax.user,
              text: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
