import scala.io.Source
import scala.collection.mutable.{HashMap, Queue}

object Main extends App {
  var filePath = "./day10_input.txt"

  val lines = getLines(filePath)
  val start = findStart(lines)
  
  var max = findMax(lines, start)

  println(max)
}

def findMax(lines: List[String], start: Array[Int]): Int = {
    // x - y
  val pipes = HashMap(
    'F' -> Array('R', 'B'),
    'J' -> Array('L', 'T'),
    'L' -> Array('T', 'R'),
    '7' -> Array('L', 'B'),
    '|' -> Array('T', 'B'),
    '-' -> Array('L', 'R'),
  )
                 
  val width = lines(0).length
  val height = lines.length

  val lineArr = lines.map(_.toCharArray).toArray

  var moves = -1
  val directions = Array((0, -1, 'B'),(1, 0, 'L'),(0, 1, 'T'),(-1, 0, 'R'))

  var queue = Queue.empty[Array[Int]]
  queue.enqueue(start)

  var size = 0
  var curr = Array[Int](2)

  while (!queue.isEmpty) {
    moves += 1
    size = queue.size

    for (_ <- 0 until size) {
      curr = queue.dequeue()

      for (direction <- directions) {
        var dir = direction(2)
        var newX = curr(0) + direction(0)
        var newY = curr(1) + direction(1)

        if (newX >= 0 && newX < width &&
            newY >= 0 && newY < height &&
            pipes.contains(lineArr(newY)(newX))
            ) {
              var pipe = pipes(lineArr(newY)(newX))
              if (dir == pipe(0) || dir == pipe(1)) {
                queue.enqueue(Array(newX, newY))
              }
            }
        }

      lineArr(curr(1))(curr(0)) = '.'
    }
  }

  return moves
}

def findStart(lines: List[String]): Array[Int] = {
  var start = new Array[Int](2)
  for (i <- 0 until lines.length) {
    for (j <- 0 until lines(0).length) {
      if (lines(i)(j) == 'S') {
        start(0) = j;
        start(1) = i;
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


