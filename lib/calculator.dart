import 'package:calci/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final p = PageController();
  int activeindex = 0;
  @override
  List<Widget> topbar() {
    List<Widget> t = [];
    return t;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  p.animateToPage(0,
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.linear);
                });
              },
              child: Container(
                child: Text(
                  "Calculator",
                  style: TextStyle(
                    fontSize: 23,
                    color: activeindex == 0
                        ? Colors.white
                        : Color.fromARGB(255, 169, 165, 165),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  p.animateToPage(1,
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.ease);
                  activeindex = 1;
                });
              },
              child: Container(
                child: Text(
                  "Convert",
                  style: TextStyle(
                    fontSize: 23,
                    color: activeindex == 1
                        ? Colors.white
                        : Color.fromARGB(255, 169, 165, 165),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            PopupMenuButton(
                color: Color.fromARGB(255, 28, 28, 28),
                offset: Offset(30, 40),
                iconColor: Colors.white,
                iconSize: 30,
                onSelected: (value) {
                  if (value == 'a') {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Home()));
                  }
                },
                itemBuilder: (context) => [
                      PopupMenuItem(
                        value: "a",
                        child: Text(
                          "History",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ]),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                controller: p,
                itemCount: 2,
                onPageChanged: (index) {
                  setState(() {
                    activeindex = index;
                  });
                },
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return calculatorpage();
                  }
                  if (index == 1) {
                    return convertpage();
                  }
                }),
          ),
        ],
      ),
    );
  }
}

class calculatorpage extends StatefulWidget {
  const calculatorpage({super.key});

  @override
  State<calculatorpage> createState() => _calculatorpageState();
}

class _calculatorpageState extends State<calculatorpage> {
  final controller = TextEditingController(text: "0");
  String optrators = "+/xX-%";
  void keypress(String s) {
    if (controller.text == '0') {
      setState(() {
        controller.text = s;
      });
    } else if (optrators.contains(s)) {
      setState(() {
        controller.text = calculator(controller.text).toString() + s;
      });
    } else {
      controller.text += s;
      setState(() {});
    }
  }

  double calculator(String s) {
    String s1 = "";
    String O = "";
    double A = 0;
    // String total="";
    for (var i = 0; i < s.length; i++) {
      if (optrators.contains(s[i])) {
        A = double.parse(s1);
        s1 = "";
        O = s[i];
      } else {
        s1 += s[i];
      }
    }

    if (O == '') {
      return double.parse(s1);
    } else if (O == '+') {
      return A + double.parse(s1);
    } else if (O == '-') {
      return A - double.parse(s1);
    } else if (O == 'x') {
      return A * double.parse(s1);
    } else if (O == '/') {
      return A / double.parse(s1);
    } else if (O == '%') {
      return A % double.parse(s1);
    } else {
      return A;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  controller.text,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          Wrap(
            children: [
              CalcButton(
                label: "C",
                onTap: () {
                  setState(() {
                    controller.text = "0";
                  });
                },
                fontcolor: Colors.orange,
              ),
              CalcButton(
                icon: Icons.backspace,
                onTap: () {
                  controller.text = controller.text
                      .substring(0, controller.text.length - 1);
                  setState(() {});
                },
                fontcolor: Colors.orange,
              ),
              GestureDetector(
                onTap: () {
                  controller.text = calculator(controller.text).toString();
                  setState(() {});
                },
                child: CalcButton(
                  label: "%",
                  onTap: () {
                    keypress("%");
                  },
                  fontcolor: Colors.orange,
                ),
              ),
              CalcButton(
                label: "/",
                onTap: () {
                  keypress("/");
                },
                fontcolor: Colors.orange,
              ),
              CalcButton(
                  label: "7",
                  onTap: () {
                    keypress("7");
                  }),
              CalcButton(
                  label: "8",
                  onTap: () {
                    keypress("8");
                  }),
              CalcButton(
                  label: "9",
                  onTap: () {
                    keypress("9");
                  }),
              CalcButton(
                label: "X",
                onTap: () {
                  keypress("x");
                },
                fontcolor: Colors.orange,
              ),
              CalcButton(
                  label: "4",
                  onTap: () {
                    keypress("4");
                  }),
              CalcButton(
                  label: "5",
                  onTap: () {
                    keypress("5");
                  }),
              CalcButton(
                  label: "6",
                  onTap: () {
                    keypress("6");
                  }),
              CalcButton(
                label: "-",
                onTap: () {
                  keypress("-");
                },
                fontcolor: Colors.orange,
              ),
              CalcButton(
                  label: "1",
                  onTap: () {
                    keypress("1");
                  }),
              CalcButton(
                  label: "2",
                  onTap: () {
                    keypress("2");
                  }),
              CalcButton(
                  label: "3",
                  onTap: () {
                    keypress("3");
                  }),
              CalcButton(
                label: "+",
                onTap: () {
                  keypress("+");
                },
                fontcolor: Colors.orange,
              ),
              Container(
                margin: EdgeInsets.all(10),
                alignment: Alignment.center,
                height: 75,
                width: 75,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 49, 48, 48),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Icon(Icons.backup_table_sharp,
                    color: Colors.orange, size: 35),
              ),
              CalcButton(
                  label: "0",
                  onTap: () {
                    keypress("0");
                  }),
              CalcButton(
                  label: ".",
                  onTap: () {
                    keypress(".");
                  }),
              CalcButton(
                  label: "=",
                  onTap: () {
                    controller.text =
                        calculator(controller.text).toString();
                    setState(() {});
                  },
                  color: Colors.orange),
            ],
          ),
        ],
      ),
    );
  }
}

