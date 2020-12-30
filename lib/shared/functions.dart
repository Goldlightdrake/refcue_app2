import 'dart:math';

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
      break;
    case 1:
      {
        return 0xeeF2EA02;
      }
      break;
    case 2:
      {
        return 0xee39FF14;
      }
      break;
  }
}

List numberInRange(int amount) {
  Random random = Random();
  var randomList =
      new List<int>.generate(amount, (int index) => random.nextInt(18) + 1);
  randomList.shuffle();
  return randomList;
}

String firstFewWords(String bigSentence) {
  int startIndex = 0, indexOfSpace;

  for (int i = 0; i < 6; i++) {
    indexOfSpace = bigSentence.indexOf(' ', startIndex);
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
