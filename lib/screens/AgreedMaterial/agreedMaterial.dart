import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supplierportal/styles/Responsive.dart';
import 'package:supplierportal/widgets/divider.dart';
import '../../config.dart';
import '../../styles/CommonTextStyle.dart';
import '../../styles/common Color.dart';
import '../../widgets/mobileShimmer.dart';
import '../../widgets/shimmer.dart';

class AgreedMaterial extends StatefulWidget {
  const AgreedMaterial({Key? key}) : super(key: key);

  @override
  State<AgreedMaterial> createState() => _AgreedMaterialState();
}

class _AgreedMaterialState extends State<AgreedMaterial> {
  String? ip;
  int pageIndex = 1, initialPage = 0, rowPerPage = 10;
  late int userId, userGroupId;
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    local();
  }

  Future<void> local() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      ip = prefs.getString('ip');
      userGroupId = prefs.getInt('UserGroupID')!;
      userId = prefs.getInt('UserID')!;
    });
    purchaseApi();
  }

  Future<void> purchaseApi() async {
    const service = ApiConfig.api;
    final url = Uri.parse('$ip$service');
    final headers = {
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    final json =
        '{"data": {"p1": $userId,"p2": 0,"p3": 0,"p4": 0,"p5": 0,"p6": "","p7": "","p8": "","p9": "","p10": "","p11": $pageIndex,"p12": $rowPerPage,"p13": "VENDORMATLIST","p14": "$userGroupId","p15": "$userId"}}';
    final response =
        await http.post(url, headers: headers, body: json.toString());
    if (response.statusCode == 400) {
      String err = 'something went wrong!';
    } else {
      final String jsonString = jsonEncode(response.body);
      var decodedJson = jsonDecode(jsonString);
      Map<String, dynamic> map = jsonDecode(decodedJson);
      var result = map['Output']['data'];
      setState(() {
        data = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(mobile: mobile(), desktop: web());
  }

  Widget mobile() {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: secondaryColor,
        centerTitle: true,
        leading: IconButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(primaryColor),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            color: primaryColor,
            Icons.arrow_back,
            size: 30,
          ),
        ),
        title: const Text('Agreed Material List'),
      ),
      body: DraggableScrollableSheet(
        snap: true,
        minChildSize: 0.75,
        initialChildSize: 1,
        maxChildSize: 1.0,
        builder: (BuildContext context, ScrollController scrollController) =>
            Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                  color: Colors.white,
                ),
                child: Column(children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 25.0),
                    child: DividerWidget(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 15),
                          child: Container(
                              decoration: const BoxDecoration(
                                  color: Color(0xffAAAAAA),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              padding: const EdgeInsets.all(4.5),
                              child: Container(
                                padding: EdgeInsets.zero,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 10,
                                          spreadRadius: 10)
                                    ]),
                                width: double.infinity,
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Center(
                                        child: Icon(
                                          Icons.search,
                                          size: 25,
                                          color: grey100,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(color: grey100),
                                          border: InputBorder.none,
                                          hintText: 'Search',
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                  const DividerWidget(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.72,
                      width: double.infinity,
                      child: data.isEmpty
                          ? mobileShimmer(300)
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: SizedBox(
                                    height: 330,
                                    width: double.infinity,
                                    child: InkWell(
                                      onTap: () {},
                                      child: Card(
                                          elevation: 1,
                                          shadowColor: Colors.grey.shade50,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0,
                                                left: 8.0,
                                                bottom: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Material Code',
                                                        style: commonRoboto),
                                                    Text('Material Name',
                                                        style: commonRoboto),
                                                    Text('Main Class(Group)',
                                                        style: commonRoboto),
                                                    Text('Sub class(Group)',
                                                        style: commonRoboto),
                                                    Text('Make',
                                                        style: commonRoboto),
                                                    Text('Model',
                                                        style: commonRoboto),
                                                    Text('Material Type',
                                                        style: commonRoboto),
                                                  ],
                                                ),
                                                const SizedBox(width: 25),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        ': ${data[index]['MaterialCode']}',
                                                        style: cardValue),
                                                    SizedBox(
                                                      width: 180,
                                                      child: Text(
                                                          ': ${data[index]['MaterialName']}',
                                                          style: cardValue),
                                                    ),
                                                    Text(
                                                        ': ${data[index]['MainClass']}',
                                                        style: cardValue),
                                                    Text(
                                                        ': ${data[index]['SubClass']}',
                                                        style: cardValue),
                                                    Text(
                                                        ': ${data[index]['Make']}',
                                                        style: cardValue),
                                                    Text(
                                                        ': ${data[index]['Model']}',
                                                        style: cardValue),
                                                    Text(
                                                        ': ${data[index]['MaterialType']}',
                                                        style: cardValue),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),
                                );
                              }),
                    ),
                  )
                ])),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondaryColor,
        foregroundColor: Colors.white,
        onPressed: () {},
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }

  Widget web() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 180,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text('Agreed Material List', style: pageHeaderWeb),
                    ),
                    const Icon(Icons.cached, size: 22, color: secondaryColor),
                  ],
                ),
              ),
              SizedBox(
                width: 450,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          decoration: const BoxDecoration(
                              color: Color(0xffAAAAAA),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          padding: const EdgeInsets.all(4.5),
                          child: Container(
                            padding: EdgeInsets.zero,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.white,
                                      blurRadius: 10,
                                      spreadRadius: 10)
                                ]),
                            width: 200,
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 8.0, bottom: 8.0),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintStyle:
                                            TextStyle(color: secondaryColor),
                                        border: InputBorder.none,
                                        hintText: 'Search',
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Icon(
                                    Icons.search,
                                    size: 25,
                                    color: secondaryColor,
                                  ),
                                )
                              ],
                            ),
                          )),
                      const SizedBox(width: 10),
                      const Icon(Icons.filter_list, color: secondaryColor),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              color: primaryColor,
            ),
            height: 35,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 45, child: Text('Action', style: tileHeader)),
                  SizedBox(
                      width: 100,
                      child: Text('Material Code', style: tileHeader)),
                  SizedBox(
                      width: 180,
                      child: Text('Material Name', style: tileHeader)),
                  SizedBox(
                      width: 150,
                      child: Text('Main Class(Group)', style: tileHeader)),
                  SizedBox(
                      width: 150,
                      child: Text('Sub Class(Group)', style: tileHeader)),
                  SizedBox(width: 150, child: Text('Make', style: tileHeader)),
                  SizedBox(width: 150, child: Text('Model', style: tileHeader)),
                  SizedBox(
                      width: 150,
                      child: Text('Material Type', style: tileHeader)),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            height: 320,
            child: data.isEmpty
                ? webShimmer(double.infinity)
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (BuildContext Context, index) {
                      return ElasticInRight(
                          child: Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 45,
                                      child: InkWell(
                                        onTap: () {
                                          data[index]['MaterialID'];
                                          // detailView(data[index]['MaterialID']);
                                        },
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        child: const Icon(Icons.remove_red_eye,
                                            size: 14, color: secondaryColor),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        '${data[index]['MaterialCode'] ?? data[index]['MaterialCode']}',
                                        style: cardValue,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 180,
                                      child: Text(
                                        '${data[index]['MaterialName'] ?? data[index]['MaterialName']}',
                                        style: cardValue,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: Text(
                                        '${data[index]['MainClass'] ?? data[index]['MainClass']}',
                                        style: cardValue,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: Text(
                                        '${data[index]['SubClass'] ?? data[index]['SubClass']}',
                                        style: cardValue,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: Text(
                                        '${data[index]['Make'] ?? data[index]['Make']}',
                                        style: cardValue,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: Text(
                                        '${data[index]['Model'] ?? data[index]['Model']}',
                                        style: cardValue,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: Text(
                                        '${data[index]['MaterialType'] ?? data[index]['MaterialType']}',
                                        style: cardValue,
                                      ),
                                    ),
                                  ],
                                ),
                              )));
                    }),
          ),
        ),
        SizedBox(
          height: 35,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PopupMenuButton(
                constraints:
                    const BoxConstraints.expand(width: 55, height: 200),
                child: TextButton.icon(
                  label: Text('$rowPerPage'),
                  icon: const Icon(Icons.arrow_drop_down),
                  onPressed: null,
                ),
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  PopupMenuItem(
                      child: const Text('10', style: cardBody),
                      onTap: () => {
                            setState(() {
                              rowPerPage = 10;
                            }),
                          }),
                  PopupMenuItem(
                      child: const Text('20', style: cardBody),
                      onTap: () => {
                            setState(() {
                              rowPerPage = 20;
                            }),
                          }),
                  PopupMenuItem(
                      child: const Text('50', style: cardBody),
                      onTap: () => {
                            setState(() {
                              rowPerPage = 50;
                            }),
                          }),
                  PopupMenuItem(
                      child: const Text('100', style: cardBody),
                      onTap: () => {
                            setState(() {
                              rowPerPage = 100;
                            }),
                          }),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: SizedBox(
                    height: 30,
                    width: MediaQuery.of(context).size.width / 5.09,
                    child: NumberPaginator(
                      numberPages: 10,
                      onPageChange: (int index) {
                        setState(() {
                          pageIndex = index;
                        });
                        if (pageIndex != 0) {
                          pageIndex++;
                        } else {
                          pageIndex = 1;
                        }
                      },
                      initialPage: initialPage,
                      config: NumberPaginatorUIConfig(
                        buttonSelectedForegroundColor: Colors.white,
                        buttonUnselectedForegroundColor: secondaryColor,
                        buttonSelectedBackgroundColor: secondaryColor,
                        buttonShape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
