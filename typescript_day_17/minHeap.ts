import { NNode } from "./node";

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
}