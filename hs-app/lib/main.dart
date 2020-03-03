import 'package:flutter/material.dart';
import 'camerapage.dart';
import 'buildinglist.dart';
import 'scanbutton.dart';

String text = 'test';

void main() {
  runApp(MaterialApp(
    title: 'Room Locator', 
    home: new HomeScreen(),
    
    debugShowCheckedModeBanner: false,
  ));
}

class HomeScreen extends StatefulWidget {
  
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    BuildingList(),
    Stack(
    children: [Container(
      color: Colors.blue,
      child: Center(
        child: Text(
          'MAP',
          style: TextStyle(
            fontSize: 48,
          ),
        ),
      ),
    ),
      Align(
            alignment: Alignment.topRight,
            child: Transform.scale(
              scale: 1.75,
              origin: Offset(-10, -40),
              child: PopupMenuButton(
                //splashColor: Color.fromARGB(0, 0, 0, 0),
                //color: Colors.white,
                icon: Icon(Icons.more_vert,
                color: Colors.white), 
                itemBuilder: (context) =>
                  <String>['About', 'Feedback', 'Logout']
                  .map<PopupMenuEntry<String>>((String value) {
                    return PopupMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
                },).toList(),
                
              ),
            ),
          ),
        ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = PageController(
      initialPage: 0,
    ); 
    
    
    // RGBO orange: 223,117,0, 1.0 
    // RGBO green: 18, 71, 52, 1.0

    return PageView(
      
      controller: controller,
      scrollDirection: Axis.vertical,
      
      children: <Widget>[
        CameraPage(),
        Scaffold(
          backgroundColor: Colors.grey[900], 
          body: _children[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            unselectedItemColor: Color.fromRGBO(100, 100, 100, 1.0),
            backgroundColor: Color.fromRGBO(20, 20, 20, 1.0),
            selectedItemColor: Color.fromRGBO(223,117,0, 1.0), 
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted),
              title: Text('List'),
              
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              title: Text('Map'),
            ),
            ],
            
            
          ),
          floatingActionButton: Transform.translate(
            offset: const Offset(0, 10),
            child: ScanButton(controller: controller),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          
        ),
      ],
    );
    
  }
  void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
   });
 }
}


