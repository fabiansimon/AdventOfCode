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

bool allArrived(List<String> curr) {
  for (String point in curr) {
    if (!point.endsWith("Z")) return false;
  }

  return true;
}

void main() {
  final String filePath = "./dayEight_input.txt";
  List<String> directions = [];
  List<String> curr = [];
  Map<String, List<String>> map = Map<String, List<String>>();

  final String rawData = getFileData(filePath);
  final Iterable<String> lines = LineSplitter.split(rawData);

  populateData(lines, directions, map, curr);

  int moves = 0;

  while (!allArrived(curr)) {
    int directionIdx = directions[moves % directions.length] == "L" ? 0 : 1;
    for (var i = 0; i < curr.length; i++) {
      curr[i] = map[curr[i]]![directionIdx];
    }
    moves++;
  }

  /* PART I
  String curr = "AAA";

  while (curr != "ZZZ") {
    int directionIdx = directions[moves % directions.length] == "L" ? 0 : 1;
    curr = map[curr]![directionIdx];
    moves++;
  }
  */

  print(moves);
}
