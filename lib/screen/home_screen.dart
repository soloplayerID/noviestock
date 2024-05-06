import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home/announcement_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    checkUserLoginStatus();
    super.initState();
  }

  void checkUserLoginStatus() async {
    final user = _auth.currentUser;
    if (user == null) {
      // Pengguna belum login, arahkan ke halaman login
      Navigator.pushNamed(context, "/");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Color> bgColors = [
      const Color(0xFFfdd133),
      const Color(0xFF64DA91),
      const Color(0xFF60c0fc),
      const Color(0xFFfb7f7f),
      const Color(0xFFca84f9),
      const Color(0xFF7ae667),
    ];

    List<String> containerList = ["product", "visit", "stock", "account"];

    final textTheme = Theme.of(context).textTheme;
    List<Icon> iconList = [
      const Icon(Icons.file_copy, color: Colors.white, size: 35),
      const Icon(Icons.video_call_rounded, color: Colors.white, size: 35),
      const Icon(Icons.padding_sharp, color: Colors.white, size: 35),
      const Icon(Icons.account_circle_rounded, color: Colors.white, size: 35),
      const Icon(Icons.video_camera_back_rounded,
          color: Colors.white, size: 35),
      const Icon(Icons.leaderboard, color: Colors.white, size: 35),
    ];

    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sistem Monitoring',
                  style: textTheme.titleLarge,
                ),
                const Icon(
                  Icons.notifications_rounded,
                  color: Color(0xff3cB792),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Row(
              children: [
                Text(
                  'masa expired produk\t',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                Text(
                  'By Novi',
                  style: TextStyle(color: Color(0xff3cb792)),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black12.withOpacity(0.03),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  labelText: "Cari Sesuatu?",
                  labelStyle: TextStyle(fontSize: 14, color: Colors.black45),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            GridView.builder(
              shrinkWrap: true,
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/${containerList[index]}');
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: bgColors[index],
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(blurRadius: 5, color: bgColors[index]),
                            ]),
                        child: Center(child: iconList[index]),
                      ),
                      const SizedBox(height: 5),
                      Text(containerList[index]),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Pemberitahuan",
                  style: textTheme.titleLarge,
                ),
                const Text(
                  "More",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const AnnouncementWidget()
          ],
        ),
      ),
    ));
  }
}
