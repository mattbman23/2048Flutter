import 'package:flutter/material.dart';
import 'package:fclone/controller/boardController.dart';
import 'package:fclone/common/colorTheme.dart';

class FourByFour extends StatefulWidget {
  @override
  _FourByFourState createState() => _FourByFourState();
}

class _FourByFourState extends State<FourByFour> {
  BoardController boardController = BoardController();

  @override
  void initState() {
    super.initState();
    boardController.genNumber();
    boardController.genNumber();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails dragDetails) {
        if (dragDetails.primaryVelocity < 0) {
          boardController.boardMoveLeft();
        } else if (dragDetails.primaryVelocity > 0) {
          boardController.boardMoveRight();
        }
        setState(() {});
      },
      onVerticalDragEnd: (DragEndDetails dragDetails) {
        if (dragDetails.primaryVelocity < 0) {
          boardController.boardMoveUp();
        } else if (dragDetails.primaryVelocity > 0) {
          boardController.boardMoveDown();
        }
        setState(() {});
      },
      child: Scaffold(
          backgroundColor: Color(0xFFFAF8EF),
          body: SafeArea(
            child: Stack(
              children: <Widget>[
                Align(
                    alignment: Alignment.center,
                    child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFBBADA0),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        height: MediaQuery.of(context).size.width * 0.9,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: GridView.builder(
                            primary: true,
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4),
                            itemCount: 4 * 4,
                            itemBuilder: _buildGridItems))),
                Container(
                  color: Colors.transparent,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildGridItems(BuildContext context, int index) {
    int x, y = 0;
    x = (index / 4).floor();
    y = (index % 4);
    int dGridValue = boardController.currentBoard[x][y] ?? 0;

    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: TileColorTheme().colorsMap[dGridValue],
          borderRadius: BorderRadius.circular(7)),
      child: Center(child: _generateItem(dGridValue)),
    );
  }

  Widget _generateItem(int dValue) {
    return Text(
      dValue == 0 ? "" : dValue.toString(),
      style: TextStyle(
          color: (dValue == 2) || (dValue == 4) ? Colors.black45 : Colors.white,
          fontSize: 28),
    );
  }
}
