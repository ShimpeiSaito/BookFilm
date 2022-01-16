titles = %w(映画1 映画2 映画3 映画4 映画5 映画6 映画7 映画8 映画9 映画10 映画11 映画12 映画13 映画14 映画15 映画16 映画17 映画18 映画19 映画20)

0.upto(19) do |idx|
    Movie.create(
        title: titles[idx],
        explanation: "面白い映画です。",
        released_at: 10.days.ago.advance(days: idx),
        expired_at: 10.days.before.advance(days: idx),
        screening_time: idx * 10,
        distribution: "東宝",
        director: "宮崎駿"
    )
end