import fs from 'fs'
const _fs = fs.promises;

const filePath = "./dayThree_input.txt";

function getMatrix(string) {
    const lines = string.split("\n");
    return lines.map(line => line.split(""));
}

function getTotalValidSum(matrix) {
    let sum = 0;
    const width = matrix[0].length;
    const height = matrix.length;

    for (var row = 0; row < height; row++) {
        for (var col = 0; col < width; col++) {
            if (isDigit(matrix[row][col])) {
                let isValid = checkForSymbol(matrix, row, col, width, height);
                let number = matrix[row][col].toString();

                while (col + 1 < width && isDigit(matrix[row][col + 1])) {
                    col++;
                    number += matrix[row][col].toString();
                    if (!isValid) isValid = checkForSymbol(matrix, row, col, width, height);
                }

                if (isValid) sum += Number(number);
            }
        }
    }
    return sum;
}

function checkForSymbol(matrix, row, col, width, height) {
    const directions = [
        [-1, 0],
        [0, -1],
        [-1, -1],
        [-1, 1],
        [1, 0],
        [0, 1],
        [1, -1],
        [1, 1],
    ];

    for (const direction of directions) {
        const newX = col + direction[0];
        const newY = row + direction[1]; 

        if (newX >= 0 && newX < width &&
            newY >= 0 && newY < height && 
            isSymbol(matrix[newY][newX])) {
                return true;
            }
    }
    return false;
}

function isDigit(val) {
    return !isNaN(Number(val));
}

function isSymbol(char) {
    const regex = /[0-9a-zA-Z.]/;
    return !regex.test(char)
}


const rawString = await _fs.readFile(filePath, "utf-8").then(res => res);
const matrix = getMatrix(rawString);

console.log(getTotalValidSum(matrix));
