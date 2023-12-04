import re

file_path="./dayTwo_input.txt"

with open(file_path, 'r') as file:
    for l in file:

        pattern = re.compile(r'Game (\d+): ((\d+ [a-zA-Z]+, )*\d+ [a-zA-Z]+);')
        line = l.strip()
        matches = pattern.findall(line)
        
        match = matches[0]
        print(matches)
        game_number = match[0]
        color_sets = match[1].split(';')

        print(f"Game {game_number}")        

        for color_set in color_sets:
            print(f"  {color_set.strip()}")

