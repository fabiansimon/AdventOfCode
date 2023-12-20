import * as fs from 'fs';
import { PathFinder } from './pathFinder';

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
    const matrix: number[][] = [];
    for (const line of content.split("\n")) {
        let row: number[] = [];
        for (const char of line) {
            row.push(parseInt(char));
        }
        matrix.push(row);
    }
    return matrix;
}


(async function main() {
    const path = "./day17_input.txt";
    const content = await readFile(path);
    const matrix = generateMatrix(content);

    printMatrix(matrix);
    
    console.log(PathFinder.aStar(matrix));
})()