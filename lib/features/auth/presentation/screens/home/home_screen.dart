import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:spendit_test/features/shared/widgets/side_menu.dart';
import 'package:spendit_test/features/shared/widgets/app_bar_widget.dart';
import '../../providers/providers.dart';

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

class HomeScreen extends ConsumerStatefulWidget {
  static const name = "home_screeen";
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = CarouselController();
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: colors.inversePrimary.withOpacity(0.72),
        appBar: const AppBarWidget(title: "Home"),
        drawer: SideMenu(scaffoldKey: scaffoldKey),
        body: Column(children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const FaIcon(FontAwesomeIcons.dollarSign,
                      color: Color.fromARGB(255, 228, 167, 13)),
                  Text("SpendIT",
                      style: TextStyle(
                          color: colors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          fontStyle: FontStyle.italic)),
                  const FaIcon(FontAwesomeIcons.dollarSign,
                      color: Color.fromARGB(255, 228, 167, 13)),
                ]),
                const SizedBox(
                  height: 30,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            "Hola, ",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          Text(
                            ref
                                    .read(authProvider)
                                    .user
                                    ?.fullName
                                    .split(" ")
                                    .first
                                    .toUpperCase() ??
                                'Usuario no disponible',
                            style: TextStyle(
                                color: colors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      const Row(children: [
                        FaIcon(FontAwesomeIcons.handshakeAngle,
                            color: Color.fromARGB(255, 228, 167, 13)),
                        SizedBox(
                          width: 20,
                        ),
                      ]),
                    ]),
                const SizedBox(
                  height: 30,
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
                const Text(
                  "Rinde gastos en un santiamén...",
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 18,
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
                                        color: !ref
                                                .read(themeNotifierProvider)
                                                .isDarkmode
                                            ? colors.primary.withOpacity(0.2)
                                            : colors.primary.withOpacity(0.05),
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
                                  color: !ref
                                          .read(themeNotifierProvider)
                                          .isDarkmode
                                      ? Colors.black54
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
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
            dotColor: !ref.read(themeNotifierProvider).isDarkmode
                ? Colors.white
                : const Color.fromARGB(255, 108, 108, 108)),
      );

  void animateToSlide(int index) => controller.animateToPage(index);
}
