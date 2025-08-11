import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/config/routes_config.dart';
import 'package:hanae_app/core/constants/images.dart';
import 'package:hanae_app/core/constants/themes.dart';
import 'package:hanae_app/core/utils/responsive.dart';
import 'package:hanae_app/ui/widgets/home_widgets/custom_search_bar.dart';
import 'package:hanae_app/ui/widgets/home_widgets/sport_chip.dart';
import 'package:hanae_app/ui/widgets/home_widgets/field_card.dart';
import 'package:hanae_app/ui/widgets/home_widgets/trainer_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeMainScreen extends StatefulWidget {
  const HomeMainScreen({super.key});
  @override
  State<HomeMainScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  int selectedCategory = 0;
  bool isGridOpen = false;

  List<Map<String, String>> sportCategories = [
    {"label": "Boxing", "icon": AppImages.boxing},
    {"label": "Football", "icon": AppImages.football},
    {"label": "Tennis", "icon": AppImages.tennis},
  ];

  final List<Map<String, String>> allSports = [
    {"label": "Boxing", "icon": AppImages.boxing},
    {"label": "Football", "icon": AppImages.football},
    {"label": "Tennis", "icon": AppImages.tennis},
    {"label": "Padel", "icon": AppImages.padel},
    {"label": "Basketball", "icon": AppImages.basketball},
    {"label": "Yoga", "icon": AppImages.yoga},
  ];

  @override
  void initState() {
    super.initState();
    _loadSportCategories();
  }

  Future<void> _loadSportCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('selected_sports');
    if (saved != null && saved.length == sportCategories.length * 2) {
      setState(() {
        for (int i = 0; i < sportCategories.length; i++) {
          sportCategories[i] = {
            'label': saved[i * 2],
            'icon': saved[i * 2 + 1],
          };
        }
      });
    }
  }

  Future<void> _saveSportCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final flat = <String>[];
    for (var item in sportCategories) {
      flat.add(item['label']!);
      flat.add(item['icon']!);
    }
    await prefs.setStringList('selected_sports', flat);
  }

  final List<Map<String, dynamic>> fields = [
    {
      "image": AppImages.footballField,
      "name": "Football Field",
      "price": "AED 200 / hour",
      "distance": "1.5 km away",
    },
    {
      "image": AppImages.tennisField,
      "name": "Tennis Field",
      "price": "AED 100 / hour",
      "distance": "3.5 km away",
    },
    {
      "image": AppImages.boxingField,
      "name": "Boxing Hall",
      "price": "AED 300 / hour",
      "distance": "4.0 km away",
    },
  ];

  final List<Map<String, dynamic>> trainers = [
    {
      "image": AppImages.trainer1,
      "name": "Kovazitch Iron",
      "sport": "kickboxing",
      "rating": 4.8,
      "price": "AED 200 / hour",
      "distance": "1.5 km away",
      "isCertified": true,
      "status": "Available today"
    },
    {
      "image": AppImages.trainer2,
      "name": "ramos edirson",
      "sport": "kickboxing",
      "rating": 3.9,
      "price": "AED 500 / hour",
      "distance": "1.5 km away",
      "isCertified": false,
      "status": "No Certified"
    },
  ];

  void _showSportsDialog(BuildContext context, Responsive r) async {
    setState(() => isGridOpen = true);
    int current = selectedCategory;

    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => Center(
        child: Container(
          width: r.wp(0.85),
          height: r.hp(0.5),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.inputDark,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Select Sport",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: r.sp(0.040),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  children: allSports.map((sport) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        setState(() {
                          sportCategories[current] = sport;
                          isGridOpen = false;
                        });
                        _saveSportCategories();
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.greenAccent.withOpacity(0.09),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: SvgPicture.asset(
                              sport['icon']!,
                              width: r.wp(0.09),
                              height: r.wp(0.09),
                              color: AppColors.greenAccent,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            sport['label']!,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    setState(() => isGridOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.market); 
        },
        backgroundColor: AppColors.greenAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: SvgPicture.asset(
          AppImages.supplements4, // أيقونة الماركت (SVG)
          width: 26,
          height: 26,
          color: Colors.black, // غيّر اللون حسب الحاجة
        ),
        tooltip: "Supplements Market",
        elevation: 2.5,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.only(
              left: r.wp(0.045),
              right: r.wp(0.045),
              top: r.hp(0.03),
              bottom: r.hp(0.01),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  AppImages.logo,
                  width: r.wp(0.12),
                  height: r.wp(0.12),
                ),
                const Spacer(),
                CircleAvatar(
                  radius: r.wp(0.055),
                  backgroundImage: AssetImage(AppImages.user),
                ),
              ],
            ),
          ),
          // Search + Filter
          Padding(
            padding: EdgeInsets.symmetric(horizontal: r.wp(0.045)),
            child: Row(
              children: [
                Expanded(child: CustomSearchBar()),
                SizedBox(width: r.wp(0.022)),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.inputDark,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.all(r.wp(0.022)),
                  child: Icon(Icons.filter_list, color: Colors.white, size: r.wp(0.048)),
                ),
              ],
            ),
          ),
          SizedBox(height: r.hp(0.026)),
          // Categories + Grid Toggle
          Padding(
            padding: EdgeInsets.only(left: r.wp(0.045), right: r.wp(0.025)),
            child: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        sportCategories.length,
                        (i) => Padding(
                          padding: EdgeInsets.only(right: r.wp(0.023)),
                          child: SportChip(
                            label: sportCategories[i]["label"]!,
                            iconPath: sportCategories[i]["icon"]!,
                            isSelected: selectedCategory == i,
                            onTap: () => setState(() => selectedCategory = i),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: r.wp(0.01)),
                GestureDetector(
                  onTap: () {
                    if (!isGridOpen) _showSportsDialog(context, r);
                    else setState(() => isGridOpen = false);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.inputDark,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(r.wp(0.016)),
                    child: Icon(
                      isGridOpen ? Icons.close : Icons.grid_view,
                      color: AppColors.greenAccent,
                      size: r.wp(0.055),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: r.hp(0.024)),
          // Sports Fields title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: r.wp(0.045)),
            child: Text(
              'Sports Fields',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: r.sp(0.042),
              ),
            ),
          ),
          SizedBox(height: r.hp(0.013)),
          // Sports Fields cards
          SizedBox(
            height: r.hp(0.22),
            child: ListView.separated(
              padding: EdgeInsets.only(left: r.wp(0.045)),
              scrollDirection: Axis.horizontal,
              itemCount: fields.length,
              separatorBuilder: (_, __) => SizedBox(width: r.wp(0.028)),
              itemBuilder: (context, i) {
                final field = fields[i];
                return FieldCard(
                  imagePath: field["image"] ?? "",
                  name: field["name"] ?? "",
                  price: field["price"] ?? "",
                  distance: field["distance"] ?? "",
                  onTap: () {},
                );
              },
            ),
          ),
          // Trainers section
          Padding(
            padding: EdgeInsets.fromLTRB(
                r.wp(0.045), r.hp(0.03), r.wp(0.045), r.hp(0.01)),
            child: Text(
              'Trainers',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: r.sp(0.042),
              ),
            ),
          ),
          // Trainers Cards
          Padding(
            padding: EdgeInsets.symmetric(horizontal: r.wp(0.035)),
            child: Column(
              children: trainers
                  .map((trainer) => Padding(
                        padding: EdgeInsets.only(bottom: r.hp(0.017)),
                        child: TrainerCard(
                          imagePath: trainer["image"],
                          name: trainer["name"],
                          sport: trainer["sport"],
                          rating: trainer["rating"],
                          price: trainer["price"],
                          distance: trainer["distance"],
                          isCertified: trainer["isCertified"],
                          status: trainer["status"],
                        ),
                      ))
                  .toList(),
            ),
          ),
          SizedBox(height: r.hp(0.015)),
        ],
      ),
    );
  }
}









// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/route_manager.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hanae_app/core/config/routes_config.dart';
// import 'package:hanae_app/core/constants/images.dart';
// import 'package:hanae_app/core/constants/themes.dart';
// import 'package:hanae_app/core/utils/responsive.dart';
// import 'package:hanae_app/ui/widgets/home_widgets/custom_search_bar.dart';
// import 'package:hanae_app/ui/widgets/home_widgets/sport_chip.dart';
// import 'package:hanae_app/ui/widgets/home_widgets/field_card.dart';
// import 'package:hanae_app/ui/widgets/home_widgets/trainer_card.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class HomeMainScreen extends StatefulWidget {
//   const HomeMainScreen({super.key});
//   @override
//   State<HomeMainScreen> createState() => _HomeMainScreenState();
// }

// class _HomeMainScreenState extends State<HomeMainScreen> {
//   int selectedCategory = 0;
//   bool isGridOpen = false;

//   List<Map<String, String>> sportCategories = [
//     {"label": "Boxing", "icon": AppImages.boxing},
//     {"label": "Football", "icon": AppImages.football},
//     {"label": "Tennis", "icon": AppImages.tennis},
//   ];

//   final List<Map<String, String>> allSports = [
//     {"label": "Boxing", "icon": AppImages.boxing},
//     {"label": "Football", "icon": AppImages.football},
//     {"label": "Tennis", "icon": AppImages.tennis},
//     {"label": "Padel", "icon": AppImages.padel},
//     {"label": "Basketball", "icon": AppImages.basketball},
//     {"label": "Yoga", "icon": AppImages.yoga},
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _loadSportCategories();
//   }

