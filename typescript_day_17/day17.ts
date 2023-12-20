import * as fs from 'fs';

function readFile(path: string): Promise<string> {
    return new Promise((resolve, reject) => {
        fs.readFile(path, 'utf-8', (err, res) => {
            if (err) {
                reject(err);
                return
            }
            resolve(res);            
        })
    })
}

function printMatrix(matrix: number[][]) {
    for (const line of matrix) {
        for (const char of line) {
            process.stdout.write(char.toString());
        }
        console.log();
    }
}

function generateMatrix(content: string) {
    const matrix = [];
    for (const line of content.split("\n")) {
        let row = [];
        for (const char of line) {
            row.push(parseInt(char));
        }
        matrix.push(row);
    }
    return matrix;
}

function findMinCostPath(matrix: number[][]) {
    var min = 10, straightMoves = 0, curr = 0, coord = [0, 0];
    const width = matrix[0].length, height = matrix.length;

    dfs(coord, width, height, straightMoves, min, curr);
    return min;
}

function dfs(coordinates: Number[], width: Number, height: Number,
            straightMoves: Number, min: Number, curr: Number) {
    if (curr > min) return min;
            
        
}

(async function main() {
    const path = "./day17_input.txt";
    const content = await readFile(path);
    const matrix = generateMatrix(content);
    printMatrix(matrix);
    console.log(findMinCostPath(matrix))
})()