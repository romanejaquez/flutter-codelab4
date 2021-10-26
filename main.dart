import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
 runApp(
   MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => UserPiecesSelection()
      )
    ],
    child: MyApp()
   )
 );
}

class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
  return MaterialApp(
   theme: ThemeData.dark().copyWith(
    scaffoldBackgroundColor: darkBlue,
   ),
   debugShowCheckedModeBanner: false,
   home: Scaffold(
    body: Container(
     child: MyWidget(),
    ),
   ),
  );
 }
}

class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  DominoModel? acceptedData;
  List<DominoModel> addedDominos = [];

  List<DominoPiece> renderDominoPieces() {
    List<DominoPiece> pieces = [];

    addedDominos.forEach((DominoModel p) {
      pieces.add(DominoPiece(topNumber: p.topNumber, bottomNumber: p.bottomNumber));
    });

    return pieces;
  }

 @override
 Widget build(BuildContext context) {
  
  return Container(
   child: Stack(
      children: [
        SingleChildScrollView(
          child: Transform.scale(
            scale: 0.8,
            origin: Offset.zero,
            child: Container(
              margin: const EdgeInsets.only(top: 200, bottom: 200),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: renderDominoPieces(),
                  ),
                  DragTarget<DominoModel>(builder: (context, accepted, rejected) {
                      return Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: Center(
                          child: Image.asset('assets/imgs/dominoborder.png', width: 90, height: 180),
                        )
                      );
                    },
                    onAccept: (DominoModel model) {
                      setState(() {
                        addedDominos.add(model);
                      });
                    },
                  )
                ]
              ),
            )
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: UserBadge(
            userName: 'roman_jaquez',
            userAvatar: 'https://avatars.githubusercontent.com/u/5081804?v=4',
            opponent: false)
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: UserBadge(
            userName: 'linda0516',
            userAvatar: 'https://image.freepik.com/free-photo/close-up-shot-pretty-woman-with-perfect-teeth-dark-clean-skin-having-rest-indoors-smiling-happily-after-received-good-positive-news_273609-1248.jpg',
            opponent: true)
        ),
        Consumer<UserPiecesSelection>(
          builder: (context, piecesSelection, child) {
            Widget innerWidget = Container();

            if (piecesSelection.showUserPieces) {
              innerWidget = UserDominoPieces();
            }
            return AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              bottom: piecesSelection.showUserPieces ? 0 : -300, left: 0, right: 0,
              child: innerWidget
            );
          },
        )
      ] 
   ),
   decoration: BoxDecoration(
    gradient: RadialGradient(
     colors: [Color(0xFF007B17), Color(0xFF004D0F)]
    )
   )
  );
 }
}

class UserBadge extends StatelessWidget {
  
  bool? opponent;
  String? userName;
  String? userAvatar;
  
  UserBadge({ this.opponent, this.userName, this.userAvatar });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 150,
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 40),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Align(
          //   alignment: Alignment.centerLeft,
          //   child: Container(
          //     margin: EdgeInsets.only(top: 50),
          //     padding: EdgeInsets.only(top: 30, left: 15, bottom: 12, right: 15),
          //     decoration: BoxDecoration(
          //       color: Colors.black.withOpacity(0.5),
          //       borderRadius: BorderRadius.circular(15),
          //     ),
          //     child: const Text('3 Pieces Remaining', style: TextStyle(color: Colors.white, fontSize: 10))
          //   )
          // ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 60),
              decoration: BoxDecoration(
                color: opponent! ? Color(0xFFA5001F) : Color(0xFF7F8609),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [BoxShadow(offset: Offset.zero, blurRadius: 20, color: Colors.black.withOpacity(0.5))]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20, top: 5, bottom: 5, right: 20),
                    decoration: BoxDecoration(
                      color: opponent! ? Color(0xFF620012) : Color(0xFF353807),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('200', style: TextStyle(color: Colors.white))
                  ),
                  Text('$userName', style: TextStyle(color: Colors.white))
                ]
              )
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                if (!opponent!) {
                  var piecesSelection = Provider.of<UserPiecesSelection>(context, listen: false);
                  piecesSelection.toggleUserPieces();
                }
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('$userAvatar'),
                    fit: BoxFit.cover
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [BoxShadow(offset: Offset.zero, blurRadius: 20, color: Colors.black.withOpacity(0.5))],
                  border: Border.all(width: 3, color: opponent! ? Color(0xFFEF1C44) : Color(0xFFB0B704))
                )
              ),
            )
          )
        ]
      )
    );
  }
}


class DominoPiece extends StatelessWidget {
  
 int? topNumber;
 int? bottomNumber;
  
  DominoPiece({ this.topNumber, this.bottomNumber });
 