class convertpage extends StatefulWidget {
  const convertpage({super.key});
  @override
  State<convertpage> createState() => _convertpageState();
}

class _convertpageState extends State<convertpage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Wrap(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              height: 75,
              width: 75,
              child: Column(
                children: [
                  Icon(
                    Icons.currency_rupee_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
                  Text(
                    "Currency",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              height: 75,
              width: 75,
              child: Column(
                children: [
                  Icon(
                    Icons.leaderboard_rounded,
                    color: Colors.white,
                    size: 35,
                  ),
                  Text(
                    "Length",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              height: 75,
              width: 75,
              child: Column(
                children: [
                  Icon(
                    Icons.panorama_wide_angle_select_sharp,
                    color: Colors.white,
                    size: 35,
                  ),
                  Text(
                    "Mass",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              height: 75,
              width: 75,
              child: Column(
                children: [
                  Icon(
                    Icons.article_sharp,
                    color: Colors.white,
                    size: 35,
                  ),
                  Text(
                    "Area",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              height: 75,
              width: 75,
              child: Column(
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    color: Colors.white,
                    size: 35,
                  ),
                  Text(
                    "Time",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              height: 75,
              width: 75,
              child: Column(
                children: [
                  Icon(
                    Icons.home_max_rounded,
                    color: Colors.white,
                    size: 35,
                  ),
                  Text(
                    "Data",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              height: 75,
              width: 75,
              child: Column(
                children: [
                  Icon(
                    Icons.discount,
                    color: Colors.white,
                    size: 35,
                  ),
                  Text(
                    "Discount",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              height: 75,
              width: 75,
              child: Column(
                children: [
                  Icon(
                    Icons.view_in_ar_sharp,
                    color: Colors.white,
                    size: 35,
                  ),
                  Text(
                    "Volume",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              height: 80,
              width: 75,
              child: Column(
                children: [
                  Icon(
                    Icons.repeat_one,
                    color: Colors.white,
                    size: 35,
                  ),
                  Text(
                    "Numeral\n system",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              height: 75,
              width: 80,
              child: Column(
                children: [
                  Icon(
                    Icons.speed_sharp,
                    color: Colors.white,
                    size: 35,
                  ),
                  Text(
                    "Speed",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              height: 75,
              width: 88,
              child: Column(
                children: [
                  Icon(
                    Icons.device_thermostat_rounded,
                    color: Colors.white,
                    size: 35,
                  ),
                  Text(
                    "Temperature",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              height: 75,
              width: 80,
              child: Column(
                children: [
                  Icon(
                    Icons.scale_rounded,
                    color: Colors.white,
                    size: 35,
                  ),
                  Text(
                    "BMI",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              height: 75,
              width: 75,
              child: Column(
                children: [
                  Icon(
                    Icons.sticky_note_2_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
                  Text(
                    "GST",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalcButton extends StatelessWidget {
  const CalcButton({
    super.key,
    this.label,
    required this.onTap,
    this.color = const Color.fromARGB(255, 49, 48, 48),
    this.fontcolor = Colors.white,
    this.icon,
  });
  final String? label;
  final IconData? icon;
  final Function() onTap;
  final Color color;
  final Color fontcolor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: 75,
      height: 75,
      decoration: BoxDecoration(
          // color: color,
          // borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
      child: Material(
        color: Colors.black,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          // hoverColor: Colors.red,
          // focusColor: Colors.red,
          // splashColor: Colors.red,
          // highlightColor: Colors.red,
          onTap: onTap,
          child: Center(
            child: label != null
                ? Text(label!,
                    style: TextStyle(
                      color: fontcolor,
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ))
                : Icon(
                    icon,
                    color: fontcolor,
                    size: 30,
                  ),
          ),
        ),
      ),
    );
  }
}
