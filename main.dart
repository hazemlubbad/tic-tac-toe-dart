import 'dart:io';

void main() {
  print("🎮 Welcome to Tic-Tac-Toe in Dart!");

  bool playAgain = true;

  while (playAgain) {

    final game = TicTacToe();
    game.startGame();
    
    print("Do you want to play again? (y/n)");
    final input = stdin.readLineSync()?.toLowerCase();

    if (input != 'y') {
      playAgain = false;
    }
  }

  print("👋 Thanks for playing!");
}

class TicTacToe {
  late List<List<String>> board;
  late String currentPlayer;
  late String playerOne;
  late String playerTwo;

  void startGame() {
    initializeBoard();
    chooseMarkers();
    printBoard();

    while (true) {
      takeTurn(currentPlayer);
      printBoard();

      if (checkWin(currentPlayer)) {
        print("🎉 Player $currentPlayer wins!");
        break;
      }

      if (isDraw()) {
        print("🟰 It's a draw!");
        break;
      }

      switchPlayer();
    }
  }

  void initializeBoard() {
    board = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
    ];
  }

  void chooseMarkers() {
    print("Player 1, do you want to be X or O?");
    String? choice = stdin.readLineSync()?.toUpperCase();

    if (choice == 'X') {
      playerOne = 'X';
      playerTwo = 'O';
    } else {
      playerOne = 'O';
      playerTwo = 'X';
    }

    currentPlayer = playerOne;
    print("Player 1 is $playerOne, Player 2 is $playerTwo");
  }

  void printBoard() {
    print("");
    for (var row in board) {
      print(" ${row[0]} | ${row[1]} | ${row[2]} ");
      if (board.indexOf(row) < 2) {
        print("---+---+---");
      }
    }
    print("");
  }

  void takeTurn(String player) {
    int move = -1;

    while (true) {
      print("Player $player, enter your move (1-9):");
      String? input = stdin.readLineSync();

      if (input == null || input.isEmpty) {
        print("Invalid input. Please try again.");
        continue;
      }

      if (int.tryParse(input) == null) {
        print("Please enter a number between 1 and 9.");
        continue;
      }

      move = int.parse(input);

      if (move < 1 || move > 9) {
        print("Number must be between 1 and 9.");
        continue;
      }

      int row = (move - 1) ~/ 3;
      int col = (move - 1) % 3;

      if (board[row][col] == 'X' || board[row][col] == 'O') {
        print("That spot is already taken. Try another one.");
        continue;
      }

      board[row][col] = player;
      break;
    }
  }

  void switchPlayer() {
    currentPlayer = (currentPlayer == playerOne) ? playerTwo : playerOne;
  }

  bool checkWin(String player) {
    // Check rows
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == player && board[i][1] == player && board[i][2] == player) {
        return true;
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (board[0][i] == player && board[1][i] == player && board[2][i] == player) {
        return true;
      }
    }

    // Check diagonals
    if (board[0][0] == player && board[1][1] == player && board[2][2] == player) {
      return true;
    }
    if (board[0][2] == player && board[1][1] == player && board[2][0] == player) {
      return true;
    }

    return false;
  }

  bool isDraw() {
    for (var row in board) {
      for (var cell in row) {
        if (cell != 'X' && cell != 'O') {
          return false;
        }
      }
    }
    return true;
  }
}