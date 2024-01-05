import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:spendit_test/features/shared/widgets/side_menu.dart';
import 'package:spendit_test/features/shared/widgets/app_bar_widget.dart';

List featuresImg = [
  SvgPicture.asset(
    'assets/img/features/fondos.svg',
    width: 80.0, // ajusta según sea necesario
    height: 80.0,
  ),
  SvgPicture.asset(
    'assets/img/features/gastos.svg',
    width: 80.0, // ajusta según sea necesario
    height: 80.0,
  ),
  SvgPicture.asset(
    'assets/img/features/rendicion.svg',
    width: 80.0, // ajusta según sea necesario
    height: 80.0,
  ),
  SvgPicture.asset(
    'assets/img/features/revision.svg',
    width: 80.0, // ajusta según sea necesario
    height: 80.0,
  )
];

List<String> featuresDescription = [
  "Automatiza la\nsolicitud de fondos",
  "Registra gastos",
  "Asocia gastos en\nuna rendición",
  "Revisa las rendiciones\n enviadas"
];

class HomeScreen extends StatefulWidget {
  static const name = "home_screeen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = CarouselController();
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
        key: scaffoldKey,
        backgroundColor: colors.inversePrimary.withAlpha(205).withOpacity(0.85),
        appBar: const AppBarWidget(title: "Home"),
        drawer: SideMenu(scaffoldKey: scaffoldKey),
        body: Column(children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text("SpendIT - CESEL",
                    style: TextStyle(
                      color: colors.primary,
                      fontWeight: FontWeight.w500,
                      fontSize: (MediaQuery.of(context).size.height >= 900
                          ? 46
                          : (MediaQuery.of(context).size.height >= 820
                              ? 40
                              : 35)),

                      // fontSize: 35,
                    )),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    shape: BoxShape
                        .circle, // Hace que el contenedor tenga forma circular
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      "assets/img/spendit.png",
                      width: 200,
                      height: 200,
                      fit: BoxFit
                          .cover, // Ajusta la imagen para cubrir completamente el círculo
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Rinde gastos en un santiamén...",
                  style: TextStyle(
                    color: colors.primary,
                    fontStyle: FontStyle.italic,
                    fontSize: (MediaQuery.of(context).size.height >= 900
                        ? 22
                        : (MediaQuery.of(context).size.height >= 820
                            ? 18
                            : 16)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: colors.inversePrimary,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    CarouselSlider.builder(
                      carouselController: controller,
                      itemCount: featuresImg.length,
                      itemBuilder: (context, index, realIndex) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: colors.primary.withOpacity(0.2),
                                        spreadRadius: 12,
                                        blurRadius: 10,
                                        offset: const Offset(0, 0),
                                      ),
                                    ],
                                    shape: BoxShape.circle,
                                  ),
                                  child: featuresImg[index]),
                            ),
                            const SizedBox(height: 10),
                            FittedBox(
                              child: Text(
                                featuresDescription[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: colors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      options: CarouselOptions(
                        autoPlay: true,
                        initialPage: 0,
                        autoPlayInterval: const Duration(seconds: 3),
                        onPageChanged: (index, reason) {
                          setState(() {
                            activeIndex = index;
                          });
                        },
                      ),
                    ),
                    buildIndicator(context),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ]));
  }

  Widget buildIndicator(context) => AnimatedSmoothIndicator(
        count: featuresImg.length,
        activeIndex: activeIndex,
        onDotClicked: animateToSlide,
        effect: JumpingDotEffect(
            activeDotColor: Theme.of(context).colorScheme.primary,
            dotColor: const Color.fromARGB(115, 221, 221, 221)),
      );

  void animateToSlide(int index) => controller.animateToPage(index);
}