//   Future<void> _loadSportCategories() async {
//     final prefs = await SharedPreferences.getInstance();
//     final saved = prefs.getStringList('selected_sports');
//     if (saved != null && saved.length == sportCategories.length * 2) {
//       setState(() {
//         for (int i = 0; i < sportCategories.length; i++) {
//           sportCategories[i] = {
//             'label': saved[i * 2],
//             'icon': saved[i * 2 + 1],
//           };
//         }
//       });
//     }
//   }

//   Future<void> _saveSportCategories() async {
//     final prefs = await SharedPreferences.getInstance();
//     final flat = <String>[];
//     for (var item in sportCategories) {
//       flat.add(item['label']!);
//       flat.add(item['icon']!);
//     }
//     await prefs.setStringList('selected_sports', flat);
//   }

//   final List<Map<String, dynamic>> fields = [
//     {
//       "image": AppImages.footballField,
//       "name": "Football Field",
//       "price": "AED 200 / hour",
//       "distance": "1.5 km away",
//     },
//     {
//       "image": AppImages.tennisField,
//       "name": "Tennis Field",
//       "price": "AED 100 / hour",
//       "distance": "3.5 km away",
//     },
//     {
//       "image": AppImages.boxingField,
//       "name": "Boxing Hall",
//       "price": "AED 300 / hour",
//       "distance": "4.0 km away",
//     },
//   ];

//   final List<Map<String, dynamic>> trainers = [
//     {
//       "image": AppImages.trainer1,
//       "name": "Kovazitch Iron",
//       "sport": "kickboxing",
//       "rating": 4.8,
//       "price": "AED 200 / hour",
//       "distance": "1.5 km away",
//       "isCertified": true,
//       "status": "Available today"
//     },
//     {
//       "image": AppImages.trainer2,
//       "name": "ramos edirson",
//       "sport": "kickboxing",
//       "rating": 3.9,
//       "price": "AED 500 / hour",
//       "distance": "1.5 km away",
//       "isCertified": false,
//       "status": "No Certified"
//     },
//   ];

//   void _showSportsDialog(BuildContext context, Responsive r) async {
//     setState(() => isGridOpen = true);
//     int current = selectedCategory;

