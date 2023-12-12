
string filePath = "../../../day11_input.txt";

List<List<char>> input = getFileInput(filePath);

// Console.WriteLine(input[0].Count); // width
// Console.WriteLine(input.Count); // height

List<int[]> coordinates = getCoordinates(input);

HashSet<char[]> usedPairs = new HashSet<char[]>();
int distance = 0, count = 0;

// printArr(input);

foreach (int[] origin in coordinates)
{
    Console.WriteLine(count++);

    foreach (int[] target in coordinates)
    {
        char o = input[origin[0]][origin[1]];
        char t = input[target[0]][target[1]];

        if (!usedPairs.Any(pair => pair.SequenceEqual(new char[] { o, t })) &&
            !usedPairs.Any(pair => pair.SequenceEqual(new char[] { t, o })) &&
            !target.SequenceEqual(origin))
        {
            distance += getDistance(origin, target);
            usedPairs.Add(new char[] { o, t });

        }
    }
}

Console.WriteLine(distance);


/*
 * Functionality 
 * |
 * v
 */

static int getDistance(int[] origin, int[] target)
{
    return Math.Abs(origin[0] - target[0]) + Math.Abs(origin[1] - target[1]);
}

static List<int[]> getCoordinates(List<List<char>> matrix)
{
    List<int[]> coords = new List<int[]>();

    for (int i = 0; i < matrix.Count; i++)
    {

        for (int j = 0; j < matrix[0].Count; j++)
        {

            if (matrix[i][j] != '.') coords.Add(new int[] { i, j });

        }

    }

    return coords;

}

static void printArr(List<List<char>> data)
{
    foreach (List<char> line in data)
    {
        foreach (char c in line)
        {
            Console.Write(c);
        }

        Console.WriteLine();
    }
}


static List<List<char>> getFileInput(string path)
{
    List<List<char>> inputArr = new List<List<char>>();
    int[] occ = null;
    int count = 49; 
    try
    {

        using (StreamReader sr = new StreamReader(path))
        {

            while (!sr.EndOfStream)
            {

                List<char> chars = new List<char>();
                string line = sr.ReadLine();
                bool isEmpty = true;

                if (line == null) break;

                occ ??= new int[line.Length];

                for (int i = 0; i < line.Length; i++)
                {
                    char c = line[i];
                    
                    if (c == '#')
                    {
                        isEmpty = false;
                        occ[i] ++;
                        chars.Add((char) count++);
                    } else
                    {
                        chars.Add(c);
                    }
                }

               
                inputArr.Add(chars);

                if (isEmpty)
                {
                    inputArr.Add(Enumerable.Repeat('.', line.Length).ToList());
                }

            }

        }

    } catch (Exception e)
    {

        Console.WriteLine(e.Message);

    }

    int offset = 0;
    for (int i = 0; i < occ.Length; i++) 
    {

        if (occ[i] == 0)
        {

            for (int j = 0; j < inputArr.Count; j++)
            {
                inputArr[j].Insert(i+offset, '.');
            }

            offset++;

        }
    }

    return inputArr;
}
