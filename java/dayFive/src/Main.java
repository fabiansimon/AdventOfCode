import org.w3c.dom.ls.LSParserFilter;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class Main {
    public static void main(String[] args) throws IOException {
        String filePath = "./dayFive_input.txt";

        List<Long> seeds = new ArrayList<>();
        List<ListNode> nodes = new ArrayList<>();

        addInputData(seeds, nodes, filePath);

        for (ListNode node : nodes) {
            seeds = mapSeeds(seeds, node.mapValues);
        }

        long res = Long.MAX_VALUE;
        for (long seed : seeds) {
            res = Math.min(res, seed);
        }

        System.out.println(res);
    }

    private static List<Long> mapSeeds(List<Long> seeds, List<MapValue> mapValues) {
        List<Long> newSeeds = new ArrayList<>();

        for (int i = 0; i < seeds.size(); i++) {
            long seed = seeds.get(i);
            for (MapValue value : mapValues) {
                long min = value.srcRange;
                long max = min + value.rangeLength;
                if (seed >= min && seed < max) {
                    newSeeds.add(value.destRange + (seed - min));
                    break;
                }
            }

            if (newSeeds.size()-1 < i) {
                newSeeds.add(seed);
            }
        }

        return newSeeds;
    }
    private static void addInputData(List<Long> seeds, List<ListNode> nodes, String path) throws IOException {
        BufferedReader br = new BufferedReader(new FileReader(path));
        String line = br.readLine();


        for (int i = 0; line != null; i++) {
            if (i == 0) {
                for (String nr : line.split(":")[1].trim().split(" ")) {
                    seeds.add(Long.parseLong(nr));
                }
                continue;
            }

            if (line.length() == 0) {
                br.readLine();
                line = br.readLine();
                List<MapValue> input = new ArrayList<>();

                while (line.length() > 0) {
                    input.add(new MapValue(line));
                    line = br.readLine();

                    if (line == null) break;
                }

                nodes.add(new ListNode(input));
                continue;

            }

            line = br.readLine();
        }
    }
}


class ListNode {
    List<MapValue> mapValues;
    ListNode next;

    public ListNode() {}

    public ListNode(List<MapValue> mapValues) {
        this.mapValues = mapValues;
    }

    public ListNode(List<MapValue> mapValues, ListNode next) {
        this.mapValues = mapValues;
        this.next = next;
    }
}

class MapValue {
    long destRange;
    long srcRange;
    long rangeLength;

    public MapValue(String s) {
        String[] data = s.split( " ");
        this.destRange = Long.parseLong(data[0]);
        this.srcRange = Long.parseLong(data[1]);;
        this.rangeLength = Long.parseLong(data[2]);
    }
}