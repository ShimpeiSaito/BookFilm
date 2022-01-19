stores = %w(生田劇場 神田劇場 千葉劇場)
address = %w(神奈川県川崎市多摩区東三田2-1-1 東京都千代田区神田神保町3-8 千葉県千葉市中央区本千葉町1-2-3)

def random_number_generator(n)
    ''.tap { |s| n.times { s << rand(0..9).to_s } }
end

0.upto(2) do |idx|
    Theater.create(
        store_name: stores[idx],
        address: address[idx],
        tel: random_number_generator(3) + "-" + random_number_generator(3) + "-" + random_number_generator(3)
    )
end