times = %w(9:00 11:00 13:00 15:00 17:00 19:00 21:00)

1.upto(3) do |thea_idx|
    theater = Theater.find(thea_idx)
    movies = Movie.all.sample(rand(8..20))
    for movie in movies do
        0.upto(7) do |scr|
            time = Time.parse(times.sample)
            Schedule.create(
                thea: theater,
                mov: movie,
                screen_no: scr,
                screening_date: Date.parse('2022-2-1') + rand(0..27),
                starttime: time,
                endtime: time + movie.screening_time * 60
            )
        end
    end
end
