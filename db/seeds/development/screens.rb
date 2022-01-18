theaters = Theater.all

for theater in theaters do
    1.upto(8) do |scn|
        Screen.create(
            screen_no: scn,
            thea: theater,
            seat_group: rand(1..5)
        )
    end
end
