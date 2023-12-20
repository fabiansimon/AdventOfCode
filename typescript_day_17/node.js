"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.NNode = void 0;
var NNode = /** @class */ (function () {
    function NNode(x, y, parent, cost, heuristic) {
        this.x = x;
        this.y = y;
        this.parent = parent;
        this.cost = cost;
        this.heuristic = heuristic;
    }
    NNode.prototype.getCost = function () {
        return this.cost + this.heuristic;
    };
    return NNode;
}());
exports.NNode = NNode;
