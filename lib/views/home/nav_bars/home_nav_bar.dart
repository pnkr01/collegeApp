import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_app/views/home/alumini/alumini.dart';
import 'package:flutter/material.dart';
import '../blog_view.dart';

class HomeNavBar extends StatefulWidget {
  const HomeNavBar({Key? key}) : super(key: key);

  @override
  State<HomeNavBar> createState() => _HomeNavBarState();
}

class _HomeNavBarState extends State<HomeNavBar> {
  final List<Color> colors = [
    const Color(0xfff0bc81),
    const Color(0xff7447c9),
    const Color(0xffa86de3),
    const Color(0xffF19821),
    const Color(0xff9e7597),
    const Color(0xff0454fc),
    const Color(0xffa52ab8),
    const Color(0xff201b6e),
    const Color(0xff436073),
    const Color(0xff62a5b3),
    const Color(0xffaba559),
    const Color(0xffe368ae),
    const Color(0xffe68a7a),
    const Color(0xff346b75),
    const Color(0xffa52ab8),
  ];
  final List<String>? niche = [
    'Announcement',
    'Exam Notice',
    'Time Table',
    'Result',
    'Alumini',
    'Useful Resources',
    'Internships',
    'Books',
    'Lectures',
    'Jobs',
  ];
  final List<String> url = [
    'https://sites.google.com/view/collegeapp/home',
    "https://www.soa.ac.in/iter-exam-notice/",
    //timetable
    "https://www.soa.ac.in/iter-time-table",
    'http://103.112.27.37:8282/CampusPortalSOA/index#/',
    '',
    'https://sites.google.com/view/itermaterialguidances/home',
    'https://sites.google.com/view/itermaterialinternships/home',
    'https://sites.google.com/view/bookcollege/home',
    'https://sites.google.com/view/lecturem/home',
    'https://sites.google.com/view/itermaterialjobs/home',
  ];
  int? activeIndex = 0;
  Stream? slides;
  List? slideList;
  _querydb() {
    slides = FirebaseFirestore.instance.collection('store').snapshots().map(
          (list) => list.docs.map(
            (doc) => doc.data(),
          ),
        );
  }

  @override
  void initState() {
    super.initState();
    _querydb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
              stream: slides,
              builder: (context, AsyncSnapshot snap) {
                if (snap.hasError) {
                  const Center(
                    child: CircularProgressIndicator(
                        // backgroundColor: Colors.white,
                        ),
                  );
                }
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.only(
                      top: 25.0,
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                          //   backgroundColor: Color(0xffb196c4),
                          ),
                    ),
                  );
                }
                slideList = snap.data.toList();
                return Stack(
                  children: [
                    CarouselSlider(
                      items: slideList!.map(
                        (index) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    imageUrl: index['img'],
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    placeholder: (context, url) =>
                                        const SizedBox(
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.purple,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ).toList(),
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          setState(
                            () {
                              activeIndex = index;
                            },
                          );
                        },
                        pauseAutoPlayOnManualNavigate: true,
                        height: MediaQuery.of(context).size.height * 0.3,
                        viewportFraction: 1.0,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 500),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.03,
                      left: MediaQuery.of(context).size.width * 0.35,
                      child: CarouselIndicator(
                        color: Colors.blue,
                        count: slideList!.length - 1,
                        index: activeIndex,
                      ),
                    ),
                  ],
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Trending Topics ",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontFamily: "VarelaRound",
                          color: Colors.black,
                        ),
                      ),
                      Image.asset(
                        "assets/images/aa.gif",
                        width: 50,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: (MediaQuery.of(context).size.width / (2 * 100)),
              children: List.generate(
                10,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: () {
                        switch (index) {
                          case 0:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlogView(
                                  title: niche![index],
                                  blogUrl: url[index],
                                ),
                              ),
                            );
                            break;
                          case 1:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlogView(
                                  title: niche![index],
                                  blogUrl: url[index],
                                ),
                              ),
                            );
                            break;
                          case 2:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlogView(
                                  title: niche![index],
                                  blogUrl: url[index],
                                ),
                              ),
                            );
                            break;
                          case 3:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlogView(
                                  title: niche![index],
                                  blogUrl: url[index],
                                ),
                              ),
                            );
                            break;
                          case 4:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AluminiSCreen(),
                                // BlogView(
                                //   blogUrl: url[index],
                                //   title: niche![index],
                                // ),
                              ),
                            );
                            break;
                          case 5:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlogView(
                                  blogUrl: url[index],
                                  title: niche![index],
                                ),
                              ),
                            );
                            break;
                          case 6:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlogView(
                                  blogUrl: url[index],
                                  title: niche![index],
                                ),
                              ),
                            );
                            break;
                          case 7:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlogView(
                                  blogUrl: url[index],
                                  title: niche![index],
                                ),
                              ),
                            );
                            break;
                          case 8:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlogView(
                                  blogUrl: url[index],
                                  title: niche![index],
                                ),
                              ),
                            );
                            break;
                          case 9:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlogView(
                                  blogUrl: url[index],
                                  title: niche![index],
                                ),
                              ),
                            );
                            break;
                          // case 10:
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => BlogView(
                          //         title: niche![index],
                          //         blogUrl: url[index],
                          //       ),
                          //     ),
                          //   );
                          //   break;
                          // case 11:
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => AboutUs(),
                          //     ),
                          //   );
                          //   break;
                          // case 12:
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => BlogView(
                          //         title: niche![index],
                          //         blogUrl: url[index],
                          //       ),
                          //     ),
                          //   );
                          //   break;
                          // case 13:
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => BugReport(
                          //         username:
                          //             sharedPreferences!.getString("userName"),
                          //       ),
                          //     ),
                          //   );
                          //   break;
                          // case 14:
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => ClubDesign(),
                          //     ),
                          //   );
                          //   break;
                          default:
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          shape: BoxShape.rectangle,
                          color: colors[index],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                            16.0,
                            16.0,
                            0.0,
                            0.0,
                          ),
                          child: Text(
                            niche![index],
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontFamily: "VarelaRound",
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