//     await showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (_) => Center(
//         child: Container(
//           width: r.wp(0.85),
//           height: r.hp(0.5),
//           padding: const EdgeInsets.all(18),
//           decoration: BoxDecoration(
//             color: AppColors.inputDark,
//             borderRadius: BorderRadius.circular(28),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 "Select Sport",
//                 style: GoogleFonts.poppins(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: r.sp(0.040),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Expanded(
//                 child: GridView.count(
//                   crossAxisCount: 3,
//                   mainAxisSpacing: 14,
//                   crossAxisSpacing: 14,
//                   children: allSports.map((sport) {
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).pop();
//                         setState(() {
//                           sportCategories[current] = sport;
//                           isGridOpen = false;
//                         });
//                         _saveSportCategories();
//                       },
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                               color: AppColors.greenAccent.withOpacity(0.09),
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             child: SvgPicture.asset(
//                               sport['icon']!,
//                               width: r.wp(0.09),
//                               height: r.wp(0.09),
//                               color: AppColors.greenAccent,
//                             ),
//                           ),
//                           const SizedBox(height: 6),
//                           Text(
//                             sport['label']!,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w600,
//                               fontSize: 13,
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//     setState(() => isGridOpen = false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final r = Responsive.of(context);

//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           // Header + كبسولة الماركت بشكل مميز
//           Padding(
//             padding: EdgeInsets.only(
//               left: r.wp(0.045),
//               right: r.wp(0.045),
//               top: r.hp(0.03),
//               bottom: r.hp(0.01),
//             ),
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 Row(
//                   children: [
//                     SvgPicture.asset(
//                       AppImages.logo,
//                       width: r.wp(0.12),
//                       height: r.wp(0.12),
//                     ),
//                     const Spacer(),
//                     CircleAvatar(
//                       radius: r.wp(0.055),
//                       backgroundImage: AssetImage(AppImages.user),
//                     ),
//                   ],
//                 ),
//                 // كبسولة الماركت في المنتصف
//                 Positioned.fill(
//                   child: Align(
//                     alignment: Alignment.center,
//                     child: GestureDetector(
//                       onTap: () {
//                         Get.toNamed(AppRoutes.market); 
//                       },
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(24),
//                         child: BackdropFilter(
//                           filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//                           child: Container(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: r.wp(0.028), vertical: r.hp(0.011)),
//                             decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                 colors: [
//                                   AppColors.greenAccent.withOpacity(0.34),
//                                   Colors.black.withOpacity(0.15),
//                                 ],
//                                 begin: Alignment.topLeft,
//                                 end: Alignment.bottomRight,
//                               ),
//                               borderRadius: BorderRadius.circular(22),
//                               border: Border.all(
//                                   color: AppColors.greenAccent.withOpacity(0.45), width: 1),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: AppColors.greenAccent.withOpacity(0.10),
//                                   blurRadius: 10,
//                                   offset: Offset(0, 2),
//                                 ),
//                               ],
//                             ),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 SvgPicture.asset(
//                                   AppImages.supplements4,
//                                   width: r.wp(0.048),
//                                   height: r.wp(0.048),
//                                   color: AppColors.greenAccent,
//                                 ),
//                                 SizedBox(width: 7),
//                                 Text(
//                                   "Market Sports Supplements",
//                                   style: GoogleFonts.poppins(
//                                     color: AppColors.greenAccent,
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: r.sp(0.023),
//                                     letterSpacing: 0.09,
//                                   ),
//                                 ),
//                                 SizedBox(width: 8),
//                                 Container(
//                                   padding: EdgeInsets.all(5),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white.withOpacity(0.11),
//                                     borderRadius: BorderRadius.circular(11),
//                                   ),
//                                   child: Icon(
//                                     Icons.shopping_cart_outlined,
//                                     size: r.sp(0.027),
//                                     color: AppColors.greenAccent,
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // باقي الصفحة كما هو ... (بحث, كاتيجوري, الحقول, المدربين)
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: r.wp(0.045)),
//             child: Row(
//               children: [
//                 Expanded(child: CustomSearchBar()),
//                 SizedBox(width: r.wp(0.022)),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: AppColors.inputDark,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   padding: EdgeInsets.all(r.wp(0.022)),
//                   child: Icon(Icons.filter_list, color: Colors.white, size: r.wp(0.048)),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: r.hp(0.026)),
//           // Categories + Grid Toggle
//           Padding(
//             padding: EdgeInsets.only(left: r.wp(0.045), right: r.wp(0.025)),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       children: List.generate(
//                         sportCategories.length,
//                         (i) => Padding(
//                           padding: EdgeInsets.only(right: r.wp(0.023)),
//                           child: SportChip(
//                             label: sportCategories[i]["label"]!,
//                             iconPath: sportCategories[i]["icon"]!,
//                             isSelected: selectedCategory == i,
//                             onTap: () => setState(() => selectedCategory = i),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: r.wp(0.01)),
//                 GestureDetector(
//                   onTap: () {
//                     if (!isGridOpen) _showSportsDialog(context, r);
//                     else setState(() => isGridOpen = false);
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: AppColors.inputDark,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     padding: EdgeInsets.all(r.wp(0.016)),
//                     child: Icon(
//                       isGridOpen ? Icons.close : Icons.grid_view,
//                       color: AppColors.greenAccent,
//                       size: r.wp(0.055),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: r.hp(0.024)),
//           // Sports Fields title
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: r.wp(0.045)),
//             child: Text(
//               'Sports Fields',
//               style: GoogleFonts.poppins(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: r.sp(0.042),
//               ),
//             ),
//           ),
//           SizedBox(height: r.hp(0.013)),
//           // Sports Fields cards
//           SizedBox(
//             height: r.hp(0.22),
//             child: ListView.separated(
//               padding: EdgeInsets.only(left: r.wp(0.045)),
//               scrollDirection: Axis.horizontal,
//               itemCount: fields.length,
//               separatorBuilder: (_, __) => SizedBox(width: r.wp(0.028)),
//               itemBuilder: (context, i) {
//                 final field = fields[i];
//                 return FieldCard(
//                   imagePath: field["image"] ?? "",
//                   name: field["name"] ?? "",
//                   price: field["price"] ?? "",
//                   distance: field["distance"] ?? "",
//                   onTap: () {},
//                 );
//               },
//             ),
//           ),
//           // Trainers section
//           Padding(
//             padding: EdgeInsets.fromLTRB(
//                 r.wp(0.045), r.hp(0.03), r.wp(0.045), r.hp(0.01)),
//             child: Text(
//               'Trainers',
//               style: GoogleFonts.poppins(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: r.sp(0.042),
//               ),
//             ),
//           ),
//           // Trainers Cards
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: r.wp(0.035)),
//             child: Column(
//               children: trainers
//                   .map((trainer) => Padding(
//                         padding: EdgeInsets.only(bottom: r.hp(0.017)),
//                         child: TrainerCard(
//                           imagePath: trainer["image"],
//                           name: trainer["name"],
//                           sport: trainer["sport"],
//                           rating: trainer["rating"],
//                           price: trainer["price"],
//                           distance: trainer["distance"],
//                           isCertified: trainer["isCertified"],
//                           status: trainer["status"],
//                         ),
//                       ))
//                   .toList(),
//             ),
//           ),
//           SizedBox(height: r.hp(0.015)),
//         ],
//       ),
//     );
//   }
// }








// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/route_manager.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hanae_app/core/config/routes_config.dart';
// import 'package:hanae_app/core/constants/images.dart';
// import 'package:hanae_app/core/constants/themes.dart';
// import 'package:hanae_app/core/utils/responsive.dart';
// import 'package:hanae_app/ui/widgets/home_widgets/custom_search_bar.dart';
// import 'package:hanae_app/ui/widgets/home_widgets/sport_chip.dart';
// import 'package:hanae_app/ui/widgets/home_widgets/field_card.dart';
// import 'package:hanae_app/ui/widgets/home_widgets/trainer_card.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class HomeMainScreen extends StatefulWidget {
//   const HomeMainScreen({super.key});
//   @override
//   State<HomeMainScreen> createState() => _HomeMainScreenState();
// }

// class _HomeMainScreenState extends State<HomeMainScreen> {
//   int selectedCategory = 0;
//   bool isGridOpen = false;

//   List<Map<String, String>> sportCategories = [
//     {"label": "Boxing", "icon": AppImages.boxing},
//     {"label": "Football", "icon": AppImages.football},
//     {"label": "Tennis", "icon": AppImages.tennis},
//   ];

//   final List<Map<String, String>> allSports = [
//     {"label": "Boxing", "icon": AppImages.boxing},
//     {"label": "Football", "icon": AppImages.football},
//     {"label": "Tennis", "icon": AppImages.tennis},
//     {"label": "Padel", "icon": AppImages.padel},
//     {"label": "Basketball", "icon": AppImages.basketball},
//     {"label": "Yoga", "icon": AppImages.yoga},
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _loadSportCategories();
//   }

