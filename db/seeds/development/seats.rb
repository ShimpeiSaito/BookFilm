1.upto(5) do |gp|
    1.upto(rand(15..20)) do |idx|
        if idx <= 3 then
            start = 3
            last = 22
        else
            start = rand(1..2)
            last = rand(23..25)
        end
        Seat.create(
            seat_group: gp,
            row: idx,
            start_line: start,
            last_line: last,
            num: last - start + 1
        )
    end
end

