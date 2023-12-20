"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.MinHeap = void 0;
var MinHeap = /** @class */ (function () {
    function MinHeap() {
        this.nodes = [];
    }
    MinHeap.prototype.add = function (node) {
        this.nodes.push(node);
        this.nodes.sort(function (a, b) { return a.getCost() - b.getCost(); });
    };
    MinHeap.prototype.poll = function () {
        return this.nodes.shift();
    };
    MinHeap.prototype.isEmpty = function () {
        return this.nodes.length === 0;
    };
    return MinHeap;
}());
exports.MinHeap = MinHeap;
