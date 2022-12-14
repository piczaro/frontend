import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_countdown_timer/countdown.dart';
import 'package:date_count_down/countdown.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:like_button/like_button.dart';
import 'package:pixzaro/Login%20copy.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'Contested.dart';
import 'package:localstorage/localstorage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Globe_contest_all extends StatefulWidget {
  const Globe_contest_all({Key? key}) : super(key: key);

  @override
  State<Globe_contest_all> createState() => _Globe_contest_all();
}

class _Globe_contest_all extends State<Globe_contest_all> {
  List<int> list = [1, 2, 3, 4, 5];
  final List<Map<String, dynamic>> _statistics = [
    {'key': 'Flutter Tutorial', 'value': 90},
    {'key': 'Android Tutorial', 'value': 50, 'border': true},
    {'key': 'Java Tutorial', 'value': 30},
    {'key': 'sdfjsfjk', 'value': 70}
  ];
  Future<List<dynamic>> loaddata() async {
    final storage = new LocalStorage('my_data');
    final token = await storage.getItem('jwt_token');
    final response = await http.get(
      Uri.parse('${dotenv.env['API_URL']}/api/contest_listing'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}',
      },
    );
    if (response.statusCode == 200) {
      var token_data = jsonDecode(response.body)['status'];
      

      if (token_data) {
        var jsonData = jsonDecode(response.body)['data'];
        print(jsonData);
        return jsonData;
      } else if (!token_data) {
        Future.delayed(const Duration(milliseconds: 0), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        });
      }
      var jsonData = jsonDecode(response.body)['data'] ?? [];
      return jsonData;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  late Future<List<dynamic>> futureAlbum;
  @override
  void initState() {
    super.initState();
    futureAlbum = loaddata();
  }

