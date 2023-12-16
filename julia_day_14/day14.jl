

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
    border = length(lines[1])
    index = border
    total = 0
    for line in lines
        index = border
        for (i, c) in enumerate(line)
            if (c == 'O')
                total += index
                index -= 1
            end

            if (c == '#') 
                index = border-i
            end
        end
    end

    return total
end


path = "./day14_input.txt"
lines = get_lines(path)
total_weight = get_total_weight(lines)

println(total_weight)

