import 'package:event_managemnet/model/event_model.dart';
import 'package:event_managemnet/screens/constants.dart';
import 'package:event_managemnet/screens/drawing_screen.dart';
import 'package:event_managemnet/screens/home_page.dart';
import 'package:event_managemnet/screens/notifctaions_page.dart';
import 'package:event_managemnet/screens/registration_page.dart';
import 'package:event_managemnet/screens/user_profile_page.dart';
import 'package:event_managemnet/screens/view_events_page.dart';
import 'package:event_managemnet/screens/widgets/bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

/// Created by Ussama Iftikhar on 02-Jan-2021.

/// Email iusama46@gmail.com

/// Email iusama466@gmail.com

/// Github https://github.com/iusama46


Future<void> main() async {
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static var email = 'k';
  Event event = Event(name: '11', date: '11', time: '111');

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.white,

        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CheckUser()
    );
  }
}

class CheckUser extends StatefulWidget {
  static var name = 'test user';

  @override
  _CheckUserState createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  Box box;

  void openDir() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('user');

    if (box.get('isLogin') == null) {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegistrationPage()),
      );
    }

    if (box.get('isLogin')) {
      CheckUser.name = box.get('fullName').toString();
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    } else {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegistrationPage()),
      );
    }

    return;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
            child: Text(
              kAppName,
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.0,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    openDir();
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final List pages = [
    HomePage(),
    ViewEventsPage(),
    // Draw(),
    // DrawPaint(),
    NotificationsPage(),
    //Profile(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(
        onChange: (val) {
          setState(() {
            _selectedIndex = val;
          });
        },
      ),
      body: pages[_selectedIndex],
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Offset loct;
Color color = Colors.red;

class _MyHomePageState extends State<MyHomePage> {
  double posx = 100.0;
  double posy = 100.0;
  Size size = Size.zero;
  Size center;
  Alignment alignment = Alignment(-1, -1);
  double paddingTop;
  List<Size> points = [];
  List<Offset> pointsOffset = [];

  void onTapDown(TapDownDetails details) {
    setState(() {
      color = Colors.black;
    });
    print('${details.globalPosition} ${size.toString()}');
    final RenderBox box = context.findRenderObject();
    loct = details.globalPosition;
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    print(
        '${details.globalPosition} ${size.toString()} center ${(center.width / size.width).toString()}');

    posx = localOffset.dx;
    posy = localOffset.dy;
    calculate();
  }

  calculate() {
    points.add(Size(posx, posy));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ///SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    size = MediaQuery.of(context).size;
    //paddingTop = MediaQuery.of(context).padding.top;
    center = size * 0.5;

    return Scaffold(
      body: GestureDetector(
        onTapDown: onTapDown,
        onTapUp: (val) {},
        child: Container(
          height: 400.0,
          width: size.width,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/delpaintt.png"),
                  ),
                ),
              ),
              CustomPaint(
                size: MediaQuery.of(context).size,
                painter: FaceOutlinePainter(),
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class FaceOutlinePainter extends CustomPainter {
  final List<Offset> points;

  FaceOutlinePainter({this.points});

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: draw something with canvas
    // final paint = Paint()
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 18.0
    //   ..color = Colors.indigo;

    // var paint = Paint()
    //   ..color = color
    //   ..strokeWidth = 5
    //   //..style = PaintingStyle.stroke
    //   ..strokeCap = StrokeCap.round;
    //
    // Offset center = Offset(size.width / 2, size.height / 2);
    //
    // canvas.drawCircle(loct, 10, paint);
  }

  @override
  bool shouldRepaint(FaceOutlinePainter oldDelegate) {
    return true;
    //return oldDelegate.points != points;
  }
}

class DrawingPoints {
  Paint paint;
  Offset points;

  DrawingPoints({this.points, this.paint});
}
