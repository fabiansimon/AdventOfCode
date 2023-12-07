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


            line = br.readLine();
        }

        System.out.println(seeds);
    }
}