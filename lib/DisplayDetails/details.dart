import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:Task/MainScreen/mainscreen.dart';

class DetailPage extends StatefulWidget {
  String imageData, className, coachName, classType, classTiming, logInUser;

  List _userData, _data;
  DetailPage(this.className, this.coachName, this.classType, this.classTiming,
      this.logInUser, this.imageData, this._userData, this._data);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var count;
  List _loopData, _searchData;
  TextEditingController searchText = TextEditingController();
  Widget _searchTrailing(String id) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Text(
            "Add",
            style: TextStyle(color: Colors.blue[300]),
          ),
        ),
      ),
      onTap: () {
        setState(
          () {
            widget._data.add(id);
            count = (int.parse(count) + 1).toString();
            searchText.text = "";
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    count = widget.logInUser != null ? widget.logInUser.length.toString() : '0';

    _loopData = widget._data.toList();
    for (int i = 0; i < 5; i++) {
      if (!_loopData.contains((i + 1).toString())) {
        _loopData.add((i + 1).toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: _height * 0.325,
              stretch: true,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  width: _width,
                  child: Image(
                    image: AssetImage('assets/background1.png'),
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      widget.imageData != null
                          ? NetworkImage(widget.imageData)
                          : Container(),
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: _height * 0.04,
                              left: _height * 0.03,
                            ),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(
                        top: _height * 0.04,
                        left: _width * 0.07,
                        right: _width * 0.05,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.className,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(
                                width: _width * 0.015,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: _height * 0.008),
                                child: Text(
                                  widget.classType,
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Coach:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              SizedBox(
                                width: _width * 0.015,
                              ),
                              Text(
                                widget.coachName,
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Time:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              SizedBox(
                                width: _width * 0.015,
                              ),
                              Text(widget.classTiming,
                                  style: TextStyle(fontSize: 13)),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: SingleChildScrollView(
                                      child: Container(
                                        height: _height * 0.75,
                                        width: _width,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Members",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                                SizedBox(
                                                  width: _width * 0.05,
                                                ),
                                                Text(count + " People"),
                                              ],
                                            ),
                                            Container(
                                              height: _width * 0.15,
                                              width: _width * 0.65,
                                              margin: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.04),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: _width * 0.01,
                                                  ),
                                                  Icon(Icons.search),
                                                  SizedBox(
                                                    width: _width * 0.01,
                                                  ),
                                                  Expanded(
                                                    child: TextField(
                                                      controller: searchText,
                                                      decoration:
                                                          InputDecoration(
                                                        hintStyle: TextStyle(
                                                            fontSize: 16),
                                                        hintText:
                                                            'Search People',
                                                        border:
                                                            InputBorder.none,
                                                      ),
                                                      onChanged: (text) {
                                                        setState(() {
                                                          _searchData =
                                                              widget._userData
                                                                  .where(
                                                                    (v) => (v[
                                                                            "userName"]
                                                                        .toLowerCase()
                                                                        .contains(
                                                                          text.toLowerCase(),
                                                                        )),
                                                                  )
                                                                  .toList();
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: _height * 0.55,
                                              width: _width * 0.65,
                                              child: _searchData != null
                                                  ? _searchData.isNotEmpty
                                                      ? ListView.builder(
                                                          shrinkWrap: true,
                                                          itemCount: _searchData
                                                              .length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return ListTile(
                                                              leading:
                                                                  CircleAvatar(
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                        widget
                                                                            .imageData),
                                                              ),
                                                              title: Text(
                                                                _searchData[index]
                                                                        [
                                                                        'userName']
                                                                    .toString(),
                                                              ),
                                                              trailing: widget
                                                                      ._data
                                                                      .contains(
                                                                _searchData[index]
                                                                        [
                                                                        "userId"]
                                                                    .toString(),
                                                              )
                                                                  ? Text(" ")
                                                                  : _searchTrailing(
                                                                      _searchData[index]
                                                                              [
                                                                              "userId"]
                                                                          .toString(),
                                                                    ),
                                                            );
                                                          },
                                                        )
                                                      : Container()
                                                  : Container(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  count + " People",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(top: _height * 0.05),
                              decoration: BoxDecoration(
                                border: Border.all(width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  "Logout",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => MainScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
