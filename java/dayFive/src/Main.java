import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) throws IOException {
        String filePath = "./dayFive_input.txt";

        List<List<Integer>> maps = new ArrayList<>();
        List<Integer> seeds = new ArrayList<>();

        BufferedReader br = new BufferedReader(new FileReader(filePath));
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

                ListMapNode node = new ListMapNode(input, new ListMapNode());
            }
            line = br.readLine();

        }

        System.out.println(seeds);
    }
}

class ListMapNode {
    List<MapValue> mapValues;
    ListMapNode next;

    public ListMapNode() {}

    public ListMapNode(List<MapValue> mapValues, ListMapNode next) {
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