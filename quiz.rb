require "json"

puts "hva heter du?"
user_input = gets.chomp
username = user_input.downcase

unless File.file?("#{username}.json") #leter etter hvis fil finnes
  hash_variable = {"riktig" => "0", "antall" => "0"}
  File.open("#{username}.json", "w") do |file|
    file.write(hash_variable.to_json)
  end
end

file = File.read("#{username}.json")
data_hash = JSON.parse(file)
puts "vil du spille?"
points = data_hash["riktig"].to_i
questions = data_hash["antall"].to_i

while gets.chomp.downcase == "ja".downcase do
  user_input = gets.chomp
  puts "\e[2J"
  list = ["+", "-", "*", "/" ]
listrand = list[rand(4)]
number1 = rand(100)
number2 = rand(100)
answer =  if listrand == "+"
    number1+number2
  elsif listrand == "-"
    number1-number2
  elsif listrand == "*"
    number1*number2
  elsif listrand == "/"
    number1/number2
  end
puts "#{number1} #{listrand} #{number2}"
user_input = gets.chomp
  if user_input.to_i == answer
  puts "Riktig"
  points = points + 1
  questions = questions + 1
  puts "svaret var #{answer}"
  else
  puts "Feil"
  points = points + 0
  questions = questions + 1
  puts "svaret var #{answer}"
  end
puts "du har #{points}/#{questions} riktige"
puts "fortsette?"
end

puts "du fikk #{points}/#{questions} riktige"
File.open("#{username}.json", "w") do |file|
  hash_variable = {"riktig" => "#{points}", "antall" => "#{questions}"}
  file.write(hash_variable.to_json)
end