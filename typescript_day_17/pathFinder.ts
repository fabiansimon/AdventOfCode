import { MinHeap } from "./minHeap";
import { NNode } from "./node";

interface Coordinate {
    x: number
    y: number
}

export class PathFinder {
    static rows: number;
    static cols: number; 

    constructor() {}
    
    static aStar(matrix: number[][]) {
        this.rows = matrix.length;
        this.cols = matrix[0].length;

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
                return this.reconstructPath(curr);
            }

            const key = this.getKey({x: curr.x, y: curr.y});
            visited.add(key);

            const neighbours = this.getNeighbours(curr, visited);   
            
            for (const neighbour of neighbours) {
                const nKey = this.getKey({ x: neighbour.x, y: neighbour.y });
                if (visited.has(nKey)) continue;

                const nCost = curr.cost + matrix[neighbour.y][neighbour.x];
                const heuristic = this.heuristicCost()
            }
        }

        return 10;  
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

    static reconstructPath(node: NNode | null) {
        const path: Coordinate[] = [];
        while (node !== null) {
            path.unshift({ x: node.x, y: node.y });
            node = node.parent;
        }
        return path;
    }
}