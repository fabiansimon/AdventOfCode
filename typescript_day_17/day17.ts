import * as fs from 'fs';

function readFile(path: string): Promise<string> {
    return new Promise((resolve, reject) => {
        fs.readFile(path, 'utf-8', (err, res) => {
            if (err) {
                reject(err)
                return
            }
            resolve(res)            
        })
    })
}

function printMatrix(matrix: string[][]) {
    for (const line of matrix) {
        for (const char of line) {
            process.stdout.write(char);
        }
        console.log();
    }

}

(async function main() {
    const path = "./day17_input.txt";
    const content = await readFile(path);
    const matrix = [];
    for (const line of content.split("\n")) {
        let row = [];
        for (const char of line) {
            row.push(char);
        }
        matrix.push(row);
    }
    printMatrix(matrix)
})()