open System.IO
open System.Collections.Generic

let multiplier = 17
let size = 256

let readTextFile (path: string) =
    try
        use sr = new StreamReader(path)
        sr.ReadToEnd()
    with
    | :? System.IO.FileNotFoundException as ex ->
        printfn "File not found: %s" ex.Message
        ""

let getHash (str: string): int =
    let mutable hash = 0

    for c in str do
        if (int c) <> 10 then
            hash <- hash + (int c)
            hash <- hash * multiplier
            hash <- hash % size

    hash

let hashSequence (data: string[]): int =
    let mutable total = 0
    for sequence in data do
        total <- total + getHash sequence

    total

let rawHash (str: string): string =
    if str.Contains("=") then
        str.Split('=').[0]
    else
        str.Split('-').[0]

let checkKey (lense: string, key: string): bool =
    let mutable index = 0
    let length = min (String.length lense) (String.length key)

    while index < length && lense.[index] = key.[index] do
        index <- index + 1

    index = length



// ==== Functionality ==== 
    
let content = readTextFile "../../../../day15_input.txt"
let data = content.Split([|','|])

let test = "ot"
let value = getHash test

let boxes : List<string>[] = Array.init size (fun _ -> List<string>())
let values = new Dictionary<string, int>()

for d in data do
    let rawHash = rawHash d
    let index = getHash rawHash

    let mutable i = 0

    if d.Contains("-") then // Delete

        let key = d.Split("-").[0]

        while i < boxes.[index].Count do
            let lense = boxes.[index].[i]

            if lense = key then
                boxes.[index].RemoveAt(i)
                values.Remove(key)
                i <- boxes.[index].Count + 10
            else
                i <- i + 1

    else

        let key = d.Split("=").[0]
        let value = d.Split("=").[1]

        while i < boxes.[index].Count do
            let lense = boxes.[index].[i]

            if lense = key then
                values.[lense] <- (int value)
                i <- boxes.[index].Count + 10
            else
                i <- i + 1

        if i <> boxes.[index].Count + 10 then
            boxes.[index].Add(key)
            values.Add(key, (int value))

let mutable power = 0

for i = 0 to size - 1 do
    for j = 0 to boxes.[i].Count - 1 do
        let lense = boxes.[i].[j]
        let focal = values.[lense]

        power <- power + ((i+1) * (j+1) * focal)


printfn "%d" power