//
// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
//
//
// void main() {
//   runApp(calender());
// }
//
// class calender extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MyApp();
//   }
// }
//
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(),
//       home: Home(),
//     );
//   }
// }
//
// class Home extends StatefulWidget {
//   const Home({Key key}) : super(key: key);
//
//   @override
//   _HomeState createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   DateTime _focusedDay = DateTime.now();
//   DateTime  _selectedDay;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 0),
//               child: Card(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     SizedBox(
//                       width: 20.0,
//                     ),
//                     Text(
//                       "Period Tracker",
//                       style: TextStyle(
//                         fontSize: 40,
//
//                       ),
//
//                     ),
//                     IconButton(onPressed: (){}, icon: Icon(Icons.logout)),
//                   ],
//                 ),
//               ),
//             ),
//             SingleChildScrollView(
//               physics: ScrollPhysics(),
//               child: Padding(
//                 padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 0.0, bottom: 0),
//                 child: Card(
//                   elevation: 5.0,
//                   child: TableCalendar(
//                     firstDay: DateTime.utc(2019, 10, 16),
//                     lastDay: DateTime.utc(2022, 3, 14),
//                     focusedDay:_focusedDay,
//                     calendarFormat: _calendarFormat,
//                     eventLoader: (day){
//                       DateTime dt = DateTime.now();
//                       List<DateTime>dts = [];
//                       while(dt.isBefore(DateTime.utc(2022, 3, 14))){
//                         dts.add(dt);
//                         dt = dt.add(Duration(days: 30));
//                       }
//                       dynamic st = [];
//                       for(DateTime time in dts){
//                         if (day.day == time.day && day.month == time.month && day.year == time.year){
//                           st.add("next period dayC");
//                         }
//                       }
//                       return st;
//                     },
//                     selectedDayPredicate: (day) {
//                       return isSameDay(_selectedDay, day);
//                     },
//                     onDaySelected: (selectedDay, focusedDay) {
//                       if (!isSameDay(_selectedDay, selectedDay)) {
//                         setState(() {
//                           _selectedDay = selectedDay;
//                           _focusedDay = focusedDay;
//                         });
//                       }
//                     },
//                     onFormatChanged: (format) {
//                       if (_calendarFormat != format) {
//                         // Call `setState()` when updating calendar format
//                         setState(() {
//                           _calendarFormat = format;
//                         });
//                       }
//                     },
//                     onPageChanged: (focusedDay) {
//                       // No need to call `setState()` here
//                       _focusedDay = focusedDay;
//                     },
//                   ),
//                 ),
//               ),
//             ),
//             Card(
//               child: Padding(
//                 padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 0),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(left: 15.0, right: 10.0, top: 0.0, bottom: 0.0,),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           IconButton(
//                               onPressed: (){
//                                 Navigator.push(
//                                   context,
//                                   new MaterialPageRoute(builder: (_) => new PeriodTrackerForm()),
//                                 );
//                               },
//                               icon: Icon(Icons.edit)),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(left: 15.0, right: 20.0, top: 8.0, bottom: 8.0),
//                       child: Row(
//
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("Menstrual Length",style: TextStyle(fontSize: 25),),
//                           Text("5",style: TextStyle(fontSize: 25),),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(left: 15.0, right: 20.0, top: 8.0, bottom: 8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('Period Length',style: TextStyle(fontSize: 25),),
//                           Text("5",style: TextStyle(fontSize: 25),),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 8.0, bottom: 8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("Last Menstruation:",style: TextStyle(fontSize: 25),),
//                           Text("30/1/2020",style: TextStyle(fontSize: 25),),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//




