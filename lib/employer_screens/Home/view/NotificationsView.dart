import 'package:MyJob/Repositories/authentication/authentication_Repository.dart';
import 'package:MyJob/employer_screens/Home/Widgets/NotificationCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class NotificationsView extends StatelessWidget {
  NotificationsView({super.key});

  final notificationsRef = FirebaseFirestore.instance
      .collection('notifications')
      .doc(AuthenticationRepository.instance.authUser!.uid)
      .collection("Allnotifications")
      .orderBy('timestamp', descending: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image(
            image: AssetImage("images/left-arrow.png"),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: StreamBuilder<QuerySnapshot>(
          stream: notificationsRef.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Lottie.asset("images/getting.json"));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Column(
                children: [
                  Image.asset("images/emptyNotifications.png"),
                  Text(
                    'Empty',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text('You dont have any notification at this time',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ))
                ],
              );
            }

            final notifications = snapshot.data!.docs;

            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final data =
                    notifications[index].data() as Map<String, dynamic>;
                return NotificationCard(
                  title: data['title']?? 'empty',
                  content: data['content'] ?? 'empty',
                  timestamp: data['timestamp'],
                  JobSeekerId: data['sender_id'],
                  jobApplicationId: data['application_id'],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
