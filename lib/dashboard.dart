import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'custom/product_card.dart';
import 'model/category.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  int _currentIndex = 0; // Track the selected index

  bool isSearching = true;
  TextEditingController searchController = TextEditingController();
  List<String> banners =[
  "http://devapiv4.dealsdray.com/icons/banner.png",
  "http://devapiv4.dealsdray.com/icons/banner.png"
  ];

  List<Category> categories = [Category("Mobile","http://devapiv4.dealsdray.com/icons/cat_mobile.png"),
                                Category("Laptop","http://devapiv4.dealsdray.com/icons/cat_lap.png"),
                                Category("Camera","http://devapiv4.dealsdray.com/icons/cat_camera.png"),
                                Category("LED","http://devapiv4.dealsdray.com/icons/cat_led.png"),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        shadowColor: Colors.grey,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: isSearching
            ? TextField(
          controller: searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Search Here",
            filled: true,
            fillColor: Colors.grey[200],
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          ),
        )
            : Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              setState(() {

              });
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.grey,
              ),
              child: Column(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    child: Image.asset("assets/images/logo.png"),
                  ),
                  Text('Deals Dray', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: const Text('Contact us'),
              onTap: () async {},
            ),
            SizedBox(height: 350),
            Divider(thickness: 2),
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Set the current index
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the selected index
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, color: _currentIndex == 0 ? Colors.red : Colors.black),
            label: "Home",
            tooltip: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category, color: _currentIndex == 1 ? Colors.red : Colors.black),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard, color: _currentIndex == 2 ? Colors.red : Colors.black),
            label: "Deals",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: _currentIndex == 3 ? Colors.red : Colors.black),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: _currentIndex == 4 ? Colors.red : Colors.black),
            label: "Person",
          ),
        ],
        backgroundColor: Colors.grey,
        unselectedItemColor: Colors.black, // Color for unselected items
        selectedItemColor: Colors.red,     // Color for selected items
        selectedLabelStyle: TextStyle(color: Colors.red),
        unselectedLabelStyle: TextStyle(color: Colors.black),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              items: banners
                  .map((item) => Container(
                child: Center(
                  child: Image.network(
                    item,
                    fit: BoxFit.cover,
                    width: 400
                  ),
                ),
              ))
                  .toList(),
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),color: Colors.deepPurple,),
              child:  const Center(
                child: Column(

                  children :[
                    Text("KYC Pending" ,style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white)),
                    Text("you need to provide the required documentation for your account activation" ,style: TextStyle(color: Colors.white, )),
                    Text("Click Here" ,style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white,decoration: TextDecoration.underline,decorationColor: Colors.white,decorationThickness: 2)),
                  ]
                )
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: categories.map((category) {
                return InkWell(
                  onTap: ()=>{
                  Fluttertoast.showToast(
                  msg: "${category.label}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                  )
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: NetworkImage(category.icon),
                      ),
                      SizedBox(height: 8),
                      Text(category.label),
                    ],
                  ),
                );
              }).toList(),
            ),
            Container(
              margin: EdgeInsets.only(top: 10,bottom: 20),
              padding: EdgeInsets.all(15),
                height: MediaQuery.of(context).size.height * 0.5,
                width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/simple_background.png'), // replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
              child:  Column(
                children: [
                  const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Exclusive for you" ,style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold,)),
                          Icon(Icons.arrow_forward, color: Colors.white,size: 35)
                        ],
                    ),
                  const SizedBox(height: 40),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,

                    child: Row(
                      children: [
                        Container(
                          child: ProductCard(
                            imageUrl: 'http://devapiv4.dealsdray.com/icons/Image -80.png',
                            offer: '32%',
                            label: 'Nokia 8.1 (Iron, 64 GB)',
                          ),
                        ),
                        ProductCard(
                          imageUrl: 'http://devapiv4.dealsdray.com/icons/Image -75.png',
                          offer: '36%',
                          label: 'FINICKY-WORLD V380',
                        ),
                        ProductCard(
                          imageUrl: 'http://devapiv4.dealsdray.com/icons/Image -79.png',
                          offer: '32%',
                          label: 'MI LED TV 4A PRO 108 CM',
                        ),
                        ProductCard(
                          imageUrl: 'http://devapiv4.dealsdray.com/icons/Image -76.png',
                          offer: '12%',
                          label: 'HP 245 7th GEN AMD',
                        ),
                        ProductCard(
                          imageUrl: 'http://devapiv4.dealsdray.com/icons/Image -80.png',
                          offer: '45%',
                          label: 'MI Redmi 5 (Blue,4GB)',
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
