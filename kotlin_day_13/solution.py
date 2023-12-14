
file = [p.split() for p in open("day13_input.txt").read().split('\n\n')]

def num_of_diff(line1, line2, diff):
    d = 0
    for a, b in zip(line1, line2):
        if a != b: d += 1
        if d > diff: break
    return d

def find_mirror(patt, diff=0):
    for r in range(len(patt)-1):
        d = 0
        for i in range(min(r+1, len(patt)-r-1)):
            d += num_of_diff(patt[r-i], patt[r+1+i], diff)
            if d > diff: break
        else:
            if d == diff:
                return r+1, 0
    return find_mirror(list(zip(*patt)), diff)[::-1]

p1 = 0
p2 = 0
for patt in file:
    r, c = find_mirror(patt, 0)
    print(f"Col: {c}, Row: {r}")
    p1 += c+100*r
    r, c = find_mirror(patt, 1)
    p2 += c+100*r
print(p1, p2)
