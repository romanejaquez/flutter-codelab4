import 'dart:math';
import 'package:flutter/material.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
 runApp(MyApp());
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

class MyWidget extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
  var dominos = Utils.takeRandom7Dominos();
  return Container(
   child: Stack(
      children: [
        Transform.scale(
          scale: 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DominoPiece(topNumber: 1, bottomNumber: 6),
              DominoPiece(topNumber: 2, bottomNumber: 5),
              Draggable(
                child: DominoPiece(topNumber: 3, bottomNumber: 4),
                feedback: Transform.scale(
                  scale: 0.8,
                  child: Transform.translate(
                  offset: Offset(
                    (MediaQuery.of(context).size.width / 2 - 10), 0.0),
                  child: DominoPiece(topNumber: 3, bottomNumber: 4),
                )
                ),
              )
            ]
          )
        ),
        Align(
          alignment: Alignment.topRight,
          child: UserBadge(opponent: false)
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: UserBadge(opponent: true)
        ),
        Positioned(
          bottom: 0, left: 0, right: 0,
          child: Container(
            height: 300,
            child: ListView.builder(
              padding: EdgeInsets.only(left: 40),
              scrollDirection: Axis.horizontal,
              itemCount: dominos.length,
              itemBuilder: (context, index) {
                var currentDomino = dominos[index];
                return Container(
                  margin: EdgeInsets.only(right: 10),
                  child: DominoPiece(
                    topNumber: currentDomino.topNumber, 
                    bottomNumber: currentDomino.bottomNumber
                  )
                );
              },
            )
          )
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
  
  UserBadge({ this.opponent });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 150,
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 40),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(top: 50),
              padding: EdgeInsets.only(top: 30, left: 15, bottom: 12, right: 15),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Text('3 Pieces Remaining', style: TextStyle(color: Colors.white, fontSize: 10))
            )
          ),
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
                  Text('linda0516', style: TextStyle(color: Colors.white))
                ]
              )
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://image.freepik.com/free-photo/close-up-shot-pretty-woman-with-perfect-teeth-dark-clean-skin-having-rest-indoors-smiling-happily-after-received-good-positive-news_273609-1248.jpg'),
                  fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [BoxShadow(offset: Offset.zero, blurRadius: 20, color: Colors.black.withOpacity(0.5))],
                border: Border.all(width: 3, color: opponent! ? Color(0xFFEF1C44) : Color(0xFFB0B704))
              )
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
