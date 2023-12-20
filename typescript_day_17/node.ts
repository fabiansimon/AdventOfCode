export class NNode {
    x: number;
    y: number;
    parent: NNode | null;
    cost: number;
    heuristic: number;

    constructor(x: number, y: number, parent: NNode | null, cost: number, heuristic: number) {
        this.x = x;
        this.y = y;
        this.parent = parent;
        this.cost = cost;
        this.heuristic = heuristic
    }

    getCost() {
        return this.cost + this.heuristic;
    }
}