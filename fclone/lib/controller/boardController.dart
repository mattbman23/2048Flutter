import 'dart:math';

class BoardController {
  List<List<int>> currentBoard;

  BoardController() {
    currentBoard = List.generate(4, (index) => List.generate(4, (index) => 0));
  }

  void genNumber() {
    List<List<int>> availableSpaces = [];
    for (int i = 0; i < currentBoard.length; i++) {
      for (int k = 0; k < currentBoard[i].length; k++) {
        if (currentBoard[i][k] == 0) {
          availableSpaces.add([i, k]);
        }
      }
    }

    if (availableSpaces.length == 0) {
      return;
    }

    List<int> randomIndex =
        availableSpaces[Random().nextInt(availableSpaces.length)];
    currentBoard[randomIndex[0]][randomIndex[1]] =
        Random().nextInt(9) == 0 ? 4 : 2;
  }

  void boardMoveLeft() {
    currentBoard = currentBoard.map((row) => slideLeft(row)).toList();
    genNumber();
  }

  List<int> slideLeft(List<int> row) {
    int orginalLength = row.length;
    row = row.where((val) => val != 0).toList();

    for (int i = 0; i < row.length - 1; i++) {
      int firstNum = row[i];
      int secondNum = row[i + 1];
      if (firstNum == secondNum) {
        row[i] = firstNum + secondNum;
        row[i + 1] = 0;
      }
    }

    row = row.where((val) => val != 0).toList();
    int zeroesToInsert = orginalLength - row.length;
    row.addAll(List.generate(zeroesToInsert, (index) => 0));
    return row;
  }

  void boardMoveRight() {
    currentBoard = currentBoard.map((row) => slideRight(row)).toList();
    genNumber();
  }

  List<int> slideRight(List<int> row) =>
      slideLeft(row.reversed.toList()).reversed.toList();

  void boardMoveUp() {
    currentBoard = boardTransposed(
        boardTransposed(currentBoard).map((row) => slideLeft(row)).toList());
    genNumber();
  }

  void boardMoveDown() {
    currentBoard = boardTransposed(
        boardTransposed(currentBoard).map((row) => slideRight(row)).toList());
    genNumber();
  }

  List<List<int>> boardTransposed(List<List<int>> board) {
    List<List<int>> result = [];
    for (int i = 0; i < board.length; i++) {
      result.add(board.map((row) => row[i]).toList());
    }
    return result;
  }
}
