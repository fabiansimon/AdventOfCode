require 'set'
file_path = "./dayFour_input.txt"

=begin
PART I

File.open(file_path, 'r') do |file|
    points = 0

    file.each_line do |line|
        sides = line.split(":")[1].split("|")
        curr_points = 0
        
        winning = Set.new
        sides[0].split.each do |number|
            winning.add(number)
        end

        sides[1].split.each do |number|
            if winning.include?(number)
                curr_points = (curr_points == 0) ? 1 : curr_points * 2
            end
        end

        points += curr_points
    end 

    puts points
end
=end

# PART II

def get_raw_data(path)
    data = []
    File.open(path, 'r') do |file|
        
        file.each_line do |line|
            sides = line.split(":")[1].split("|")
            curr = [sides[0].split, sides[1].split]
            data.push(curr)
        end

    end

    return data
end

def get_matches(data)
    matches = []

    data.each do |d| 
        winning = Set.new(d[0])    
        curr = 0

        d[1].each do |nr| 
            if winning.include?(nr)
                curr += 1
            end
        end

        matches.push(curr)
    end

    return matches

end

def get_total_scratchcards(matches)
    length = matches.size
    stratchcards = Array.new(length, 1)

    (0..length-1).each do |i|
        loops = matches[i]

        loops.times do |j|
            stratchcards[j+i+1] += 1*stratchcards[i]
        end

    end

    return stratchcards.reduce(:+)
end


data = get_raw_data(file_path)

matches = get_matches(data)

res = get_total_scratchcards(matches)

p res
