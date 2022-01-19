times = %w(9:00 11:00 13:00 15:00 17:00 19:00 21:00)

1.upto(3) do |thea_idx|
    theater = Theater.find(thea_idx)
    movies = Movie.all.sample(rand(13..20))
    for movie in movies do
        0.upto(6) do |day|
            date = Date.today + day
            1.upto(3) do
                time = Time.zone.parse(times.sample)
                etime = time + (movie.screening_time * 60)
                Schedule.create(
                    thea: theater,
                    mov: movie,
                    screen_no: rand(1..8),
                    screening_date: date,
                    starttime: time,
                    endtime: etime
                )
            end
        end
    end
end
