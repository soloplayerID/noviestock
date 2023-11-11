import 'package:flutter/material.dart';

import '../helper/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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

    List<String> containerList = [
      "product",
      "visite",
      "stock",
      "account"
    ];

    final textTheme = Theme.of(context).textTheme;
    List<Icon> iconList = [
      const Icon(Icons.file_copy, color: Colors.white, size: 35),
      const Icon(Icons.video_call_rounded, color: Colors.white, size: 35),
      const Icon(Icons.padding_sharp, color: Colors.white, size: 35),
      const Icon(Icons.account_circle_rounded, color: Colors.white, size: 35),
      const Icon(Icons.video_camera_back_rounded, color: Colors.white, size: 35),
      const Icon(Icons.leaderboard, color: Colors.white, size: 35),
    ];

    List<String> courseImages = [
      "assets/images/images1.png",
      "assets/images/images2.png",
      "assets/images/images3.png",
    ];

    List<String> title = [
      'morning textbook',
      'english reading',
      'ilustration'
    ];

    List<Color> courseColor = [
      const Color(0xFF64DA91),
      const Color(0xFF60c0fc),
      const Color(0xFFfb7f7f),
    ];


    return SafeArea(child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Sistem Monitoring', style: textTheme.titleLarge,),
                const Icon(Icons.notifications_rounded, color: Color(0xff3cB792),),
              ],
            ),
            const SizedBox(height: 5,),
            const Row(
              children: [
                Text('masa expired produk\t', style: TextStyle(
                  color: Colors.black54,
                ),),
                Text('By Novi', style: TextStyle(color:  Color(0xff3cb792)),)
              ],
            ),
            const SizedBox(height: 30,),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black12.withOpacity(0.03),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                decoration: const InputDecoration(prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
                labelText: "Cari Sesuatu?",
                labelStyle: TextStyle(fontSize: 14, color: Colors.black45),
                ),
                
              ),
            ),
            const SizedBox(height: 40,),
            GridView.builder(
              shrinkWrap: true,
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), 
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/visite');
                  },
                  child: Column(
                    children: [ 
                      Container(
                        height: 60,
                        width: 60, 
                        decoration: BoxDecoration(
                          color: bgColors[index],
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [BoxShadow(blurRadius: 5, color: bgColors[index]),]
                        ),
                        child: Center(child: iconList[index]),
                      ),
                      const SizedBox(height: 5),
                      Text(containerList[index]),
                    ],
                  ),
                );
            },),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text("Pengumuman",
              style: textTheme.titleLarge,),
              const Text("More",
              style: TextStyle(color: Colors.black45),)
            ],),
            const SizedBox(height: 20,),
            SizedBox(
      height: 88,
      child: ListView.builder(
        itemCount: 1,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          return InkWell(
            onTap: () {
              
            },
            child: Container(
              padding: const EdgeInsets.all(9),
              margin: const EdgeInsets.only(right: 20),
              width: 208,
              height: 88,
              decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius:
                      BorderRadius.circular(kBorderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: kDarkBlue.withOpacity(0.051),
                      offset: const Offset(0.0, 3.0),
                      blurRadius: 24.0,
                      spreadRadius: 0.0,
                    ),
                  ]),
              child: Row(
                children: [
                  Container(
                    width: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            kBorderRadius),
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'https://res.klook.com/image/upload/fl_lossy.progressive,w_800,c_fill,q_85/destination/kvcqcy32vayw4b2qnmwk.jpg'))),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Flexible(
                      child: Column(
                    children: [
                      Text('pengumuman',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: kPoppinsSemiBold.copyWith(
                            fontSize: 12,
                          )),
                    ],
                  ))
                ],
              ),
            ),
          );
        }),
      ),
    ),
          ],
        ),
      ),
    ));
  }
}