  int counter = 0;
  String counttime = "Loading";
  @override
  Widget build(BuildContext context) {
    counttime = CountDown().timeLeft(DateTime.parse("2022-07-23 10:00:00"),
        "Completed", "d :", "h :", "m :", "s", "D ", "H ", "M", "S");

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
        child: FutureBuilder(
            future: futureAlbum,
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                int l = snapshot.data.length;
                if (l == 0) {
                  return Center(
                      child: Text(
                    "No Data",
                    style: TextStyle(fontSize: 20),
                  ));
                }
                return RefreshIndicator(
                  onRefresh: loaddata,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(children: [
                          if (snapshot.data[index]['contest_status'] ==
                              "Ongoing Contest")
                            Container(
                              margin: EdgeInsets.fromLTRB(5, 7, 7, 5),
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Column(children: [
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              10, 5, 10, 0),
                                          child: Text(
                                            "${snapshot.data[index]['name']}",
                                            style: const TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontFamily: "SFPRO regular",
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              10, 5, 10, 0),
                                          child: const Text(
                                            "Likes Received",
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontFamily: "SFPRO regular",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              10, 5, 10, 0),
                                          child: Text(
                                            "${snapshot.data[index]['name']}",
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontFamily: "SFPRO semibold",
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              10, 5, 10, 0),
                                          child: const Text(
                                            "1412",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 0, 153, 5),
                                              fontFamily: "SFPRO semibold",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            // Container(
                                            //   margin: const EdgeInsets.fromLTRB(
                                            //       10, 5, 0, 0),
                                            //   child: const Text(
                                            //     "Name",
                                            //     style: TextStyle(
                                            //       fontSize: 20,
                                            //       color: Colors.black,
                                            //       fontFamily: "SFPRO semibold",
                                            //     ),
                                            //   ),
                                            // ),
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  10, 5, 10, 0),
                                              child: const Text(
                                                "Live",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color.fromARGB(
                                                      255, 233, 182, 238),
                                                  fontFamily: "SFPRO semibold",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              10, 5, 10, 0),
                                          child: Row(
                                            children: [
                                              Text("Ends In : "),
                                              CountdownTimer(
                                                endTime: DateTime.parse(
                                                        "${snapshot.data[index]['end_datetime']}")
                                                    .millisecondsSinceEpoch,
                                                widgetBuilder: (_, time) {
                                                  if (time == null) {
                                                    return Text('Game over');
                                                  }
                                                  return Text(
                                                      '${time.hours}h:${time.min}m:${time.sec}s');
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              10, 5, 10, 0),
                                          child: const Text(
                                            "In-Progress",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 233, 206, 56),
                                              fontFamily: "SFPRO semibold",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            //   LikeButton(
                                            //     size: 30,
                                            //     circleColor: const CircleColor(
                                            //         start: Color(0xff00ddff),
                                            //         end: Color(0xff0099cc)),
                                            //     bubblesColor: const BubblesColor(
                                            //       dotPrimaryColor:
                                            //           Color(0xff33b5e5),
                                            //       dotSecondaryColor:
                                            //           Color(0xff0099cc),
                                            //     ),
                                            //     likeBuilder: (bool isLiked) {
                                            //       return Icon(
                                            //         Icons.thumb_up,
                                            //         color: isLiked
                                            //             ? Color.fromARGB(
                                            //                 255, 2, 95, 182)
                                            //             : Colors.grey,
                                            //         size: 30,
                                            //       );
                                            //     },
                                            //     likeCount: 665,
                                            //   ),
                                            //   LikeButton(
                                            //     size: 30,
                                            //     circleColor: const CircleColor(
                                            //         start: Color(0xff00ddff),
                                            //         end: Color(0xff0099cc)),
                                            //     bubblesColor: const BubblesColor(
                                            //       dotPrimaryColor:
                                            //           Color(0xff33b5e5),
                                            //       dotSecondaryColor:
                                            //           Color(0xff0099cc),
                                            //     ),
                                            //     likeBuilder: (bool isLiked) {
                                            //       return Icon(
                                            //         Icons.emoji_emotions,
                                            //         color: isLiked
                                            //             ? Color.fromARGB(
                                            //                 255, 2, 95, 182)
                                            //             : Colors.grey,
                                            //         size: 30,
                                            //       );
                                            //     },
                                            //     likeCount: 665,
                                            //   ),
                                            //   LikeButton(
                                            //     size: 30,
                                            //     circleColor: const CircleColor(
                                            //         start: Color.fromARGB(
                                            //             255, 226, 91, 82),
                                            //         end: Color.fromARGB(
                                            //             255, 226, 91, 82)),
                                            //     bubblesColor: const BubblesColor(
                                            //       dotPrimaryColor: Color.fromARGB(
                                            //           255, 226, 91, 82),
                                            //       dotSecondaryColor:
                                            //           Color.fromARGB(
                                            //               255, 226, 91, 82),
                                            //     ),
                                            //     likeBuilder: (bool isLiked) {
                                            //       return Icon(
                                            //         Icons.favorite,
                                            //         color: isLiked
                                            //             ? Color.fromARGB(
                                            //                 255, 226, 91, 82)
                                            //             : Colors.grey,
                                            //         size: 30,
                                            //       );
                                            //     },
                                            //     likeCount: 665,
                                            //   ),
                                          ]),
                                      const Text(
                                        "Points : 1000",
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 92, 91, 91),
                                            fontSize: 15,
                                            fontFamily: 'SFPRO regular'),
                                      )
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                          if (snapshot.data[index]['contest_status'] ==
                              "Upcoming Contest")
                            Container(
                              margin: EdgeInsets.fromLTRB(5, 7, 7, 5),
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Column(children: [
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              10, 5, 10, 0),
                                          child: Text(
                                            "${snapshot.data[index]['name']}",
                                            style: const TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontFamily: "SFPRO regular",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              10, 5, 10, 0),
                                          child: Text(
                                            "${snapshot.data[index]['name']}",
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontFamily: "SFPRO semibold",
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              10, 5, 10, 0),
                                          child: Row(
                                            children: [
                                              Text("Start In : "),
                                              CountdownTimer(
                                                endTime: DateTime.parse(
                                                        "${snapshot.data[index]['start_datetime']}")
                                                    .millisecondsSinceEpoch,
                                                widgetBuilder: (_, time) {
                                                  if (time == null) {
                                                    return Text('Game over');
                                                  }
                                                  return Text(
                                                      '${time.hours}h:${time.min}m:${time.sec}s');
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  10, 5, 0, 0),
                                              child: const Text(
                                                "Yes to start",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color.fromARGB(
                                                      255, 250, 151, 37),
                                                  fontFamily: "SFPRO semibold",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.fromLTRB(10, 20, 10, 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                LikeButton(
                                                  size: 30,
                                                  circleColor:
                                                      const CircleColor(
                                                          start:
                                                              Color(0xff00ddff),
                                                          end: Color(
                                                              0xff0099cc)),
                                                  bubblesColor:
                                                      const BubblesColor(
                                                    dotPrimaryColor:
                                                        Color(0xff33b5e5),
                                                    dotSecondaryColor:
                                                        Color(0xff0099cc),
                                                  ),
                                                  likeBuilder: (bool isLiked) {
                                                    return Icon(
                                                      Icons.thumb_up,
                                                      color: isLiked
                                                          ? Color.fromARGB(
                                                              255, 2, 95, 182)
                                                          : Colors.grey,
                                                      size: 30,
                                                    );
                                                  },
                                                  likeCount: 665,
                                                ),
                                                LikeButton(
                                                  size: 30,
                                                  circleColor:
                                                      const CircleColor(
                                                          start:
                                                              Color(0xff00ddff),
                                                          end: Color(
                                                              0xff0099cc)),
                                                  bubblesColor:
                                                      const BubblesColor(
                                                    dotPrimaryColor:
                                                        Color(0xff33b5e5),
                                                    dotSecondaryColor:
                                                        Color(0xff0099cc),
                                                  ),
                                                  likeBuilder: (bool isLiked) {
                                                    return Icon(
                                                      Icons.emoji_emotions,
                                                      color: isLiked
                                                          ? Color.fromARGB(
                                                              255, 2, 95, 182)
                                                          : Colors.grey,
                                                      size: 30,
                                                    );
                                                  },
                                                  likeCount: 665,
                                                ),
                                                LikeButton(
                                                  size: 30,
                                                  circleColor:
                                                      const CircleColor(
                                                          start: Color.fromARGB(
                                                              255, 226, 91, 82),
                                                          end: Color.fromARGB(
                                                              255,
                                                              226,
                                                              91,
                                                              82)),
                                                  bubblesColor:
                                                      const BubblesColor(
                                                    dotPrimaryColor:
                                                        Color.fromARGB(
                                                            255, 226, 91, 82),
                                                    dotSecondaryColor:
                                                        Color.fromARGB(
                                                            255, 226, 91, 82),
                                                  ),
                                                  likeBuilder: (bool isLiked) {
                                                    return Icon(
                                                      Icons.favorite,
                                                      color: isLiked
                                                          ? Color.fromARGB(
                                                              255, 226, 91, 82)
                                                          : Colors.grey,
                                                      size: 30,
                                                    );
                                                  },
                                                  likeCount: 665,
                                                ),
                                              ]),
                                          const Text(
                                            "Points : 1000",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 92, 91, 91),
                                                fontSize: 15,
                                                fontFamily: 'SFPRO regular'),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                            ),
                          if (snapshot.data[index]['contest_status'] ==
                              "Past Contest")
                            Container(
                              margin: EdgeInsets.fromLTRB(5, 7, 7, 5),
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Column(children: [
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              10, 5, 10, 0),
                                          child: Text(
                                            "${snapshot.data[index]['name']}",
                                            style: const TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontFamily: "SFPRO regular",
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              10, 5, 30, 0),
                                          child: Column(
                                            children: const [
                                              Icon(
                                                Icons.star,
                                                color: Color.fromARGB(
                                                    255, 228, 182, 58),
                                                size: 30,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              10, 5, 10, 0),
                                          child: Text(
                                            "${snapshot.data[index]['name']}",
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontFamily: "SFPRO semibold",
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 5, 12, 0),
                                          child: const Text(
                                            "winner",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: "SFPRO semibold",
                                                color: Color.fromARGB(
                                                    255, 8, 133, 12)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              10, 5, 0, 7),
                                          child: const Text(
                                            "Completed",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 30, 163, 13),
                                              fontFamily: "SFPRO semibold",
                                            ),
                                          ),
                                        ),
                                        Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                10, 5, 5, 7),
                                            child: Text(
                                              "Points : ${snapshot.data[index]['total_points']}",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 92, 91, 91),
                                                  fontSize: 15,
                                                  fontFamily: 'SFPRO regular'),
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ]),
                            )
                        ]);
                      }),
                );
              }
            }));
  }
}
