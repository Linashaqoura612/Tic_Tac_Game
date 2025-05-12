import 'dart:io';

class TicTacToe {
  late List<List<String>> _board;
  String _currentPlayer = 'X';

  void start() {
    print("🎮 Welcome to Tic-Tac-Toe!");

    do {
      _initBoard();
      _playGame();
    } while (_askReplay());
  }

  void _initBoard() {
    _board = List.generate(3, (_) => List.filled(3, ' '));
    _currentPlayer = 'X';
  }

  void _playGame() {
    while (true) {
      _printBoard();
      _handlePlayerMove();

      if (_isWinner()) {
        _printBoard();
        print("🏆 Player $_currentPlayer wins!");
        break;
      }

      if (_isDraw()) {
        _printBoard();
        print("🤝 It's a draw!");
        break;
      }

      _switchPlayer();
    }
  }

  void _printBoard() {
    print("\nCurrent Board:");
    for (int i = 0; i < 3; i++) {
      print(' ${_board[i][0]} | ${_board[i][1]} | ${_board[i][2]}');
      if (i < 2) print('---+---+---');
    }
    print('');
  }

  void _handlePlayerMove() {
    while (true) {
      stdout.write("Player $_currentPlayer, enter a move (1-9): ");
      final input = stdin.readLineSync();

      if (input == null || int.tryParse(input) == null) {
        print("❌ Invalid input. Enter a number from 1 to 9.");
        continue;
      }

      final move = int.parse(input);
      if (move < 1 || move > 9) {
        print("❌ Move must be between 1 and 9.");
        continue;
      }

      final row = (move - 1) ~/ 3;
      final col = (move - 1) % 3;

      if (_board[row][col] != ' ') {
        print("⚠️ Cell already occupied.");
        continue;
      }

      _board[row][col] = _currentPlayer;
      break;
    }
  }

  bool _isWinner() {
    for (int i = 0; i < 3; i++) {
      if (_board[i][0] == _currentPlayer &&
          _board[i][1] == _currentPlayer &&
          _board[i][2] == _currentPlayer) return true;

      if (_board[0][i] == _currentPlayer &&
          _board[1][i] == _currentPlayer &&
          _board[2][i] == _currentPlayer) return true;
    }

    if (_board[0][0] == _currentPlayer &&
        _board[1][1] == _currentPlayer &&
        _board[2][2] == _currentPlayer) return true;

    if (_board[0][2] == _currentPlayer &&
        _board[1][1] == _currentPlayer &&
        _board[2][0] == _currentPlayer) return true;

    return false;
  }

  bool _isDraw() {
    for (final row in _board) {
      if (row.contains(' ')) return false;
    }
    return true;
  }

  void _switchPlayer() {
    _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
  }

  bool _askReplay() {
    stdout.write("🔁 Play again? (y/n): ");
    final input = stdin.readLineSync();
    return input != null && input.toLowerCase() == 'y';
  }
}

void main() {
  final game = TicTacToe();
  game.start();
}
