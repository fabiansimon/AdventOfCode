import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class Main {
    public static void main(String[] args) throws IOException {
        String filePath = "./dayFive_input.txt";

        List<Integer> seeds = new ArrayList<>();
        List<ListNode> nodes = new ArrayList<>();

        addInputData(seeds, nodes, filePath);

        System.out.println(seeds);
        for (ListNode node : nodes) {

            seeds = mapSeeds(seeds, node.mapValues);

            System.out.println("");
            break;
        }

    }

    private static List<Integer> mapSeeds(List<Integer> seeds, List<MapValue> mapValues) {
        List<Integer> newSeeds = new ArrayList<>();

        for (MapValue value : mapValues) {
            int[] range = new int[value.rangeLength];
            for (int i = 0; i < range.length; i++) {
                range
            }
        }

        for (int seed : seeds) {
            System.out.println(seed);
        }

        return seeds;
    }
    private static void addInputData(List<Integer> seeds, List<ListNode> nodes, String path) throws IOException {
        BufferedReader br = new BufferedReader(new FileReader(path));
        String line = br.readLine();


        for (int i = 0; line != null; i++) {
            if (i == 0) {
                for (String nr : line.split(":")[1].trim().split(" ")) {
                    seeds.add(Integer.valueOf(nr));
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
    int destRange;
    int srcRange;
    int rangeLength;

    public MapValue(String s) {
        String[] data = s.split( " ");
        this.destRange = Integer.parseInt(data[0]);
        this.srcRange = Integer.parseInt(data[1]);;
        this.rangeLength = Integer.parseInt(data[2]);
    }
}