//   Future<void> _loadSportCategories() async {
//     final prefs = await SharedPreferences.getInstance();
//     final saved = prefs.getStringList('selected_sports');
//     if (saved != null && saved.length == sportCategories.length * 2) {
//       setState(() {
//         for (int i = 0; i < sportCategories.length; i++) {
//           sportCategories[i] = {
//             'label': saved[i * 2],
//             'icon': saved[i * 2 + 1],
//           };
//         }
//       });
//     }
//   }

//   Future<void> _saveSportCategories() async {
//     final prefs = await SharedPreferences.getInstance();
//     final flat = <String>[];
//     for (var item in sportCategories) {
//       flat.add(item['label']!);
//       flat.add(item['icon']!);
//     }
//     await prefs.setStringList('selected_sports', flat);
//   }

//   final List<Map<String, dynamic>> fields = [
//     {
//       "image": AppImages.footballField,
//       "name": "Football Field",
//       "price": "AED 200 / hour",
//       "distance": "1.5 km away",
//     },
//     {
//       "image": AppImages.tennisField,
//       "name": "Tennis Field",
//       "price": "AED 100 / hour",
//       "distance": "3.5 km away",
//     },
//     {
//       "image": AppImages.boxingField,
//       "name": "Boxing Hall",
//       "price": "AED 300 / hour",
//       "distance": "4.0 km away",
//     },
//   ];

//   final List<Map<String, dynamic>> trainers = [
//     {
//       "image": AppImages.trainer1,
//       "name": "Kovazitch Iron",
//       "sport": "kickboxing",
//       "rating": 4.8,
//       "price": "AED 200 / hour",
//       "distance": "1.5 km away",
//       "isCertified": true,
//       "status": "Available today"
//     },
//     {
//       "image": AppImages.trainer2,
//       "name": "ramos edirson",
//       "sport": "kickboxing",
//       "rating": 3.9,
//       "price": "AED 500 / hour",
//       "distance": "1.5 km away",
//       "isCertified": false,
//       "status": "No Certified"
//     },
//   ];

//   void _showSportsDialog(BuildContext context, Responsive r) async {
//     setState(() => isGridOpen = true);
//     int current = selectedCategory;

