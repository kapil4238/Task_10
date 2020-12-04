import 'package:Task/DisplayDetails/details.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

class DisplayData extends StatefulWidget {
  List _userData;
  DisplayData(this._userData);
  @override
  _DisplayDataState createState() => _DisplayDataState();
}

class _DisplayDataState extends State<DisplayData> {
  List showData;
  String l = '2';
  Future _loadJson() async {
    var _loadJsonText = await rootBundle.loadString('assets/class.json');
    setState(() {
      showData = json.decode(_loadJsonText);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadJson();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        //Entire screen is divided into sliverappbar and sliverfillremaining
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: _height * 0.28,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  width: _width,
                  child: Image(
                    image: AssetImage('assets/background2.png'),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                            showData[index]['className'],
                            showData[index]['coachName'],
                            showData[index]['classType'],
                            showData[index]['classTiming'],
                            showData[index]['classImage'],
                            showData[index]['logInUserId'],
                            widget._userData,
                            showData),
                      ),
                    );
                  },
                  child: Container(
                    width: _width * 0.09,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black),
                    ),
                    margin: EdgeInsets.only(
                      top: _height * 0.011,
                    ),
                    padding: EdgeInsets.all(5),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(showData[index]['classImage']),
                            radius: 25,
                          ),
                          SizedBox(
                            width: _width * 0.05,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: _width * 0.6,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      showData[index]['className'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                    Text(
                                      showData[index]['coachName'],
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: _height * 0.01,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Coach:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                  SizedBox(
                                    width: _width * 0.006,
                                  ),
                                  Text(showData[index]['coachName'],
                                      style: TextStyle(fontSize: 12)),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Time:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                  SizedBox(
                                    width: _width * 0.008,
                                  ),
                                  Text(
                                    showData[index]['classTiming'],
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('2'),
                                  SizedBox(
                                    width: _width * 0.008,
                                  ),
                                  Text(
                                    "People",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                childCount: showData.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
