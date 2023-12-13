import 'dart:convert';
import 'dart:io';

String getFileData(String path) {
  try {
    var file = File(path);
    var content = file.readAsStringSync();
    return content;
  } catch (e) {
    print("smth went wrong");
    return "";
  }
}

void populateData(Iterable<String> lines, List<String> directions,
    Map<String, List<String>> map, List<String> starts) {
  RegExp reg = RegExp(r'(\w+) = \((\w+), (\w+)\)');
  RegExpMatch match;

  for (var i = 0; i < lines.length; i++) {
    String curr = lines.elementAt(i);
    if (i == 0) {
      directions.addAll(curr.split(""));
      continue;
    }

    if (!curr.isEmpty) {
      match = reg.firstMatch(curr)!;
      String key = match.group(1)!;

      if (key.endsWith("A")) starts.add(key);

      map.putIfAbsent(key, () => List.from([match.group(2)!, match.group(3)!]));
    }
  }
}

int gcd(int a, int b) {
  while (b != 0) {
    final int temp = b;
    b = a % b;
    a = temp;
  }
  return a.abs();
}

int lcm(int a, int b) {
  return (a * b ~/ gcd(a, b)).abs();
}

int findLCM(List<int> numbers) {
  int result = 1;
  for (int num in numbers) {
    result = lcm(result, num);
  }
  return result;
}

void main() {
  final String filePath = "./dayEight_input.txt";
  List<String> directions = [];
  List<String> curr = [];
  Map<String, List<String>> map = Map<String, List<String>>();

  final String rawData = getFileData(filePath);
  final Iterable<String> lines = LineSplitter.split(rawData);

  populateData(lines, directions, map, curr);

  List<int> movesEach = [];

  int moves = 0;
  for (var i = 0; i < curr.length; i++) {
    moves = 0;
    while (!curr[i].endsWith("Z")) {
      int directionIdx = directions[moves++ % directions.length] == "L" ? 0 : 1;
      curr[i] = map[curr[i]]![directionIdx];
    }

    movesEach.add(moves);
  }

  moves = findLCM(movesEach);

  // /* PART I
  // String c = "AAA";

  // while (c != "ZZZ") {
  //   int directionIdx = directions[moves % directions.length] == "L" ? 0 : 1;
  //   c = map[c]![directionIdx];
  //   moves++;
  // }

  print(moves);
}
