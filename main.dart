import 'package:flutter/material.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DonutShopMain()
    ));
}

class Utils {
  
  static const Color mainColor = Color(0xFFFF0F7E);
  static const Color mainDark = Color(0xFF980346);

  static List<DonutModel> donuts = [
   DonutModel(
      imgUrl: 'https://romanejaquez.github.io/flutter-codelab4/assets/donutclassic/donut_classic1.png',
      name: 'Strawberry Sprinkled Glazed',
      description: 'Lorem ipsum something',
      isSelected: false
    ),
    DonutModel(
      imgUrl: 'https://romanejaquez.github.io/flutter-codelab4/assets/donutclassic/donut_classic1.png',
      name: 'Strawberry Sprinkled Glazed',
      description: 'Lorem ipsum something',
      isSelected: false
    ),
    DonutModel(
      imgUrl: 'https://romanejaquez.github.io/flutter-codelab4/assets/donutclassic/donut_classic1.png',
      name: 'Strawberry Sprinkled Glazed',
      description: 'Lorem ipsum something',
      isSelected: false
    ),
    DonutModel(
      imgUrl: 'https://romanejaquez.github.io/flutter-codelab4/assets/donutclassic/donut_classic1.png',
      name: 'Strawberry Sprinkled Glazed',
      description: 'Lorem ipsum something',
      isSelected: false
    )
  ];
}

class DonutShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Utils.mainColor,
      body: Center(
        child: SizedBox(
          width: 140,
          child: Image.network('https://romanejaquez.github.io/flutter-codelab4/assets/donut_shop_logowhite.png')
        )
      )
    );
  }
}

class DonutShopMain extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Utils.mainDark),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SizedBox(
          width: 120,
          child: Image.network('https://romanejaquez.github.io/flutter-codelab4/assets/donut_shop_text.png')
        )
      ),
      drawer: const Drawer(),
      body: Column(
        children: [
          Container(
            height: 350,
            child: DonutPager()
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Classic'),
                Text('Sprinkled', style: TextStyle(color: Utils.mainColor)),
                Text('Stuffed')
              ],
            )
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: Utils.donuts.length,
                itemBuilder: (context, index) {
                  var donut = Utils.donuts[index];

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 150,
                        padding: EdgeInsets.all(20),
                        alignment: Alignment.bottomLeft,
                        margin: EdgeInsets.only(left: 10, top: 60, right: 10, bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: Offset(0.0, 4.0))]
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${donut.name!}')
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Image.network(donut.imgUrl!, width: 150, height: 150, fit: BoxFit.contain),
                      )
                    ],
                  );
                },
              )
            ),
          ),
          Container(
            padding: EdgeInsets.all(30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.trip_origin, color: Utils.mainDark)) ,
                IconButton(onPressed: () {}, icon: Icon(Icons.favorite, color: Utils.mainColor)) ,
                IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart, color: Utils.mainColor)) ,
              ],
            )
          )
        ]
      )
    );
  }
}

class DonutPager extends StatefulWidget {
  
  @override
  State<DonutPager> createState() => _DonutPagerState();
}

class _DonutPagerState extends State<DonutPager> {
  List<DonutPage> pages = [
    DonutPage(imgUrl: 'https://romanejaquez.github.io/flutter-codelab4/assets/donut_promo1.png', label: 'Test label'),
    DonutPage(imgUrl: 'https://romanejaquez.github.io/flutter-codelab4/assets/donut_promo2.png', label: 'Test label'),
    DonutPage(imgUrl: 'https://romanejaquez.github.io/flutter-codelab4/assets/donut_promo3.png', label: 'Test label'),
  ];
  int currentPage = 0;
  final PageController controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        Expanded(
        child: PageView(
          /// [PageView.scrollDirection] defaults to [Axis.horizontal].
          /// Use [Axis.vertical] to scroll vertically.
          scrollDirection: Axis.horizontal,
          pageSnapping: true,
          controller: controller,
          onPageChanged: (int page) {
            setState(() {
              currentPage = page;
            });
          },
          children: List.generate(3, (index) {
            DonutPage currentPage = pages[index];
            return Container(
              alignment: Alignment.bottomLeft,
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: Offset(0.0, 5.0))],
                image: DecorationImage(
                  image: NetworkImage(currentPage.imgUrl!),
                  fit: BoxFit.cover
                )
              ),
              child: Text('${currentPage.label!}', style: TextStyle(color: Colors.white))
            );
          })
        )
      ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(pages.length, (index) {
            return GestureDetector(
              onTap: () {
                controller.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
              },
              child: Container(
                width: 10,
                height: 10,
                
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: currentPage == index ? Utils.mainColor : Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5)
                )
              ),
            );
          })
        )
      ]
    );
  }
}
      
class DonutPage {
  String? imgUrl;
  String? label;
  
  DonutPage({ this.imgUrl, this.label });
}

class DonutShopDetails extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Utils.mainDark),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SizedBox(
          width: 120,
          child: Image.network('https://romanejaquez.github.io/flutter-codelab4/assets/donut_shop_text.png')
        )
      ),
      drawer: const Drawer(),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: Stack(
              children: [
                Positioned(
                  top: 50,
                  right: -50,
                  child: Transform.scale(
                    scale: 1.8,
                    child: Image.network('https://romanejaquez.github.io/flutter-codelab4/assets/donutclassic/donut_classic1.png')
                  )
                )
              ]
            )
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text('Strawberry Glazed Sprinkle',
                                    style: TextStyle(color: Utils.mainDark, fontSize: 40, fontWeight: FontWeight.bold)    
                                   )
                      ),
                      SizedBox(width: 50),
                      IconButton(icon: Icon(Icons.favorite, color: Utils.mainDark), onPressed: () {})
                    ]
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                    child: Text('\$1.99', style: TextStyle(color: Colors.white)),
                    decoration: BoxDecoration(
                      color: Utils.mainDark,
                      borderRadius: BorderRadius.circular(20),
                    )
                  ),
                  SizedBox(height: 20),
                  Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce blandit, tellus condimentum cursus gravida, lorem augue venenatis elit, sit amet bibendum quam neque id sapien. ')
                ]
              )
            )
          )
        ]
      )
    );
  }
}

class DonutModel {

  String? imgUrl;
  String? name;
  String? description;
  double? price;
  bool? isSelected;

  DonutModel({
    this.imgUrl,
    this.name,
    this.description,
    this.price,
    this.isSelected
  });
}