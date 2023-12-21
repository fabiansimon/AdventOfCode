import { NNode } from "./node";
import { Coordinate } from "./pathFinder";

export class MinHeap {
    nodes: NNode[]
    constructor() {
        this.nodes = [];
    }

    add(node: NNode) {
        this.nodes.push(node);
        this.nodes.sort((a, b) => a.getCost() - b.getCost());
    }

    poll() {
        return this.nodes.shift();
    }

    isEmpty() {
        return this.nodes.length === 0;
    }

    contains(coordinates: Coordinate) {
        return this.nodes.some(node => node.x === coordinates.x && node.y === coordinates.y);
    }

    clear() {
        this.nodes = [];
    }
}