"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.PathFinder = void 0;
var minHeap_1 = require("./minHeap");
var node_1 = require("./node");
var PathFinder = /** @class */ (function () {
    function PathFinder() {
    }
    PathFinder.aStar = function (grid) {
        this.rows = grid.length;
        this.cols = grid[0].length;
        var start = { x: 0, y: 0 };
        var target = { x: this.cols - 1, y: this.rows - 1 };
        var openSet = new minHeap_1.MinHeap();
        var visited = new Set();
        var startNode = new node_1.NNode(start.x, start.y, null, 0, this.heuristicCost(start, target));
        openSet.add(startNode);
        while (!openSet.isEmpty()) {
            var curr = openSet.poll();
            if (this.isFinished(curr, target)) {
            }
        }
        return 10;
    };
    PathFinder.isFinished = function (node, target) {
        return node.x === target.x && node.y === target.y;
    };
    PathFinder.heuristicCost = function (node, target) {
        return Math.abs(target.x - node.x) + Math.abs(target.y - node.y);
    };
    PathFinder.getNeighbours = function (node, closedSet) {
        var neighbours = [];
        var directions = [
            { dx: 1, dy: 0 },
            { dx: 0, dy: 1 },
            { dx: -1, dy: 0 },
            { dx: 0, dy: -1 },
        ];
        for (var _i = 0, directions_1 = directions; _i < directions_1.length; _i++) {
            var direction = directions_1[_i];
            var newX = node.x + direction.dx;
            var newY = node.y + direction.dy;
            if (this.inBound(newX, newY) && !closedSet.has(this.getKey(newX, newY))) {
                neighbours.push({ x: newX, y: newY });
            }
        }
        return neighbours;
    };
    PathFinder.inBound = function (x, y) {
        return x >= 0 && x < this.cols && y >= 0 && y < this.rows;
    };
    PathFinder.getKey = function (x, y) {
        return "".concat(x, "-").concat(y, ";");
    };
    PathFinder.getNode = function (queue, x, y) {
        return queue.nodes.find(function (node) { return node.x === x && node.y === y; });
    };
    PathFinder.reconstructPath = function (node) {
        var path = [];
        while (node !== null) {
            path.unshift({ x: node.x, y: node.y });
            node = node.parent;
        }
        return path;
    };
    return PathFinder;
}());
exports.PathFinder = PathFinder;
