open System.IO

let readTextFile (path: string) =
    try
        use sr = new StreamReader(path)
        sr.ReadToEnd()
    with
    | :? System.IO.FileNotFoundException as ex ->
        printfn "File not found: %s" ex.Message
        ""

let hashSequence (data: string[]): int =
    let mutable value = 0
    let mutable total = 0
    let multiplier = 17
    let max = 256
    for sequence in data do
        value <- 0
        for c in sequence do
            if (int c) <> 10 then
                value <- value + (int c)
                value <- value * multiplier
                value <- value % max
                
        total <- total + value
    total

let content = readTextFile "../../../../day15_input.txt"
let data = content.Split([|','|])

let value = hashSequence data

printfn "%d" value
// printfn "%d" value
