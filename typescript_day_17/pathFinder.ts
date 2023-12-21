import { MinHeap } from "./minHeap";
import { NNode } from "./node";

export interface Coordinate {
    x: number
    y: number
}

export class PathFinder {
    static rows: number;
    static cols: number;
    static matrix: number[][];

    constructor() {}
    
    static aStar(matrix: number[][]) {
        this.rows = matrix.length;
        this.cols = matrix[0].length;
        this.matrix = matrix;

        const start = { x: 0, y: 0 };
        const target = { x: this.cols - 1, y: this.rows - 1 };

        const openSet: MinHeap = new MinHeap();
        const visited: Set<string> = new Set();

        const startNode = new NNode(start.x, start.y, null, 0, this.heuristicCost(start, target));
        openSet.add(startNode);

        while (!openSet.isEmpty()) {
            const curr: NNode = openSet.poll()!;

            // if target is reached
            if (this.isFinished(curr, target)) { 
                const total = this.reconstructPath(curr, visited);

                if (total !== -1) {
                    return total;
                } else {
                    openSet.clear();
                    openSet.add(new NNode(start.x, start.y, null, 0, this.heuristicCost(start, target)));
                    continue;
                }
            }

            const key = this.getKey({x: curr.x, y: curr.y});
            visited.add(key);

            const neighbours = this.getNeighbours(curr, visited);   

            for (var i = 0; i < neighbours.length; i++) {
                const neighbour = neighbours[i];
                const nKey = this.getKey({ x: neighbour.x, y: neighbour.y });
                if (visited.has(nKey)) {
                    continue;
                }

                const nCost = curr.cost + matrix[neighbour.y][neighbour.x];
                const heuristic = this.heuristicCost(neighbour, target);
                const newNode = new NNode(neighbour.x, neighbour.y, curr, nCost, heuristic)

                if (!openSet.contains({ x: neighbour.x, y: neighbour.y }) ||
                    newNode.getCost() < this.getNode(openSet, neighbour.x, neighbour.y)?.getCost()!) {
                    openSet.add(newNode);
                }
            }
        }

        return -1;  
    }

    static isFinished(node: NNode, target: Coordinate) {
        return node.x === target.x && node.y === target.y;
    }

    static heuristicCost(node: Coordinate, target: Coordinate) {
        return Math.abs(target.x - node.x) + Math.abs(target.y - node.y);
    }

    static getNeighbours(node: NNode, visited: Set<string>) {
        const neighbours: Coordinate[] = [];
        const directions = [
            { dx: 1, dy: 0 }, 
            { dx: 0, dy: 1 },
            { dx: -1, dy: 0 },
            { dx: 0, dy: -1},
        ]

        for (const direction of directions) {
            const newX = node.x + direction.dx;
            const newY = node.y + direction.dy;

            if (this.inBound(newX, newY) && !visited.has(this.getKey({x: newX, y: newY}))) {
                neighbours.push({ x: newX, y: newY });
            }
        }

        return neighbours;
    }

    static inBound(x: number, y: number) {
        return x >= 0 && x < this.cols && y >= 0 && y < this.rows;
    }

    static getKey(coordinates: Coordinate) {
        return `${coordinates.x}-${coordinates.y};`
    }

    static getNode(queue: MinHeap, x: number, y: number) {
        return queue.nodes.find(node => node.x === x && node.y === y);
    }
    
    static getLastMove(node: NNode, lastPosition: Coordinate) {
        if (node.x < lastPosition.x) return "L";
        if (node.x > lastPosition.x) return "R";
        if (node.y < lastPosition.y) return "U";
        return "D";
    }

    static reconstructPath(node: NNode | null, visited: Set<string>) {
        var total: number = 0;
        const route = new Array(this.rows - 1).fill(".").map(() => new Array(this.cols).fill("."));
        
        var lastPosition: Coordinate = {x: node?.x!, y: node?.y!};
        var currDirection = "";
        var lastMoveCounter = 0;

        visited.clear();

        const path: Coordinate[] = [];
        while (node !== null) {
            visited.add(this.getKey(node));

            if (this.getLastMove(node, lastPosition) != currDirection) {
                lastMoveCounter = 1;
                currDirection = this.getLastMove(node, lastPosition);
            } else {
                lastMoveCounter += 1;
                if (lastMoveCounter > 3) {
                    return -1;
                }
            }
    
            if (this.matrix[node.x][node.y] !== undefined) {
                total += this.matrix[node.x][node.y];
                route[node.x][node.y] = "#";
                
            }

            lastPosition = { x: node.x, y: node.y };
            node = node.parent;
        }

        // for (const line of route) {
        //     for (const char of line) {
        //         process.stdout.write(char.toString());
        //     }
        //     console.log();
        // }

        return total;
    }
}