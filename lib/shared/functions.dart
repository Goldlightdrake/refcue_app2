import 'dart:math';

import 'const.dart';

String takeDate() {
  var currrentDate = DateTime.now();
  String day = currrentDate.day.toString();
  String month = '';
  switch (currrentDate.month) {
    case 1:
      {
        month = 'Stycznia';
      }
      break;
    case 2:
      {
        month = 'Lutego';
      }
      break;
    case 3:
      {
        month = 'Marca';
      }
      break;
    case 4:
      {
        month = 'Kwietnia';
      }
      break;
    case 5:
      {
        month = 'Maja';
      }
      break;
    case 6:
      {
        month = 'Czerwca';
      }
      break;
    case 7:
      {
        month = 'Lipca';
      }
      break;
    case 8:
      {
        month = 'Sierpnia';
      }
      break;
    case 9:
      {
        month = 'Września';
      }
      break;
    case 10:
      {
        month = 'Października';
      }
      break;
    case 11:
      {
        month = 'Listopada';
      }
      break;
    case 12:
      {
        month = 'Grudnia';
      }
      break;
  }

  String result = day + ' ' + month;
  return result;
}

// ignore: missing_return
int colorOfAnswer(answer) {
  switch (answer) {
    case 0:
      {
        return 0xffff073a;
      }

    case 1:
      {
        return 0xeeF2EA02;
      }

    case 2:
      {
        return 0xee39FF14;
      }
    default:
      {
        return 0xffff073a;
      }
  }
}

List<int> randNumbersInRange(int amount, int count) {
  Set<int> randomIdsSet = Set();
  while (randomIdsSet.length < amount) {
    int randomIndex = Random().nextInt(count);
    randomIdsSet.add(randomIndex);
  }
  return List.from(randomIdsSet);
}

int randNumberInRange(int count, List<int>? withOut) {
  int randomIndex = Random().nextInt(count);
  if (withOut != null) {
    while (withOut.any((e) => e == randomIndex)) {
      randomIndex = Random().nextInt(count);
    }
  }
  return randomIndex;
}

String firstFewWords(String bigSentence) {
  int? startIndex = 0, indexOfSpace;

  for (int i = 0; i < 6; i++) {
    indexOfSpace = bigSentence.indexOf(' ', startIndex!);
    if (indexOfSpace == -1) {
      return bigSentence;
    }
    startIndex = indexOfSpace + 1;
  }

  return bigSentence.substring(0, indexOfSpace) + '...';
}

String changingViewOfAnswer(String awfullAnswer) {
  List<String> answer = awfullAnswer.replaceAll(' ', '').split(',');
  return answer.join('');
}

String greatViewOfScore(double score) {
  if (score % 1 == 0) {
    return score.round().toString();
  }
  return score.toString();
}

String getIconForArticle(int index) {
  switch (index) {
    case 1:
      return article1IconPath;

    case 2:
      return article2IconPath;

    case 3:
      return article3IconPath;

    case 4:
      return article4IconPath;

    case 5:
      return article5IconPath;

    case 6:
      return article6IconPath;

    case 7:
      return article7IconPath;

    case 8:
      return article8IconPath;

    case 9:
      return article9IconPath;

    case 10:
      return article10IconPath;

    case 11:
      return article11IconPath;

    case 12:
      return article12IconPath;

    default:
      return article1IconPath;
  }
}
