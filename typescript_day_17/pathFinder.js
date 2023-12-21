"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.PathFinder = void 0;
var minHeap_1 = require("./minHeap");
var node_1 = require("./node");
var PathFinder = /** @class */ (function () {
    function PathFinder() {
    }
    PathFinder.aStar = function (matrix) {
        var _a;
        this.rows = matrix.length;
        this.cols = matrix[0].length;
        this.matrix = matrix;
        var start = { x: 0, y: 0 };
        var target = { x: this.cols - 1, y: this.rows - 1 };
        var openSet = new minHeap_1.MinHeap();
        var visited = new Set();
        var startNode = new node_1.NNode(start.x, start.y, null, 0, this.heuristicCost(start, target));
        openSet.add(startNode);
        while (!openSet.isEmpty()) {
            var curr = openSet.poll();
            // if target is reached
            if (this.isFinished(curr, target)) {
                var total = this.reconstructPath(curr, visited);
                if (total !== -1) {
                    return total;
                }
                else {
                    openSet.clear();
                    openSet.add(new node_1.NNode(start.x, start.y, null, 0, this.heuristicCost(start, target)));
                    continue;
                }
            }
            var key = this.getKey({ x: curr.x, y: curr.y });
            visited.add(key);
            var neighbours = this.getNeighbours(curr, visited);
            for (var i = 0; i < neighbours.length; i++) {
                var neighbour = neighbours[i];
                var nKey = this.getKey({ x: neighbour.x, y: neighbour.y });
                if (visited.has(nKey)) {
                    continue;
                }
                var nCost = curr.cost + matrix[neighbour.y][neighbour.x];
                var heuristic = this.heuristicCost(neighbour, target);
                var newNode = new node_1.NNode(neighbour.x, neighbour.y, curr, nCost, heuristic);
                if (!openSet.contains({ x: neighbour.x, y: neighbour.y }) ||
                    newNode.getCost() < ((_a = this.getNode(openSet, neighbour.x, neighbour.y)) === null || _a === void 0 ? void 0 : _a.getCost())) {
                    openSet.add(newNode);
                }
            }
        }
        return -1;
    };
    PathFinder.isFinished = function (node, target) {
        return node.x === target.x && node.y === target.y;
    };
    PathFinder.heuristicCost = function (node, target) {
        return Math.abs(target.x - node.x) + Math.abs(target.y - node.y);
    };
    PathFinder.getNeighbours = function (node, visited) {
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
            if (this.inBound(newX, newY) && !visited.has(this.getKey({ x: newX, y: newY }))) {
                neighbours.push({ x: newX, y: newY });
            }
        }
        return neighbours;
    };
    PathFinder.inBound = function (x, y) {
        return x >= 0 && x < this.cols && y >= 0 && y < this.rows;
    };
    PathFinder.getKey = function (coordinates) {
        return "".concat(coordinates.x, "-").concat(coordinates.y, ";");
    };
    PathFinder.getNode = function (queue, x, y) {
        return queue.nodes.find(function (node) { return node.x === x && node.y === y; });
    };
    PathFinder.getLastMove = function (node, lastPosition) {
        if (node.x < lastPosition.x)
            return "L";
        if (node.x > lastPosition.x)
            return "R";
        if (node.y < lastPosition.y)
            return "U";
        return "D";
    };
    PathFinder.reconstructPath = function (node, visited) {
        var _this = this;
        var total = 0;
        var route = new Array(this.rows - 1).fill(".").map(function () { return new Array(_this.cols).fill("."); });
        var lastPosition = { x: node === null || node === void 0 ? void 0 : node.x, y: node === null || node === void 0 ? void 0 : node.y };
        var currDirection = "";
        var lastMoveCounter = 0;
        visited.clear();
        var path = [];
        while (node !== null) {
            visited.add(this.getKey(node));
            if (this.getLastMove(node, lastPosition) != currDirection) {
                lastMoveCounter = 1;
                currDirection = this.getLastMove(node, lastPosition);
            }
            else {
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
    };
    return PathFinder;
}());
exports.PathFinder = PathFinder;
