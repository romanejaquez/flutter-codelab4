import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DonutService(),
        ),
        ChangeNotifierProvider(
          create: (_) => DonutCartService(),
        ),
        ChangeNotifierProvider(
          create: (_) => DonutFavoritesSerivce(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/main',
        navigatorKey: Utils.mainAppNav,
        routes: {
          '/main': (context) => DonutShopMain(),
          '/details': (context) => DonutShopDetails()
        }
      )
    )
  );
}

class Utils {
  static GlobalKey<NavigatorState> mainListNav = GlobalKey();
  static GlobalKey<NavigatorState> mainAppNav = GlobalKey();
  static const Color mainColor = Color(0xFFFF0F7E);
  static const Color mainDark = Color(0xFF980346);

  static List<DonutModel> donuts = [
   DonutModel(
      imgUrl: 'https://romanejaquez.github.io/flutter-codelab4/assets/donutclassic/donut_classic1.png',
      name: 'Strawberry Sprinkled Glazed',
      description: 'Lorem ipsum something',
      price: 1.99,
      isSelected: false,
      type: 'classic'
    ),
    DonutModel(
      imgUrl: 'https://romanejaquez.github.io/flutter-codelab4/assets/donutclassic/donut_classic2.png',
      name: 'Chocolate Glazed Doughnut',
      description: 'Lorem ipsum something',
      isSelected: false,
      price: 2.99,
      type: 'classic',
    ),
    DonutModel(
      imgUrl: 'https://romanejaquez.github.io/flutter-codelab4/assets/donutclassic/donut_classic3.png',
      name: 'Chocolate Dipped Doughnut',
      description: 'Lorem ipsum something',
      isSelected: false,
      price: 2.99,
      type: 'classic'
    ),
    DonutModel(
      imgUrl: 'https://romanejaquez.github.io/flutter-codelab4/assets/donutclassic/donut_classic4.png',
      name: 'Cinamon Glazed Glazed',
      description: 'Lorem ipsum something',
      isSelected: false,
      price: 2.99,
      type: 'classic'
    ),
    DonutModel(
      imgUrl: 'https://romanejaquez.github.io/flutter-codelab4/assets/donutclassic/donut_classic5.png',
      name: 'Sugar Glazed Doughnut',
      description: 'Lorem ipsum something',
      isSelected: false,
      price: 1.99,
      type: 'classic'
    ),
    DonutModel(
      imgUrl: 'https://romanejaquez.github.io/flutter-codelab4/assets/donutsprinkled/donut_sprinkled1.png',
      name: 'Halloween Chocolate Glazed',
      description: 'Lorem ipsum something',
      isSelected: false,
      price: 2.99,
      type: 'sprinkled'
    ),
    DonutModel(
      imgUrl: 'https://romanejaquez.github.io/flutter-codelab4/assets/donutsprinkled/donut_sprinkled2.png',
      name: 'Party Sprinkled Cream',
      description: 'Lorem ipsum something',
      isSelected: false,
      price: 1.99,
      type: 'sprinkled'
    ),
    DonutModel(
      imgUrl: 'https://romanejaquez.github.io/flutter-codelab4/assets/donutsprinkled/donut_sprinkled3.png',
      name: 'Chocolate Glazed Sprinkled',
      description: 'Lorem ipsum something',
      isSelected: false,
      price: 1.99,
      type: 'sprinkled'
    ),
    DonutModel(
      imgUrl: 'https://romanejaquez.github.io/flutter-codelab4/assets/donutsprinkled/donut_sprinkled4.png',
      name: 'Strawbery Glazed Sprinkled',
      description: 'Lorem ipsum something',
      isSelected: false,
      price: 2.99,
      type: 'sprinkled'
    ),
    DonutModel(
      imgUrl: 'https://romanejaquez.github.io/flutter-codelab4/assets/donutsprinkled/donut_sprinkled5.png',
      name: 'Reese\'s Sprinkled',
      description: 'Lorem ipsum something',
      isSelected: false,
      price: 3.99,
      type: 'sprinkled'
    ),
    DonutModel(
      imgUrl: 'https://romanejaquez.github.io/flutter-codelab4/assets/donutstuffed/donut_stuffed1.png',
      name: 'Brownie Cream Doughnut',
      description: 'Lorem ipsum something',
      isSelected: false,
      price: 1.99,
      type: 'stuffed'
    ),
    DonutModel(
      imgUrl: 'https://romanejaquez.github.io/flutter-codelab4/assets/donutstuffed/donut_stuffed2.png',
      name: 'Jelly Stuffed Doughnut',
      description: 'Lorem ipsum something',
      isSelected: false,
      price: 2.99,
      type: 'stuffed'
    ),
    DonutModel(
      imgUrl: 'https://romanejaquez.github.io/flutter-codelab4/assets/donutstuffed/donut_stuffed3.png',
      name: 'Caramel Stuffed Doughnut',
      description: 'Lorem ipsum something',
      isSelected: false,
      price: 2.59,
      type: 'stuffed'
    ),
    DonutModel(
      imgUrl: 'https://romanejaquez.github.io/flutter-codelab4/assets/donutstuffed/donut_stuffed4.png',
      name: 'Maple Stuffed Doughnut',
      description: 'Lorem ipsum something',
      isSelected: false,
      price: 1.99,
      type: 'stuffed'
    ),
    DonutModel(
      imgUrl: 'https://romanejaquez.github.io/flutter-codelab4/assets/donutstuffed/donut_stuffed5.png',
      name: 'Glazed Jelly Stuffed Doughnut',
      description: 'Lorem ipsum something',
      isSelected: false,
      price: 1.59,
      type: 'stuffed'
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
      drawer: Drawer(
        child: Container(
          color: Utils.mainDark,
          padding: EdgeInsets.all(40),
          alignment: Alignment.bottomLeft,
          child: Image.network('https://romanejaquez.github.io/flutter-codelab4/assets/donut_shop_text_reversed.png',
            width: 200
          )
        )
      ),
      body: Column(
        children: [
          Expanded(
            child: Navigator(
              key: Utils.mainListNav,
              initialRoute: '/',
              onGenerateRoute: (RouteSettings settings) {

                Widget page;

                switch(settings.name) {
                  case '/':
                    page = DonutMainPage();
                    break;
                  case '/main/favorites':
                    page = DonutFavoritesPage();
                    break;
                  case '/main/shoppinglist':
                    page = DonutShoppingListPage();
                    break;
                  default:
                    page = DonutMainPage();
                    break;
                }

                return PageRouteBuilder(
                  pageBuilder: (_, __, ___) => page,
                  transitionDuration: const Duration(seconds: 0)
                );
              }
            )
          ),
          DonutBottomBar()
        ]
      )
    );
  }
}

class DonutMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 350,
            child: DonutPager()
          ),
          DonutFilterBar(),
          Expanded(
            child: Container(
              child: Consumer<DonutService>(
                builder: (context, donutService, child) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: donutService.filteredDonuts.length,
                    itemBuilder: (context, index) {
                      var donut = donutService.filteredDonuts[index];

                      return DonutCard(donutInfo: donut);
                    },
                  );
                },
              )
            ),
          )
      ],
    );
  }
}

class DonutFavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Favorites');
  }
}

class DonutShoppingListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Shopping');
  }
}

class DonutBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: () {
            Utils.mainListNav.currentState!.pushReplacementNamed('/');
          }, icon: Icon(Icons.trip_origin, color: Utils.mainDark)) ,
          IconButton(onPressed: () {
            Utils.mainListNav.currentState!.pushReplacementNamed('/main/favorites');
          }, icon: Icon(Icons.favorite, color: Utils.mainColor)) ,
          
          Consumer<DonutCartService>(
            builder: (context, cartService, child) {
              int cartItems = cartService.cartDonuts.length;
              return GestureDetector(
                onTap: () {
                  Utils.mainListNav.currentState!.pushReplacementNamed('/main/shoppinglist');
                },
                child: Container(
                  constraints: BoxConstraints(minHeight: 70),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: cartItems > 0 ? Utils.mainColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      cartService.cartDonuts.length > 0 ? 
                      Text('$cartItems', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14))
                          : SizedBox(height: 20),
                      SizedBox(height: 10),
                      Icon(Icons.shopping_cart, color: cartItems > 0 ? Colors.white : Utils.mainColor) ,
                    ],
                  ),
                )
              );
            }
          )
        ],
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
    DonutService donutService = Provider.of<DonutService>(context, listen: false);

    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () { 
                  setState(() { 
                    selectedTab = 'classic'; 
                  });
                  donutService.filteredDonutsByType(selectedTab);
                },
                child: Container(
                  child: Text('Classic', style: TextStyle(color: selectedTab == 'classic' ? Utils.mainColor : Colors.black, fontWeight: FontWeight.bold))
                )
              ),
              GestureDetector(
                onTap: () { 
                  setState(() { selectedTab = 'sprinkled'; });
                  donutService.filteredDonutsByType(selectedTab);
               },
                child: Container(
                  child: Text('Sprinkled', style: TextStyle(color: selectedTab == 'sprinkled' ? Utils.mainColor : Colors.black, fontWeight: FontWeight.bold))
                )
              ),
              GestureDetector(
                onTap: () { 
                  setState(() { selectedTab = 'stuffed'; }); 
                  donutService.filteredDonutsByType(selectedTab);
                },
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
        Provider.of<DonutService>(context, listen: false).selectedDonut = donutInfo!;
        Utils.mainAppNav.currentState!.pushNamed('/details');
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 150,
            padding: EdgeInsets.all(15),
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.only(left: 10, top: 80, right: 10, bottom: 20),
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
            child: Image.network(donutInfo!.imgUrl!, width: 150, height: 150, fit: BoxFit.contain),
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

        // pageview indicators
        PageViewerIndicator(
          controller: controller, 
          numberOfPages: pages.length,
          currentPage: currentPage,
        )
      ]
    );
  }
}