 @override
 Widget build(BuildContext context) {
  return 
   Center(
   child: Container(
    margin: EdgeInsets.all(2),
    child: Stack(
     children: [
      Container(
       margin: EdgeInsets.only(top: 8),
       width: 80,
       height: 170,
       decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(0xFFEFD99F),
        boxShadow: [
         BoxShadow(
          color: Colors.black.withOpacity(0.5),
          blurRadius: 30,
          offset: Offset.zero
         )
        ]
       )
      ),
      Container(
       width: 80,
       height: 170,
       decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(0xFFFFFCF4)
       ),
       child: Column(
        children: [
         Expanded(
          child: Container(
           padding: EdgeInsets.all(12),
           alignment: Alignment.center,
           width: 90,
           height: 80,
           child: DominoNumber(number: topNumber!)
          )
         ),
         Stack(
          children: [
           Container(
            height: 2,
            color: Colors.grey,
            margin: EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
            alignment: Alignment.center,
           ),
           Center(
            child: ClipOval(
             child: Container(
              color: Colors.grey,
              width: 8,
              height: 8
             )
            )
           )
          ]
         ),
         Expanded(
          child: Container(
           padding: EdgeInsets.all(12),
           alignment: Alignment.center,
           width: 90,
           height: 80,
           child: DominoNumber(number: bottomNumber!)
          )
         )
        ]
       )
      )
     ]
    )
   )
  );
 }
}

class DominoNumber extends StatelessWidget {
  int? number;
  DominoNumber({ this.number });

  Map<int, List<int>> numberMap = {
    0: [],
    1: [4],
    2: [0,8],
    3: [0,4,8],
    4: [0,2,6,8],
    5: [0,2,4,6,8],
    6: [0,1,2,6,7,8]
  };

  List<Widget> generateDominoDots() {
    List<Column> columns = [];

    int dotCount = 0;
    for(var i = 0; i < 3; i++) {
      Column col = Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [],
      );

      for(var d = 0; d < 3; d++) {

        var dotWidget = Visibility(
          visible: numberMap[number]!.contains(dotCount),
          child: ClipOval(
            child: Container(
              width: 15,
              height: 15,
              color: Color(0xFF4A1010)
              )
            ),
          );

        col.children.add(dotWidget);
        dotCount++;
      }

      columns.add(col);
    }
    return columns;
  }
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: generateDominoDots(),
    );
  }

}

class UserDominoPieces extends StatefulWidget {
  @override
  State<UserDominoPieces> createState() => _UserDominoPiecesState();
}

class _UserDominoPiecesState extends State<UserDominoPieces> {
  List<DominoModel> dominos = Utils.takeRandom7Dominos();
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  List<DominoModel> insertedItems = [];

  @override
  void initState() {
    super.initState();

    var future = Future(() {});
    for (var i = 0; i < dominos.length; i++) {
      future = future.then((_) {
        return Future.delayed(const Duration(milliseconds: 125), () {
          insertedItems.add(dominos[i]);
          _key.currentState!.insertItem(i);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 160,
                margin: EdgeInsets.only(left: 20, bottom: 40),
                decoration: BoxDecoration(
                  color: Color(0xFF0D8F9A),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20))
                ),
              )
            ),
            AnimatedList(
              padding: EdgeInsets.only(left: 50),
              key: _key,
              scrollDirection: Axis.horizontal,
              initialItemCount: insertedItems.length,
              itemBuilder: (context, index, animation) {
                var currentDomino = dominos[index];
                return ScaleTransition(
                scale: Tween(begin: 0.6, end: 1.0)
                  .animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOut
                  )),
                  child: FadeTransition(
                    opacity: Tween(begin: 0.0, end: 1.0)
                    .animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
                    child: Draggable(
                      data: currentDomino,
                      child: Container(
                      margin: EdgeInsets.only(right: 10),
                      child: DominoPiece(
                        topNumber: currentDomino.topNumber, 
                        bottomNumber: currentDomino.bottomNumber
                      )
                    ),
                    feedback: Container(
                      margin: EdgeInsets.only(right: 10),
                      child: DominoPiece(
                        topNumber: currentDomino.topNumber, 
                        bottomNumber: currentDomino.bottomNumber
                      )
                    ),
                  )
                  )
                );
              }
            )
          ],
        )
      );
  }
}

class DominoModel {
  int? topNumber;
  int? bottomNumber;

  DominoModel({ this.topNumber, this.bottomNumber });
}

class Utils {

  static List<DominoModel> allDominos() {
    List<DominoModel> dominos = [];

    for(var i = 0; i < 7; i++) {
      for(var j = 0; j < 7; j++) {
        if (dominos.where((DominoModel element) => element.topNumber == i && element.bottomNumber == j).length == 0 &&
        dominos.where((DominoModel element) => element.topNumber == j && element.bottomNumber == i).length == 0) {
          dominos.add(DominoModel(topNumber: i, bottomNumber: j));
        }
      }
    }

    return dominos;
  }

  static List<DominoModel> takeRandom7Dominos() {
    var rand = Random();
    var randomPieces = [];
    
    var index = rand.nextInt(28);
    while(randomPieces.length < 7) {
      if (!randomPieces.contains(index)) {
        randomPieces.add(index);
      }

      index = rand.nextInt(28);
    }

    var allPieces = allDominos();
    List<DominoModel> myPieces = [];
    randomPieces.forEach((element) {
      myPieces.add(allPieces[element]);
    });

    return myPieces;
  }
}

class UserPiecesSelection extends ChangeNotifier {

  bool showUserPieces = false;

  void toggleUserPieces() {
    showUserPieces = !showUserPieces;
    notifyListeners();
  }
}
