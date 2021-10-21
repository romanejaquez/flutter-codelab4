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
      price: 1.99,
      isSelected: false
    ),
    DonutModel(
      imgUrl: 'https://romanejaquez.github.io/flutter-codelab4/assets/donutclassic/donut_classic2.png',
      name: 'Chocolate Glazed Doughnut',
      description: 'Lorem ipsum something',
      isSelected: false,
      price: 2.99
    ),
    DonutModel(
      imgUrl: 'https://romanejaquez.github.io/flutter-codelab4/assets/donutclassic/donut_classic3.png',
      name: 'Chocolate Dipped Doughnut',
      description: 'Lorem ipsum something',
      isSelected: false,
      price: 2.99
    ),
    DonutModel(
      imgUrl: 'https://romanejaquez.github.io/flutter-codelab4/assets/donutclassic/donut_classic4.png',
      name: 'Cinamon Glazed Glazed',
      description: 'Lorem ipsum something',
      isSelected: false,
      price: 2.99
    ),
    DonutModel(
      imgUrl: 'https://romanejaquez.github.io/flutter-codelab4/assets/donutclassic/donut_classic5.png',
      name: 'Sugar Glazed Doughnut',
      description: 'Lorem ipsum something',
      isSelected: false,
      price: 1.99
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
          DonutFilterBar(),
          Expanded(
            child: Container(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: Utils.donuts.length,
                itemBuilder: (context, index) {
                  var donut = Utils.donuts[index];

                  return DonutCard(donutInfo: donut);
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

class DonutFilterBar extends StatefulWidget {
    
  @override
  DonutFilterBarState createState() => DonutFilterBarState();
}

class DonutFilterBarState extends State<DonutFilterBar> {
  
  String selectedTab = 'classic';
  
  Alignment alignmentBasedOnTap() {
    Alignment returnedAlignment = Alignment.centerLeft;
    
    switch(selectedTab) {
      case 'classic':
        returnedAlignment =  Alignment.centerLeft;
        break;
      case 'sprinkled':
        returnedAlignment =  Alignment.center;
        break;
      case 'stuffed':
        returnedAlignment =  Alignment.centerRight;
        break;
      default:
        returnedAlignment =  Alignment.centerLeft;
        break;
    }
    
    return returnedAlignment;
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () { setState(() { selectedTab = 'classic'; }); },
                child: Container(
                  child: Text('Classic', style: TextStyle(color: selectedTab == 'classic' ? Utils.mainColor : Colors.black, fontWeight: FontWeight.bold))
                )
              ),
              GestureDetector(
                onTap: () { setState(() { selectedTab = 'sprinkled'; }); },
                child: Container(
                  child: Text('Sprinkled', style: TextStyle(color: selectedTab == 'sprinkled' ? Utils.mainColor : Colors.black, fontWeight: FontWeight.bold))
                )
              ),
              GestureDetector(
                onTap: () { setState(() { selectedTab = 'stuffed'; }); },
                child: Container(
                  child: Text('Stuffed', style: TextStyle(color: selectedTab == 'stuffed' ? Utils.mainColor : Colors.black, fontWeight: FontWeight.bold))
                )
              ),
            ],
          ),
          SizedBox(height: 10),
          Stack(
            children: [
              AnimatedAlign(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                alignment: alignmentBasedOnTap(),
                child: Container(
                  decoration: BoxDecoration(color: Utils.mainColor,borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3 - 20,
                    height: 5
                  )
                )
              )
            ]
          )
        ]
      )
    );
  }
}

class DonutCard extends StatelessWidget {

  DonutModel? donutInfo;
  DonutCard({ this.donutInfo });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => DonutShopDetails(selectedDonut: donutInfo))
        );
      },
      child: Stack(
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
                Text('${donutInfo!.name!}', style: TextStyle(color: Utils.mainDark, fontWeight: FontWeight.bold, fontSize: 15)),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Utils.mainColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                  child: Text('\$${donutInfo!.price!.toStringAsFixed(2)}', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold))
                )
              ],
            ),
          ),
          Hero(
            tag: donutInfo!.name!,
            child: Align(
            alignment: Alignment.topCenter,
            child: Image.network(donutInfo!.imgUrl!, width: 170, height: 170, fit: BoxFit.contain),
          ),
          )
        ],
      ),
    );
  }
}

class DonutPager extends StatefulWidget {
  
  @override
  State<DonutPager> createState() => _DonutPagerState();
}

class _DonutPagerState extends State<DonutPager> {
  List<DonutPage> pages = [
    DonutPage(imgUrl: 'https://romanejaquez.github.io/flutter-codelab4/assets/donut_promo1.png', label: 'Test label', logoImgUrl: 'https://romanejaquez.github.io/flutter-codelab4/assets/donut_shop_text_reversed.png'),
    DonutPage(imgUrl: 'https://romanejaquez.github.io/flutter-codelab4/assets/donut_promo2.png', label: 'Test label', logoImgUrl: 'https://romanejaquez.github.io/flutter-codelab4/assets/donut_shop_text_reversed.png'),
    DonutPage(imgUrl: 'https://romanejaquez.github.io/flutter-codelab4/assets/donut_promo3.png', label: 'Test label', logoImgUrl: 'https://romanejaquez.github.io/flutter-codelab4/assets/donut_shop_text.png'),
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
              child: Image.network(currentPage.logoImgUrl!, width: 120) // Text('${currentPage.label!}', style: TextStyle(color: Colors.white))
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
  String? logoImgUrl;
  
  DonutPage({ this.imgUrl, this.logoImgUrl, this.label });
}

class DonutShopDetails extends StatefulWidget {

  DonutModel? selectedDonut;

  DonutShopDetails({ this.selectedDonut });

  @override
  State<DonutShopDetails> createState() => _DonutShopDetailsState();
}

class _DonutShopDetailsState extends State<DonutShopDetails> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? rotationAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: const Duration(seconds: 20), vsync: this)..repeat();
    rotationAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: controller!, curve: Curves.linear));
  }

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
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: Stack(
              children: [
                Positioned(
                  top: -40,
                  right: -120,
                  child: Hero(
                      tag: widget.selectedDonut!.name!,
                      child: RotationTransition(
                        turns: rotationAnimation!,
                        child: Container(
                          width: 500,
                          height: 500,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(widget.selectedDonut!.imgUrl!),fit: BoxFit.contain
                            )
                          ),
                        ),
                      )
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
                        child: Text('${widget.selectedDonut!.name!}',
                                    style: TextStyle(color: Utils.mainDark, fontSize: 30, fontWeight: FontWeight.bold)    
                                   )
                      ),
                      SizedBox(width: 50),
                      IconButton(icon: Icon(Icons.favorite, color: Utils.mainDark), onPressed: () {})
                    ]
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                    child: Text('\$${widget.selectedDonut!.price!.toStringAsFixed(2)}', style: TextStyle(color: Colors.white)),
                    decoration: BoxDecoration(
                      color: Utils.mainDark,
                      borderRadius: BorderRadius.circular(20),
                    )
                  ),
                  SizedBox(height: 20),
                  Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce blandit, tellus condimentum cursus gravida, lorem augue venenatis elit, sit amet bibendum quam neque id sapien. '),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Utils.mainDark.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart, color: Utils.mainDark),
                        SizedBox(width: 20),
                        Text('Add To Cart', style: TextStyle(color: Utils.mainDark)),
                      ],
                    )
                  )
                ]
              )
            )
          )
        ]
      )
    );
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
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
