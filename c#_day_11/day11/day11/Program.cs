﻿
string filePath = "../../../day11_input.txt";

HashSet<int> vertical = new HashSet<int>();
HashSet<int> horizontal = new HashSet<int>();

List<List<char>> input = getFileInput(filePath);

const int EXPAND_MULTIPLIER = 10;
// Console.WriteLine(input[0].Count); // width
// Console.WriteLine(input.Count); // height

List<int[]> coordinates = getCoordinates(input);

HashSet<(char, char)> usedPairs = new HashSet<(char, char)>();


int distance = 0, count = 0;

foreach (int[] origin in coordinates)
{

    foreach (int[] target in coordinates)
    {
        if (target.SequenceEqual(origin)) continue;

        char o = input[origin[0]][origin[1]];
        char t = input[target[0]][target[1]];

        if (!usedPairs.Contains((o, t)) &&
            !usedPairs.Contains((t, o)))
        {
            distance += getDistance(origin, target);
            usedPairs.Add((o, t));

            //Console.WriteLine(distance);
        }   
    }

}

printArr(input);


Console.WriteLine("distance: " + distance);


/*
 * Functionality 
 * |
 * v
 */

int getDistance(int[] origin, int[] target) 
{
    int distance = 0;
    int multiplier = 0;
    int[] start = new int[origin.Length];
    Array.Copy(origin, start, origin.Length);

    HashSet<int> horizontalVisited = new HashSet<int>();
    HashSet<int> verticalVisited = new HashSet<int>();

    while (start[0] != target[0] || start[1] != target[1])
    {
        // Console.WriteLine("[" + start[0] + ", " + start[1] + "]");

        if (horizontal.Contains(start[0]) && !horizontalVisited.Contains(start[0]))
        {
            horizontalVisited.Add(start[0]);
            multiplier++;
            // Console.WriteLine("Horizontal Line");

            if (vertical.Contains(start[1])) verticalVisited.Add(start[1]);
        }

        if (vertical.Contains(start[1]) && !verticalVisited.Contains(start[1]))
        {
            verticalVisited.Add(start[1]);
            multiplier++;
            // Console.WriteLine("Vertical Line");

            if (horizontal.Contains(start[0])) horizontalVisited.Add(start[0]);
        }

        if (distance % 2 == 0)
        {
            int move = Math.Sign(target[0] - start[0]);
            start[0] += move;
            start[1] += (move == 0) ? Math.Sign(target[1] - start[1]) : 0;
        } else
        {
            int move = Math.Sign(target[1] - start[1]);
            start[1] += move;
            start[0] += (move == 0) ? Math.Sign(target[0] - start[0]) : 0;
        }

        distance++;

        if (false && input[origin[0]][origin[1]] == '5' && input[target[0]][target[1]] == '9')
        {
            input[start[0]][start[1]] = 'v';
        }

    }

    // Console.WriteLine(horizontalVisited.Count + verticalVisited.Count);

    distance += (multiplier * EXPAND_MULTIPLIER) - multiplier;

    return distance; 
    // return Math.Abs(origin[0] - target[0]) + Math.Abs(origin[1] - target[1]); 
}

static List<int[]> getCoordinates(List<List<char>> matrix)
{
    List<int[]> coords = new List<int[]>();

    for (int i = 0; i < matrix.Count; i++)
    {

        for (int j = 0; j < matrix[0].Count; j++)
        {
            char c = matrix[i][j];
            if (c != '.' && c != '@') coords.Add(new int[] { i, j });

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


List<List<char>> getFileInput(string path)
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
                        chars.Add('.');
                    }
                }

               
                inputArr.Add(chars);

                if (isEmpty)
                {
                    horizontal.Add(inputArr.Count);
                    inputArr.Add(Enumerable.Repeat('@', line.Length).ToList());
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
                inputArr[j].Insert(i+offset, '@');
            }

            vertical.Add(i);
            offset++;

        }
    }

    return inputArr;
}