//     await showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (_) => Center(
//         child: Container(
//           width: r.wp(0.85),
//           height: r.hp(0.5),
//           padding: const EdgeInsets.all(18),
//           decoration: BoxDecoration(
//             color: AppColors.inputDark,
//             borderRadius: BorderRadius.circular(28),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 "Select Sport",
//                 style: GoogleFonts.poppins(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: r.sp(0.040),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Expanded(
//                 child: GridView.count(
//                   crossAxisCount: 3,
//                   mainAxisSpacing: 14,
//                   crossAxisSpacing: 14,
//                   children: allSports.map((sport) {
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).pop();
//                         setState(() {
//                           sportCategories[current] = sport;
//                           isGridOpen = false;
//                         });
//                         _saveSportCategories();
//                       },
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                               color: AppColors.greenAccent.withOpacity(0.09),
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             child: SvgPicture.asset(
//                               sport['icon']!,
//                               width: r.wp(0.09),
//                               height: r.wp(0.09),
//                               color: AppColors.greenAccent,
//                             ),
//                           ),
//                           const SizedBox(height: 6),
//                           Text(
//                             sport['label']!,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w600,
//                               fontSize: 13,
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//     setState(() => isGridOpen = false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final r = Responsive.of(context);

//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           // Header معدل (أيقونة الماركت مكان شعار التطبيق)
//           Padding(
//             padding: EdgeInsets.only(
//               left: r.wp(0.045),
//               right: r.wp(0.045),
//               top: r.hp(0.03),
//               bottom: r.hp(0.01),
//             ),
//             child: Row(
//               children: [
//                 // 🟢 أيقونة المكملات كبسولة/Market بدل الشعار
//                 GestureDetector(
//                   onTap: () {
//                     Get.toNamed(AppRoutes.market); 
//                   },
//                   child: Container(
//                     width: r.wp(0.14),
//                     height: r.wp(0.14),
//                     padding: EdgeInsets.all(r.wp(0.023)),
//                     decoration: BoxDecoration(
//                       color: AppColors.greenAccent.withOpacity(0.10),
//                       borderRadius: BorderRadius.circular(19),
//                       boxShadow: [
//                         BoxShadow(
//                           color: AppColors.greenAccent.withOpacity(0.12),
//                           blurRadius: 14,
//                           offset: Offset(0, 3),
//                         )
//                       ],
//                       border: Border.all(
//                           color: AppColors.greenAccent.withOpacity(0.24),
//                           width: 1.1),
//                     ),
//                     child: SvgPicture.asset(
//                       AppImages.supplements4,
//                       fit: BoxFit.contain,
//                       color: AppColors.greenAccent,
//                     ),
//                   ),
//                 ),
//                 const Spacer(),
//                 CircleAvatar(
//                   radius: r.wp(0.055),
//                   backgroundImage: AssetImage(AppImages.user),
//                 ),
//               ],
//             ),
//           ),
//           // باقي الصفحة كما هو...
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: r.wp(0.045)),
//             child: Row(
//               children: [
//                 Expanded(child: CustomSearchBar()),
//                 SizedBox(width: r.wp(0.022)),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: AppColors.inputDark,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   padding: EdgeInsets.all(r.wp(0.022)),
//                   child: Icon(Icons.filter_list, color: Colors.white, size: r.wp(0.048)),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: r.hp(0.026)),
//           // Categories + Grid Toggle
//           Padding(
//             padding: EdgeInsets.only(left: r.wp(0.045), right: r.wp(0.025)),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       children: List.generate(
//                         sportCategories.length,
//                         (i) => Padding(
//                           padding: EdgeInsets.only(right: r.wp(0.023)),
//                           child: SportChip(
//                             label: sportCategories[i]["label"]!,
//                             iconPath: sportCategories[i]["icon"]!,
//                             isSelected: selectedCategory == i,
//                             onTap: () => setState(() => selectedCategory = i),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: r.wp(0.01)),
//                 GestureDetector(
//                   onTap: () {
//                     if (!isGridOpen) _showSportsDialog(context, r);
//                     else setState(() => isGridOpen = false);
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: AppColors.inputDark,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     padding: EdgeInsets.all(r.wp(0.016)),
//                     child: Icon(
//                       isGridOpen ? Icons.close : Icons.grid_view,
//                       color: AppColors.greenAccent,
//                       size: r.wp(0.055),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: r.hp(0.024)),
//           // Sports Fields title
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: r.wp(0.045)),
//             child: Text(
//               'Sports Fields',
//               style: GoogleFonts.poppins(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: r.sp(0.042),
//               ),
//             ),
//           ),
//           SizedBox(height: r.hp(0.013)),
//           // Sports Fields cards
//           SizedBox(
//             height: r.hp(0.22),
//             child: ListView.separated(
//               padding: EdgeInsets.only(left: r.wp(0.045)),
//               scrollDirection: Axis.horizontal,
//               itemCount: fields.length,
//               separatorBuilder: (_, __) => SizedBox(width: r.wp(0.028)),
//               itemBuilder: (context, i) {
//                 final field = fields[i];
//                 return FieldCard(
//                   imagePath: field["image"] ?? "",
//                   name: field["name"] ?? "",
//                   price: field["price"] ?? "",
//                   distance: field["distance"] ?? "",
//                   onTap: () {},
//                 );
//               },
//             ),
//           ),
//           // Trainers section
//           Padding(
//             padding: EdgeInsets.fromLTRB(
//                 r.wp(0.045), r.hp(0.03), r.wp(0.045), r.hp(0.01)),
//             child: Text(
//               'Trainers',
//               style: GoogleFonts.poppins(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: r.sp(0.042),
//               ),
//             ),
//           ),
//           // Trainers Cards
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: r.wp(0.035)),
//             child: Column(
//               children: trainers
//                   .map((trainer) => Padding(
//                         padding: EdgeInsets.only(bottom: r.hp(0.017)),
//                         child: TrainerCard(
//                           imagePath: trainer["image"],
//                           name: trainer["name"],
//                           sport: trainer["sport"],
//                           rating: trainer["rating"],
//                           price: trainer["price"],
//                           distance: trainer["distance"],
//                           isCertified: trainer["isCertified"],
//                           status: trainer["status"],
//                         ),
//                       ))
//                   .toList(),
//             ),
//           ),
//           SizedBox(height: r.hp(0.015)),
//         ],
//       ),
//     );
//   }
// }
