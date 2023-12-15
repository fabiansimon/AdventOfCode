

function get_lines(path)
    lines = []
    open(path) do file
        for line in eachline(file)
            for (index, c) in enumerate(collect(line))
                while length(lines) < index
                    push!(lines, [])
                end
                push!(lines[index], c)
            end
        end
    end
    return lines
end

function get_total_weight(lines)
    index = length(lines[1])
    curr = 0
    for line in lines
        index = length(line)
        for (i, c) in enumerate(line)
            if c == '#' 
                index = i-1
            end

            if c == 'O'
                curr += index + 1
                index -= 1
            end
        end
    end

    return curr
end

path = "./day14_input.txt"
lines = get_lines(path)
total_weight = get_total_weight(lines)



print(total_weight)


