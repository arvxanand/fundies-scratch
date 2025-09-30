use context dcic2024
include csv
include data-source

#Problem 1: Here we are checking to see if a certain year is a leap year or not. To check if leap year or not we are using the modulo function where if the number is divisible by 4 and == 0 AND if its divsible by 100 its not a leap year. 
fun leap-year(y :: Number) -> Boolean:
  (num-modulo(y, 4) == 0)
where:
  leap-year(2020) is true
  leap-year(2000) is true
  leap-year(2021) is false
  leap-year(2022) is false
  leap-year(2054) is false
end


#Problem 2: 
fun tick(s :: Number) -> Number:
  if (s >= 0) and (s < 59) and (num-is-integer(s) == true):
    s + 1
  else if s == 59:  
    0
  else:
    raise("Invalid")
  end
where:
  tick(0) is 1 
  tick(58) is 59
  tick(59) is 0
  tick(-1) raises "Invalid"
  tick(60) raises "Invalid"
end


#Problem 3: 
fun rock-paper-scissors(a :: String, b :: String) -> String:
  if ((a == "rock") or (a == "paper") or (a == "scissors")) and (((b == "rock")) or ((b == "paper") or (b == "scissors"))):
    if a == b: "tie"
    else if ((a == "rock") and (b == "scissors")) or ((a == "scissors") and (b == "paper")) or ((a == "paper") and (b == "rock")):
      "player 1"
    else:
      "player 2"
    end
   else:
    "Invalid"
  end
where:
  rock-paper-scissors("rock", "scissors") is "player 1"
  rock-paper-scissors("scissors", "paper") is "player 1"
  rock-paper-scissors("paper", "rock") is "player 1"
  rock-paper-scissors("scissors", "rock") is "player 2"
  rock-paper-scissors("paper", "scissors") is "player 2"
  rock-paper-scissors("rock", "paper") is "player 2"
  rock-paper-scissors("rock", "rock") is "tie"
  rock-paper-scissors("paper", "paper") is "tie"
  rock-paper-scissors("scissors", "scissors") is "tie"
  rock-paper-scissors("water", "rock") is "Invalid"
  rock-paper-scissors("rock", "lizard") is "Invalid"
end


#Problem 4:
planets =
  table: Planet :: String, Distance :: Number
    row: "Mercury", 0.39
    row: "Venus", 0.72
    row: "Earth", 1
    row: "Mars", 1.52
    row: "Jupiter", 5.2
    row: "Saturn", 9.54
    row: "Uranus", 19.2
    row: "Neptune", 30.06
  end

mars = planets.row-n(3)
mars-distance = mars["Distance"]

check:
  mars-distance is 1.52
end


#Problem 5:
something = load-table:
  date :: String,
  rate :: Number
  source: csv-table-file("boe_rates.csv", default-options)
  sanitize rate using num-sanitizer
  sanitize date using string-sanitizer
end


num_rows = something.length()
median_rate = median(something, "rate")

mode_rate = modes(something, "rate")

ordered_asc = order something: rate ascending end
ordered_desc = order something: rate descending end

min_rate = ordered_asc.row-n(0)["rate"]
max_rate = ordered_desc.row-n(0)["rate"]

check:
  num_rows > 0
  median_rate is median(something, "rate")
  min_rate <= max_rate
end