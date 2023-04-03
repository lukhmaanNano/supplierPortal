import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supplierportal/styles/Responsive.dart';
import '../styles/CommonTextStyle.dart';
import '../styles/common Color.dart';

class Status extends StatelessWidget {
  const Status({super.key});

  @override
  Widget build(BuildContext context) {
    var pe = '23', npo = '34', nm = '36';

    return Responsive(mobile: mobile(), desktop: web());
  }

  Widget mobile() {
    var pe = '23', npo = '34', nm = '36';
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 0.0, right: 0.0, top: 40, bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //help
                children: [
                  Text(
                    pe,
                    style: countStyle,
                  ),
                  const Text(
                    'Pending Enquiries',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w200),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //image
                children: [
                  Text(
                    npo,
                    style: countStyle,
                  ),
                  const Text(
                    'New Purchase Orders',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w200),
                  )
                ],
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //logout
                  children: [
                    Text(
                      nm,
                      style: countStyle,
                    ),
                    const Text(
                      'New Materials',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w200),
                    )
                  ]),
            ],
          ),
        ),
      ],
    );
  }

  Widget web() {
    return PopupMenuButton(
      splashRadius: 0.1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      offset: const Offset(5, 45),
      tooltip: 'Show Count',
      icon: const Icon(color: secondaryColor, CupertinoIcons.chart_pie_fill),
      iconSize: 25,
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          child: SizedBox(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Status', style: pageHeaderWeb),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 70,
                        child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            color: secondaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('21', style: webCountStyle),
                                  const Text(
                                    'Pending Enquiry',
                                    textAlign: TextAlign.center,
                                    style: webCountName,
                                  ),
                                ],
                              ),
                            )),
                      ),
                      SizedBox(
                        width: 90,
                        child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            color: secondaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text('21', style: webCountStyle),
                                  const SizedBox(
                                    width: 80,
                                    child: Text(
                                      'New Purchase Orders',
                                      textAlign: TextAlign.center,
                                      style: webCountName,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      SizedBox(
                        width: 70,
                        child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            color: secondaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text('21', style: webCountStyle),
                                  const SizedBox(
                                    width: 80,
                                    child: Text(
                                      'New Materials',
                                      textAlign: TextAlign.center,
                                      style: webCountName,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      )
                    ],
                  )
                ],
              )),
        )
      ],
    );
  }
}
