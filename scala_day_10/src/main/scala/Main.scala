import scala.io.Source
import scala.collection.mutable.{HashMap, Queue}

object Main extends App {
  var filePath = "./day10_input.txt"

  // x - y
  val directions = new HashMap[Char, Array[Int]]
  directions += ( 'F' -> Array(1, 1), 
                  'J' -> Array(-1, -1),  
                  'L' -> Array(1, -1), 
                  '7' -> Array(-1, 1),
                  )

  val lines = getLines(filePath)
  val start = findStart(lines)
  
  var max = findMax(lines, start)
  println(max)
}

/*
..F7.
.FJ|.
SJ.L7
|F--J
LJ...

7-F7-
.FJ|7
SJLL7
|F--J
LJ.LJ

*/ 

def findMax(lines: List[String], start: Array[Int]): Int = {
  var moves = 0

  var queue = Queue.empty[Array[Int]]
  queue.enqueue(start)

  while (!queue.isEmpty) {
    moves += 1
    queue.dequeue()
    
  }

  return moves
}

def findStart(lines: List[String]): Array[Int] = {
  var start = new Array[Int](2)
  for (i <- 0 until lines.length) {
    for (j <- 0 until lines(0).length) {
      if (lines(i)(j) == 'S') {
        start(0) = i;
        start(1) = j;
      }
    }
  }

  return start
}

def getLines(path: String): List[String] = {
  var src = Source.fromFile(path)
  var lines = src.getLines().toList
  src.close()
  return lines
}


