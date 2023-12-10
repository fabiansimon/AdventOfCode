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
    Map<String, List<String>> map) {
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
      map.putIfAbsent(
          match.group(1)!, () => List.from([match.group(2)!, match.group(3)!]));
    }
  }
}

void main() {
  final String filePath = "./dayEight_input.txt";
  List<String> directions = [];
  Map<String, List<String>> map = Map<String, List<String>>();

  final String rawData = getFileData(filePath);
  final Iterable<String> lines = LineSplitter.split(rawData);

  populateData(lines, directions, map);

  int moves = 0;
  String curr = "AAA";

  while (curr != "ZZZ") {
    int directionIdx = directions[moves % directions.length] == "L" ? 0 : 1;
    curr = map[curr]![directionIdx];
    moves++;
  }

  print(moves);
}
