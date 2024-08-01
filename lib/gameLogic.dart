import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:matrices/matrices.dart';

class Gamelogic {
  List<double> generate(List<double> l, Function(int l) fun) {
    List<int> indexes = [];
    int sum = 0;
    for (int i = 0; i < l.length; i++) {
      if (l[i] == 0) {
        indexes.add(i);
      }
    }
    if (indexes.isEmpty) {
      return l;
    }
    int index = Random().nextInt(indexes.length);
    l[indexes[index]] = 2;
    for (int i = 0; i < l.length; i++) {
      sum += l[i].toInt();
    }
    fun(sum);
    return l;
  }

  List<double> swiperight(List<double> l) {
    var matrix2 = Matrix.fromFlattenedList(l, 4, 4);

    for (int i = 0; i < 4; i++) {
      matrix2.setRow(mergeAndMoveRight(matrix2.row(i)), i);
    }
    List<double> res = matrixToArray(matrix2.matrix);
    return res;
  }

  List<double> swipeleft(List<double> l) {
    var matrix2 = Matrix.fromFlattenedList(l, 4, 4);

    for (int i = 0; i < 4; i++) {
      matrix2.setRow(mergeAndMoveLeft(matrix2.row(i)), i);
    }
    List<double> res = matrixToArray(matrix2.matrix);
    return res;
  }

  List<double> swipeup(List<double> l) {
    var matrix2 = Matrix.fromFlattenedList(l, 4, 4);

    for (int i = 0; i < 4; i++) {
      matrix2.setColumn(mergeAndMoveUp(matrix2.column(i)), i);
    }
    List<double> res = matrixToArray(matrix2.matrix);
    return res;
  }

  List<double> swipedown(List<double> l) {
    var matrix2 = Matrix.fromFlattenedList(l, 4, 4);

    for (int i = 0; i < 4; i++) {
      matrix2.setColumn(mergeAndMoveDown(matrix2.column(i)), i);
    }
    List<double> res = matrixToArray(matrix2.matrix);
    return res;
  }

  List<double> mergeAndMoveRight(List<double> row) {
    List<double> newRow = moveNonNullableToBack(row);
    for (int i = newRow.length - 1; i > 0; i--) {
      if (newRow[i] == newRow[i - 1] && newRow[i] != 0) {
        newRow[i] *= 2;
        newRow[i - 1] = 0;
      }
    }
    return moveNonNullableToBack(newRow);
  }

  List<double> mergeAndMoveLeft(List<double> row) {
    List<double> newRow = moveNonNullableToFront(row);
    for (int i = 0; i < newRow.length - 1; i++) {
      if (newRow[i] == newRow[i + 1] && newRow[i] != 0) {
        newRow[i] *= 2;
        newRow[i + 1] = 0;
      }
    }
    return moveNonNullableToFront(newRow);
  }

  List<double> mergeAndMoveUp(List<double> column) {
    List<double> newColumn = moveNonNullableToFront(column);
    for (int i = 0; i < newColumn.length - 1; i++) {
      if (newColumn[i] == newColumn[i + 1] && newColumn[i] != 0) {
        newColumn[i] *= 2;
        newColumn[i + 1] = 0;
      }
    }
    return moveNonNullableToFront(newColumn);
  }

  List<double> mergeAndMoveDown(List<double> column) {
    List<double> newColumn = moveNonNullableToBack(column);
    for (int i = newColumn.length - 1; i > 0; i--) {
      if (newColumn[i] == newColumn[i - 1] && newColumn[i] != 0) {
        newColumn[i] *= 2;
        newColumn[i - 1] = 0;
      }
    }
    return moveNonNullableToBack(newColumn);
  }

  List<double> moveNonNullableToFront(List<double> list) {
    List<double> nonNullList = list.where((element) => element != 0).toList();
    List<double> nullList = list.where((element) => element == 0).toList();
    return nonNullList + nullList;
  }

  List<double> moveNonNullableToBack(List<double> list) {
    List<double> nonNullList = list.where((element) => element != 0).toList();
    List<double> nullList = list.where((element) => element == 0).toList();
    return nullList + nonNullList;
  }

  List<double> matrixToArray(List<List<double>> matrix) {
    List<double> array = [];
    for (var row in matrix) {
      for (var item in row) {
        array.add(item);
      }
    }
    return array;
  }

  Color getColorForNumber(int number) {
    Map<int, Color> numberColors = {
      2: const Color(0xFFEEE4DA),
      4: const Color(0xFFEDE0C8),
      8: const Color(0xFFF2B179),
      16: const Color(0xFFF59563),
      32: const Color(0xFFF67C5F),
      64: const Color(0xFFF65E3B),
      128: const Color(0xFFEDCF72),
      256: const Color(0xFFEDCC61),
      512: const Color(0xFFEDC850),
      1024: const Color(0xFFEDC53F),
      2048: const Color(0xFFEDC22E),
      // Add more colors as needed
    };
    return numberColors[number] ??
        Colors.grey; // Default color if the number is not found
  }
}
