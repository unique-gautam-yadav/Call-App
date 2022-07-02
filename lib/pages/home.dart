// import 'dart:ffi';

// import 'package:flutter/material.dart';
// import 'package:slimy_card/slimy_card.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: const Text("About Me"),
//           backgroundColor: Colors.indigo,
//         ),
//         backgroundColor: Colors.amber.shade50,
//         body: Center(
//             child: Column(
//           children: [
//             SlimyCard(
//                 color: Colors.indigo,
//                 bottomCardHeight: 110,
//                 topCardWidget: _topCardWidget(
//                   'assets/image/Photo.jpg',
//                   false,
//                 ),
//                 bottomCardWidget: _bottomCardWidget()),
//             const SizedBox(height: 40),
//             ElevatedButton(
//                 onPressed: () => Navigator.pushNamed(context, "/contacts"),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     Text("Go to Contacts "),
//                     Icon(Icons.contacts)
//                   ],
//                 )),
//           ],
//         )));
//   }
// }

// Widget _topCardWidget(String imagePath, bool isOpen) {
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       AnimatedContainer(
//         duration: const Duration(milliseconds: 500),
//         height: isOpen ? 85 : 78,
//         width: isOpen ? 85 : 78,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(isOpen ? 100 : 20),
//             image: DecorationImage(
//                 image: AssetImage(imagePath), fit: BoxFit.fitHeight)),
//       ),
//       const SizedBox(height: 15),
//       const Text(
//         'Gautam Yadav',
//         style: TextStyle(color: Colors.white, fontSize: 20),
//       ),
//       const SizedBox(height: 8),
//       Text(
//         'Amazing Individual',
//         style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
//       ),
//       const SizedBox(height: 10),
//     ],
//   );
// }

// Widget _bottomCardWidget() {
//   return Center(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const [
//             Text(
//               'unique_gautam_yadav',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 12,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               ' on Instagram',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w300,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 6),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const [
//             Text(
//               'Unique Gautam Yadav',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 12,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               ' on YouTube',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w300,
//               ),
//             )
//           ],
//         ),
//         const SizedBox(height: 6),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const [
//             Text(
//               'Unique_Gautam_Yadav',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 12,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               ' on GitHub',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w300,
//               ),
//             ),
//           ],
//         )
//       ],
//     ),
//   );
// }
