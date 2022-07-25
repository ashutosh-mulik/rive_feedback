import 'package:another_xlider/another_xlider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  double progress = 0;
  int _index = 0;
  SMINumber? _rivProg;
  List<Color> colors = const [
    Color(0xfffbbbeb),
    Color(0xfffbeabf),
    Color(0xffbbfbe3),
  ];
  final CarouselController _carouselController = CarouselController();

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(controller!);
    _rivProg = controller.findInput<double>('Progress') as SMINumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors[_index],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: const Icon(
          Icons.close,
          color: Colors.black,
        ),
        title: Text(
          "Ride finished",
          style: GoogleFonts.rubik(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "How was your ride?",
                textAlign: TextAlign.center,
                style: GoogleFonts.rubik(
                  color: Colors.black,
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: 300,
              child: CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                  height: 350.0,
                  viewportFraction: 0.98,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {},
                ),
                items: [
                  Text(
                    "Hideous",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.rubik(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    "Good",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.rubik(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    "Best",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.rubik(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: RiveAnimation.asset(
                'assets/feedback.riv',
                onInit: _onRiveInit,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: FlutterSlider(
                values: [progress],
                max: 100,
                min: 0,
                onDragging: (handlerIndex, lowerValue, upperValue) {
                  setState(() {
                    _rivProg?.change(lowerValue);
                    progress = lowerValue;
                  });

                  if (lowerValue < 30.0) {
                    _carouselController.animateToPage(0);
                    setState(() {
                      _index = 0;
                    });
                  }

                  if (lowerValue >= 30.0) {
                    _carouselController.animateToPage(1);
                    setState(() {
                      _index = 1;
                    });
                  }

                  if (lowerValue >= 80.0) {
                    _carouselController.animateToPage(2);
                    setState(() {
                      _index = 2;
                    });
                  }
                },
                tooltip: FlutterSliderTooltip(
                  disabled: true,
                ),
                trackBar: FlutterSliderTrackBar(
                  inactiveTrackBar: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black12,
                  ),
                  activeTrackBar: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.black26,
                  ),
                ),
                handler: FlutterSliderHandler(
                  decoration: const BoxDecoration(),
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: const CircleAvatar(
                    radius: 3,
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    "https://cdn-icons-png.flaticon.com/512/1370/1370907.png",
                    scale: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Add a comment",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.rubik(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Done",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rubik(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
