import 'package:flutter/material.dart';
import 'package:flutter_application_1/job_seeker_views/pages/profile/EditProfile/widgets/CircleContainer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class PopularJobsWidget extends StatefulWidget {
  const PopularJobsWidget({super.key});

  @override
  State<PopularJobsWidget> createState() => _PopularJobsWidgetState();
}

class _PopularJobsWidgetState extends State<PopularJobsWidget> {
  PageController pageController = PageController(viewportFraction: 0.80);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
        height: 200,
        child: PageView(
          controller: pageController,
          children: [
            _buildPopularJobItem(
                'Software Engineer',
                'Facebook',
                'images/facebook.png',
                'Menlo Park, United States',
                '3 hours ago',
                '\$ 14k / month'),
            _buildPopularJobItem(
                'Designer UI',
                'Google LLC',
                'images/google.jpg',
                'New York, United States',
                '19 hours ago',
                '\$ 12k / month'),
            _buildPopularJobItem(
                'Sales & Marketing',
                'Paypal',
                'images/paypal.jpg',
                ' Palo Alto, United States',
                '12 hours ago',
                '\$ 8k / month'),
            _buildPopularJobItem(
                'Besiness Analyst',
                'Youtube',
                'images/youtube.jpg',
                'New York, United States',
                '37 minute ago',
                '\$ 12k / month'),
            _buildPopularJobItem(
                'Quality Assurance',
                'Discord',
                'images/discord.png',
                'California, United States',
                '6 hours ago',
                '\$ 5k / month'),
          ],
        ),
      );
    });
  }

  Widget _buildPopularJobItem(
    String Jobtitle,
    String Companyname,
    String Companylogo,
    String Companylocation,
    String time,
    String salary,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 17, 17, 17),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(2, 1),
          )
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: AssetImage('$Companylogo'),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$Jobtitle",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      letterSpacing: -0.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "$Companyname",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      letterSpacing: -0.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(Iconsax.save_2, color: Colors.white, size: 30),
              )
            ],
          ),
          SizedBox(height: 8),
          Text(
            "$Companylocation",
            style: GoogleFonts.inter(
              color: Colors.white.withOpacity(0.9),
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white.withOpacity(0.1),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: Text(
                  "Full Time",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white.withOpacity(0.1),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: Text(
                  "Freelance",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                "$time",
                style: GoogleFonts.inter(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  "$salary",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
