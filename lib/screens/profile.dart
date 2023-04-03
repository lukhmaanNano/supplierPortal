import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';
import '../model/Login/login.dart';
import '../styles/common Color.dart';
import '../widgets/toaster.dart';
import 'faq.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? userName;
  int? sessionId;
  @override
  void initState() {
    super.initState();
    local();
  }

  Future<void> local() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('UserName')!;
      sessionId = prefs.getInt('SessionId')!;
    });
  }

  Future<void> logOutFunction() async {
    String ip = ApiConfig.loginService;
    String URL = 'CommonCustomUpdate/';
    final url = Uri.parse('$ip$URL');
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final json = '{"data": {"SessionID": "$sessionId"}}';
    final response =
        await http.post(url, headers: headers, body: json.toString());
    if (response.statusCode == 400) {
      String err = 'something went wrong!';
      toaster(context, err);
    } else {
      final datas = jsonDecode(response.body);
      var statusVal = ('${datas['Output']['status']['code']}');
      if (statusVal == "200") {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('SessionId');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      } else {
        final datas = jsonDecode(response.body);
        String error = ('${datas['Output']['status']['code']['message']}');
        toaster(context, error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String name = utf8.decode(base64.decode(userName!));
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 0.0, right: 0.0, top: 20, bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                //help
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const Faq();
                        }),
                      );
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(color: Colors.black26, blurRadius: 5)
                        ],
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(0.2, 1),
                          colors: <Color>[
                            Color(0xffE4F5FF),
                            primaryColor,
                          ],
                          tileMode: TileMode.mirror,
                        ),
                      ),
                      child: const Icon(
                        Icons.question_mark_rounded,
                        size: 30,
                        color: secondaryColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 0.0, right: 0.0, top: 3.0, bottom: 0),
                    child: const Text(
                      'Help',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
              Column(
                //image
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xFF8CA5B3), width: 2),
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 5)
                      ],
                      color: primaryColor,
                      image: const DecorationImage(
                        image: AssetImage('assets/images/man.jpg'),
                        fit: BoxFit.cover,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 0.0, right: 0.0, top: 10.0, bottom: 0),
                    child: Text(
                      name,
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
              Column(
                  //logout
                  children: [
                    TextButton(
                      onPressed: () {
                        logOutAlert();
                      },
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: const [
                            BoxShadow(color: Colors.black26, blurRadius: 5)
                          ],
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment(0.2, 1),
                            colors: <Color>[
                              Color(0xffE4F5FF),
                              primaryColor,
                            ],
                            tileMode: TileMode.mirror,
                          ),
                        ),
                        child: const Icon(
                          Icons.power_settings_new_outlined,
                          size: 30,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 0.0, right: 0.0, top: 3.0, bottom: 0),
                      child: const Text(
                        'Log Out',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ]),
            ],
          ),
        ),
      ],
    );
  }

  logOutAlert() {
    double passwordWidth = MediaQuery.of(context).size.width * 0.08;
    showDialog(
      context: context,
      builder: (ctx) => ElasticIn(
        child: Dialog(
          backgroundColor: primaryColor,
          elevation: 13,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SizedBox(
            height: 200,
            width: passwordWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.logout, color: secondaryColor),
                const SizedBox(height: 10),
                const Text("Confirmation !",
                    style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 0.4,
                        fontWeight: FontWeight.w300,
                        color: black)),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                  child: Text("Are you sure you want to logout",
                      style: TextStyle(
                          fontSize: 13,
                          letterSpacing: 0.3,
                          fontWeight: FontWeight.w400,
                          color: black)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: const ButtonStyle(
                          overlayColor:
                              MaterialStatePropertyAll(Colors.transparent),
                        ),
                        onPressed: () async {
                          Navigator.of(ctx).pop();
                        },
                        child: const Text("No",
                            style: TextStyle(color: secondaryColor)),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(90, 40),
                          maximumSize: const Size(90, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          primary: secondaryColor,
                        ),
                        onPressed: () {
                          logOutFunction();
                          Navigator.of(ctx).pop();
                        },
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
