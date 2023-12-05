
file_path="./dayTwo_input.txt"

occs = {
    "blue": 0,
    "red": 0,
    "green": 0,
}
goal = {
    "blue": 14,
    "red": 12,
    "green": 13
}
sum = 0

def get_number(string):
    for idx, char in enumerate(string[::-1]):    
        if not char.isdigit():
            return string[(len(string)-idx):len(string)]

def parse_cube(cube):
    parts = cube.split(" ")
    amount = parts[0]
    color = parts[1]

    occs[color] = max(occs[color], int(amount))

with open(file_path, 'r') as file:
    for l in file:
        line = l.strip();
        parts = line.split(":")
        sets = parts[1].split(";")

        for set in sets:
            cubes = set.split(",")
            for cube in cubes:
                parse_cube(cube.strip())

        if occs["blue"] <= goal["blue"] and occs["red"] <= goal["red"] and occs["green"] <= goal["green"]:
            game_id = get_number(parts[0])
            sum += int(game_id)

        occs = {
            "blue": 0,
            "red": 0,
            "green": 0,
        }

print(sum)
