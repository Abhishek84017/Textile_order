import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                color: Color(0xff312783),
              ),
              Positioned(
                right: MediaQuery.of(context).size.width * 0.4,
                top: 100,
                child: const CircleAvatar(
                  radius: 40,
                  backgroundImage:
                      AssetImage('assets/images/login_background.png'),
                ),
              )
            ],
          ),
          SizedBox(height: 100,),
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
          )
        ],
      ),
    );
  }
}
