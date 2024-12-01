import 'package:flutter/material.dart';
import 'package:MyJob/job_seeker_views/JobSeekerNavigationBar.dart';
import 'package:MyJob/job_seeker_views/pages/Messages/controller/messagesController.dart';
import 'package:MyJob/job_seeker_views/pages/Messages/view/ChatPage.dart';
import 'package:MyJob/job_seeker_views/pages/Messages/widgets/NoMessagesWidget.dart';
import 'package:MyJob/job_seeker_views/pages/Messages/widgets/UnseenMessages.dart';
import 'package:MyJob/job_seeker_views/pages/Messages/widgets/latestMessage.dart';
import 'package:MyJob/job_seeker_views/pages/Messages/widgets/timestampWidget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MessagesController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Messages",
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavigationBarJobseeker(),
              ),
            );
          },
          icon: Image(
            image: AssetImage("images/left-arrow.png"),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(() {
                  if (controller.isLoading.value)
                    return SizedBox(
                      width: 500,
                      height: 500,
                      child: Lottie.asset("images/getting.json"),
                    );
                  if (controller.Conversations.isEmpty) {
                    return NoMessagesWidget();
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.EmployersInfos.length,
                    itemBuilder: (Context, index) {
                      final conversation = controller.Conversations[index];
                      final employer = controller.EmployersInfos.firstWhere(
                          (emp) => emp.EmployerId == conversation.EmployerId);

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatPage(
                                  conversation: conversation,
                                  employer: employer),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                              color: Color(0xffF5F5F5),
                              borderRadius: BorderRadius.circular(17)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: CircleAvatar(
                                  radius: 26,
                                  backgroundImage:
                                      NetworkImage(employer.CompanyLogo),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      employer.companyName,
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    LatestMessage(
                                      conversationId: conversation.Id,
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  timestampWidget(
                                      conversationId: conversation.Id),
                                  SizedBox(height: 5),
                                  UnseenMessages(
                                    conversationId: conversation.Id,
                                    receiverId: employer.EmployerId,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
