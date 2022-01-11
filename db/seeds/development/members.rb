names = %w(Taro Jiro Hana John Mike Sophy Bill Alex Mary Tom)
fnames = ["佐藤", "鈴木", "高橋", "田中"]
gnames = ["太郎", "次郎", "花子"]

def random_number_generator(n)
    ''.tap { |s| n.times { s << rand(0..9).to_s } }
end

0.upto(9) do |idx|
    Member.create(
        login_id: names[idx],
        name: "#{fnames[idx % 4]} #{gnames[idx % 3]}",
        birthday: "#{rand(1980..2000)}-12-01",
        tel: random_number_generator(3) + "-" + random_number_generator(4) + "-" + random_number_generator(4),
        email: "#{names[idx]}@example.com",
        payment: random_number_generator(4) + " " + random_number_generator(4) + " " + random_number_generator(4) + " " + random_number_generator(4)
    )
end
