# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "seedの実行を開始"

nao = Customer.find_or_create_by!(email: "11@1") do |customer|
  customer.name = "nao"
  customer.password = "kumakuma"
  customer.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test1.jpg"), filename:"test1.jpg")
end

buds = Customer.find_or_create_by!(email: "12@1") do |customer|
  customer.name = "buds"
  customer.password = "kumakuma"
  customer.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test2.jpg"), filename:"test2.jpg")
end

coco = Customer.find_or_create_by!(email: "13@1") do |customer|
  customer.name = "coco"
  customer.password = "kumakuma"
  customer.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test3.jpg"), filename:"test3.jpg")
end

tomo = Customer.find_or_create_by!(email: "14@1") do |customer|
  customer.name = "tomo"
  customer.password = "kumakuma"
  customer.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test4.jpg"), filename:"test4.jpg")
end

hiro = Customer.find_or_create_by!(email: "15@1") do |customer|
  customer.name = "hiro"
  customer.password = "kumakuma"
  customer.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test5.jpg"), filename:"test5.jpg")
end

Post.find_or_create_by!(title: "ねるね") do |post|
  post.content = <<TEXT
<strong>子供に大人気のあのお菓子</strong><br>
<br>
体に悪そうで私は、買ってもらえませんでしたが<br>
なんと<strong>天然由来の既存添加物であり、指定添加物（合成添加物）は使われていない</strong><br>
んだそうです<br>
皆さんも食べてみてくださいね
TEXT
  post.customer = nao
  post.star = 4.5
end

Post.find_or_create_by!(title: "おすしやさん") do |post|
  post.content = <<TEXT
<strong>子供と一緒に作成！！</strong><br>
買い物ついでに買ってみましたが、なかなかすごいです<br>
時間かかりましたが、<strong>クオリティーがすごいです</strong><br>
実際の作成分がこちらになります<br>
<br>
思ってたよりおもしろかったが、時間が掛かりました。<br>
いくら作るのが思いのほか楽しかった為、競うように作りました<br>
<br>
小さなお子さんは不向きかも<br>
TEXT
  post.customer = tomo
  post.star = 5.0
end

Post.find_or_create_by!(title: "ねるねる") do |post|
  post.content = <<TEXT
子供に<strong>大人気</strong>なあの商品<br>
何と大人用も販売しています<br>
名前は「ねるねる大人のねるねるねるね」<br>
味は、「摘みたていちご味」<br>
<br>
コンテナサイズもあるみたいなのでぜひ
TEXT
  post.customer = buds
  post.star = 3.5
end

Post.find_or_create_by!(title: "パンヤさん") do |post|
  post.content = <<TEXT
出ましたあの商品<br>
<br>
今回は<strong>コネコネタイプ</strong>です<br>
少し力がいるので、ぜひ親子で一緒に作ってみてくださいね<br>
<br>
すごくおもしろいですよ<br>
付属のトッピングだけでなく自宅にあるものも使えます<br>
<br>
レンジも使うので一緒に作るのがおすすめです<br>
TEXT
  post.customer = hiro
  post.star = 2.5
end

puts "seedの実行が完了しました"

