import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool oTurn = true;
  List<String> displayElement = ["", "", "", "", "", "", "", "", "",];

  int xScore = 0;

  int oScore = 0;
  int filledBoxes = 0;
 var xStyle=TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.red);
 var oStyle=TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.indigo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tic Tac Toe"),),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.green
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [Text("X player:",style: xStyle,), Text(xScore.toString(),style: xStyle)],
                    ),
                    Column(
                      children: [Text("O player:",style:oStyle), Text(oScore.toString(),style: TextStyle(fontSize: 20,color: Colors.indigo),)],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: GridView.builder(
                itemCount: 9,
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          border: Border.all(color: Colors.white)),
                      child: Center(child: Text(displayElement[index],style: displayElement[index] == "X"?xStyle:oStyle,)),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                clearScoreBoard();
              },
              child: Text(
                "Clear score board",
                style: TextStyle(fontSize: 20),
              ),

            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (oTurn && displayElement[index] == "") {
        displayElement[index] = "X";
        filledBoxes++;
      } else if (!oTurn && displayElement[index] == "") {
        displayElement[index] = "O";
        filledBoxes++;
      }
      oTurn = !oTurn;
      checkWinner();
    });
  }

  void checkWinner() {

    //row
    if (displayElement[0] == displayElement[1] &&
        displayElement[0] == displayElement[2] &&
        displayElement[0] != "") {
      _showWinDialog(displayElement[0]);
    }
    if (displayElement[3] == displayElement[4] &&
        displayElement[3] == displayElement[5] &&
        displayElement[3] != "") {
      _showWinDialog(displayElement[3]);
    }if (displayElement[6] == displayElement[7] &&
        displayElement[6] == displayElement[8] &&
        displayElement[6] != "") {
      _showWinDialog(displayElement[6]);
    }
    //column
    if (displayElement[0] == displayElement[3] &&
        displayElement[0] == displayElement[6] &&
        displayElement[0] != "") {
      _showWinDialog(displayElement[0]);
    }if (displayElement[1] == displayElement[4] &&
        displayElement[1] == displayElement[7] &&
        displayElement[1] != "") {
      _showWinDialog(displayElement[1]);
    }if (displayElement[2] == displayElement[5] &&
        displayElement[2] == displayElement[8] &&
        displayElement[2] != "") {
      _showWinDialog(displayElement[0]);
    }
    //diagonal
    if (displayElement[0] == displayElement[4] &&
        displayElement[0] == displayElement[8] &&
        displayElement[0] != "") {
      _showWinDialog(displayElement[0]);
    }
    if (displayElement[2] == displayElement[4] &&
        displayElement[2] == displayElement[6] &&
        displayElement[2] != "") {
      _showWinDialog(displayElement[2]);
    }else if(filledBoxes==9){
      _showDrawDialog();
    }

  }

  void _showWinDialog(String winner) {
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(

            title: Text("Winner " + winner),
            actions: [
              TextButton(onPressed: (){
                clearBoard();
                Navigator.of(context).pop();
              }, child: Text("Play again"))
            ],

          );
        });
    if(winner=="X"){
      xScore++;
    }else if(winner=="O"){
      oScore++;
    }
  }
  void _showDrawDialog(){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Draw "),
            actions: [
              TextButton(onPressed: (){
                clearBoard();
                Navigator.of(context).pop();
              }, child: Text("Play again"))
            ],
          );
        });
  }

  void clearBoard(){
    setState(() {
    for(int i=0; i < 9;i++){
     displayElement[i]="";

    }
    });
    filledBoxes=0;

  }

  void clearScoreBoard(){
    setState(() {
      xScore=0;
      oScore=0;

      for(int i=0; i<9;i++){
        displayElement[i]="";
      }
    });
    filledBoxes=0;
  }
}
