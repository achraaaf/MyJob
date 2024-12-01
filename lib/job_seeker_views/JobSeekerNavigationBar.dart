import 'package:MyJob/Repositories/authentication/authentication_Repository.dart';
import 'package:MyJob/utils/notifications/GetNotifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:MyJob/job_seeker_views/Home/view/HomeScreen.dart';
import 'package:MyJob/job_seeker_views/pages/Applications/view/ApplicationsView.dart';
import 'package:MyJob/job_seeker_views/pages/Messages/view/messagesView.dart';
import 'package:MyJob/job_seeker_views/pages/profile/profile_page.dart';
import 'package:MyJob/job_seeker_views/pages/savedJobs/view/saved_jobs.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';

class BottomNavigationBarJobseeker extends StatefulWidget {
  final int wantedPage;
  const BottomNavigationBarJobseeker({super.key, this.wantedPage = 0});

  @override
  State<BottomNavigationBarJobseeker> createState() =>
      _BottomNavigationBarJobseekerState();
}

class _BottomNavigationBarJobseekerState
    extends State<BottomNavigationBarJobseeker> {
  late int _selectedIndex;
  late CollectionReference _collectionReference;
  late DateTime _listenerStartTime;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.wantedPage;
    _collectionReference = FirebaseFirestore.instance
        .collection('notifications')
        .doc(AuthenticationRepository.instance.authUser!.uid)
        .collection("Allnotifications");
    _listenerStartTime = DateTime.now();
    listenForNotifications();
  }

  void listenForNotifications() {
    _collectionReference.snapshots().listen((QuerySnapshot snapshot) {
      snapshot.docChanges.forEach((change) {
        if (change.type == DocumentChangeType.added) {
          final data = change.doc.data() as Map<String, dynamic>;
          final Timestamp timestamp = data['timestamp'];
          final DateTime createdAt = timestamp.toDate();

          if (createdAt.isAfter(_listenerStartTime)) {
            _handleNotification(data);
          }
        }
      });
    });
  }

  void _handleNotification(Map notificationData) {
    final String title = notificationData['title'];
    final String body = notificationData['content'];

    LocalNotification.showNotification(title, body);
  }

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    SavedJobs(),
    ApplicationsView(),
    Messages(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: GNav(
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            selectedIndex: _selectedIndex,
            backgroundColor: Color(0xff101010),
            gap: 8,
            activeColor: Colors.black,
            iconSize: 28,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 11),
            duration: Duration(milliseconds: 600),
            tabBackgroundColor: Colors.white,
            color: Colors.grey[900],
            //tabActiveBorder: Border.all(color: Colors.black, width: 0.5),
            tabs: [
              GButton(
                margin: EdgeInsets.only(left: 10),
                icon: Iconsax.home,
                text: "Home",
                iconColor: Colors.white,
              ),
              GButton(
                icon: Iconsax.save_2,
                text: "Saved Jobs",
                iconColor: Colors.white,
              ),
              GButton(
                margin: EdgeInsets.only(top: 7, bottom: 7),
                icon: Iconsax.briefcase,
                text: "Applications",
                iconColor: Colors.white,
              ),
              GButton(
                icon: Iconsax.message_notif,
                text: "Messages",
                iconColor: Colors.white,
              ),
              GButton(
                margin: EdgeInsets.only(right: 10),
                icon: Iconsax.user,
                text: "Profile",
                iconColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
