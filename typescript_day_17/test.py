from typing import List

def min_path_sum(grid: List[List[int]]) -> int:
    if not grid:
        return 0
    
    m, n = len(grid), len(grid[0])

    # column's 0th row sum
    for j in range(1, n):
        grid[0][j] = grid[0][j-1] + grid[0][j]

    # row's 0th column sum
    for i in range(1, m):
        grid[i][0] = grid[i-1][0] + grid[i][0]

    # computing rest of the grid
    for i in range(1, m):
        for j in range(1, n):
            grid[i][j] = min(grid[i-1][j], grid[i][j-1]) + grid[i][j]

    
    return grid[-1][-1]


grid = [
    [1, 3, 1], 
    [1, 5, 1],
    [4, 2, 1]
]
grid1 = [
    [1, 2, 3], 
    [4, 5, 6]
]

grid2 = [
    [2,4,1,3,4,3,2,3,1,1,3,2,3],
    [3,2,1,5,4,5,3,5,3,5,6,2,3],
    [3,2,5,5,2,4,5,6,5,4,2,5,4],
    [3,4,4,6,5,8,5,8,4,5,4,5,2],
    [4,5,4,6,6,5,7,8,6,7,5,3,6],
    [1,4,3,8,5,9,8,7,9,8,4,5,4],
    [4,4,5,7,8,7,6,9,8,7,7,6,6],
    [3,6,3,7,8,7,7,9,7,9,6,5,3],
    [4,6,5,4,9,6,7,9,8,6,8,8,7],
    [4,5,6,4,6,7,9,9,8,6,4,5,3],
    [1,2,2,4,6,8,6,8,6,5,5,6,3],
    [2,5,4,6,5,4,8,8,8,7,7,3,5],
    [4,3,2,2,6,7,4,6,5,5,5,3,3],
]

print(min_path_sum(grid)) # prints 7
print(min_path_sum(grid2)) # prints 12