import java.io.BufferedReader
import java.io.FileReader
import java.lang.Exception

fun main(args: Array<String>) {
    val path: String = "./day13_input.txt";
    var lines: List<List<List<String>>> = getInputData(path);

    println(lines);
}

fun getInputData(path: String): List<List<List<String>>> {
    var res: MutableList<List<List<String>>> = mutableListOf()

    try {
        BufferedReader(FileReader(path)).use { reader ->
            var line: String?
            while (reader.readLine().also { line = it } != null) {
                val tokens = line?.split(" ") ?: emptyList()
                val tokenList = tokens.map { listOf(it) }
                res.add(tokenList)
            }
        }
    } catch (e: Exception) {
        println(e.message)
    }

    return res
}