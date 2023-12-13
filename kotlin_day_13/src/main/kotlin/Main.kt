import java.io.BufferedReader
import java.io.FileReader
import java.lang.Exception

fun main(args: Array<String>) {
    val path = "./day13_input.txt";
    var lines: List<List<String>> = getInputData(path);

    println(findMirrorIndex(lines[0]))
}

fun findMirrorIndex(lines: List<String>): Int {
    var firstLine = lines[0]
    var length = firstLine.length

    for (i in firstLine.indices) {
        if (i == length-1) break

        if (isSymmetric(firstLine.substring(i, length))) {

            var correct = true
            for (line in lines.drop(1)) {
                if (!isSymmetric(line.substring(i, length))) {
                    correct = false
                    break
                }
            }

            if (correct) return ((length-i)/2)+1
        }
    }

    for (i in firstLine.indices.reversed()) {
        if (i == 1) break

        if (isSymmetric(firstLine.substring(0, i+1))) {
            var correct = true
            for (line in lines.drop(1)) {
                if (!isSymmetric(line.substring(0, i+1))) {
                    correct = false
                    break
                }
            }

            if (correct) return (i+1)/2
        }
    }

    return -1
}
fun isSymmetric(str: String): Boolean {
    var left = 0
    var right = str.length-1

    while (left < right) {
        if (str[left++] != str[right--]) return false
    }

    return true;
}

fun getInputData(path: String): List<List<String>> {
    var sections: MutableList<List<String>> = mutableListOf()

    try {
        BufferedReader(FileReader(path)).use { reader ->
            var curr: MutableList<String> = mutableListOf()
            var line: String?
            while (reader.readLine().also { line = it } != null) {
                if (line?.isBlank() == true) {
                    sections.add(curr.toList())
                    curr.clear()
                    continue;
                }
                curr.add(line ?: "")
            }
            sections.add(curr.toList())
        }
    } catch (e: Exception) {
        println(e.message)
    }

    return sections
}