class PageViewerIndicator extends StatelessWidget {
  PageController? controller;
  int? numberOfPages;
  int? currentPage;

  PageViewerIndicator({ this.controller, this.numberOfPages, this.currentPage });

  @override
  Widget build(BuildContext context) {

    
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(numberOfPages!, (index) {
          return GestureDetector(
            onTap: () {
              controller!.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              width: 15, height: 15,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: currentPage == index ? Utils.mainColor : Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10)
              )
            ),
          );
        })
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

  @override
  State<DonutShopDetails> createState() => _DonutShopDetailsState();
}

class _DonutShopDetailsState extends State<DonutShopDetails> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? rotationAnimation;
  DonutModel? selectedDonut;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: const Duration(seconds: 20), vsync: this)..repeat();
    rotationAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: controller!, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    DonutService donutService = Provider.of<DonutService>(context, listen: false);
    selectedDonut = donutService.selectedDonut;

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
                      tag: selectedDonut!.name!,
                      child: RotationTransition(
                        turns: rotationAnimation!,
                        child: Container(
                          width: 500,
                          height: 500,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(selectedDonut!.imgUrl!),fit: BoxFit.contain
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
                        child: Text('${selectedDonut!.name!}',
                                    style: TextStyle(color: Utils.mainDark, fontSize: 30, fontWeight: FontWeight.bold)    
                                   )
                      ),
                      SizedBox(width: 50),
                      Consumer<DonutFavoritesSerivce>(
                        builder: (context, favoritesService, child) {
                          return IconButton(
                            icon: Icon(favoritesService.isDonutFavorite(selectedDonut!) ? Icons.favorite : Icons.favorite_outline,
                            color: Utils.mainDark),
                            onPressed: () {
                              if (favoritesService.isDonutFavorite(selectedDonut!)) {
                                favoritesService.removeFavorite(selectedDonut!);
                              }
                              else {
                                favoritesService.addFavorite(selectedDonut!);
                              }
                            }
                          );
                        }
                      )
                    ]
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                    child: Text('\$${selectedDonut!.price!.toStringAsFixed(2)}', style: TextStyle(color: Colors.white)),
                    decoration: BoxDecoration(
                      color: Utils.mainDark,
                      borderRadius: BorderRadius.circular(20),
                    )
                  ),
                  SizedBox(height: 20),
                  Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce blandit, tellus condimentum cursus gravida, lorem augue venenatis elit, sit amet bibendum quam neque id sapien. '),
                  Consumer<DonutCartService>(
                    builder: (context, cartService, child) {

                      if (!cartService.isDonutInCart(selectedDonut!)) {
                        return GestureDetector(
                          onTap: () {
                            cartService.addToCart(selectedDonut!);
                          },
                          child: Container(
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
                          ),
                        );
                      }

                      return Padding(
                        padding: EdgeInsets.only(top: 30, bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_rounded, color: Utils.mainDark),
                            SizedBox(width: 20),
                            Text('Added to Cart', style: TextStyle(fontWeight: FontWeight.bold, color: Utils.mainDark))
                          ],
                        ),
                      );
                    },
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
  String? type;

  DonutModel({
    this.imgUrl,
    this.name,
    this.description,
    this.price,
    this.isSelected,
    this.type
  });
}

class DonutService extends ChangeNotifier {

  List<DonutModel> filteredDonuts = [];
  late DonutModel selectedDonut;

  DonutService() {
    filteredDonutsByType('classic');
  }

  void filteredDonutsByType(String type) {
    filteredDonuts = Utils.donuts.where((d) => d.type == type).toList();
    notifyListeners();
  }
}

class DonutCartService extends ChangeNotifier {

  List<DonutModel> cartDonuts = [];

  void addToCart(DonutModel donut) {
    cartDonuts.add(donut);
    notifyListeners();
  }

  void removeFromCart(DonutModel donut) {
    cartDonuts.remove(donut);
    notifyListeners();
  }

  bool isDonutInCart(DonutModel donut) {
    return cartDonuts.any((d) => d.name == donut.name);
  }
}

class DonutFavoritesSerivce extends ChangeNotifier {

  List<DonutModel> favoriteDonuts = [];

  void addFavorite(DonutModel donut) {
    favoriteDonuts.add(donut);
    notifyListeners();
  }

  void removeFavorite(DonutModel donut) {
    favoriteDonuts.remove(donut);
    notifyListeners();
  }

  bool isDonutFavorite(DonutModel donut) {
    return favoriteDonuts.any((d) => d.name == donut.name);
  }
}
  
