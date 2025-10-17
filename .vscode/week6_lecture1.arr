use context starter2024

data Status:
  | todo
  | in-progress
  | done
end


data Priority:
  | low
  | medium
  | high
end

data Task:
  | task(description :: String, priority :: Priority, status :: Status)
  | note(description :: String)
end

fun describe(t :: Task) -> String:
  cases (Task) t:
    | task(d, p, s) =>
      priority-text = cases (Priority) p:
        | low => "❕"
        | medium => "❗️"
        | high => "‼️"
      end
      status-text = cases (Status) s:
        | todo => "[TODO]"
        | in-progress => "[IN PROGRESS]"
        | done => "[DONE]"
      end
      priority-text + "TASK: " + d + " " + status-text
    | note(d) => "📝 " + d
  end
end

data Temperature:
  | celsius(degrees :: Number)
  | fahrenheit(degrees :: Number)
  | kelvin(degrees :: Number)
end

fun to-celsius(temp :: Temperature) -> Number:
  cases (Temperature) temp:
    | celsius(d) => d
    | fahrenheit(d) => (d - 32) * (5/9)
    | kelvin(d) => d - 273.15
  end
end

data WeatherReport:
  | sunny(temperature :: Temperature)
  | rainy(temperature :: Temperature, precipitation :: Number)
  | snowy(temperature :: Temperature, precipitation :: Number, wind-speed :: Number)
end

fun is-severe(report :: WeatherReport) -> Boolean:
  cases (WeatherReport) report:
    | sunny(temp) => temp-celsius = to-celsius(temp)
      temp-celsius > 35
    | rainy(temp, precip) => precip > 20
    | snowy(temp, precip, wind) => wind > 30
  end
end

task-1 = task("Buy groceries", low, todo)
task-2 = task("Pay council tax", high, in-progress)
task-3 = task("Finish assignment", medium, done)
note-1 = note("Post Office closes at 4:30")

temp-c = celsius(25)
temp-f = fahrenheit(77)
temp-k = kelvin(298.15)


sunny-hot = sunny(celsius(40))
sunny-mild = sunny(celsius(25))
rainy-heavy = rainy(celsius(20), 25)
rainy-light = rainy(fahrenheit(70), 15)
snowy-windy = snowy(celsius(-5), 10, 35)
snowy-calm = snowy(kelvin(270), 5, 20)


check:
   describe(task-1) is "❕TASK: Buy groceries [TODO]"
   describe(task-2) is "‼️TASK: Pay council tax [IN PROGRESS]"
   describe(task-3) is "❗️TASK: Finish assignment [DONE]"
   describe(note-1) is "📝 Post Office closes at 4:30"
   
   to-celsius(temp-c) is 25
   to-celsius(temp-f) is 25
   to-celsius(temp-k) is 25
   
   is-severe(sunny-hot) is true
   is-severe(sunny-mild) is false
   is-severe(rainy-heavy) is true
   is-severe(rainy-light) is false
   is-severe(snowy-windy) is true
   is-severe(snowy-calm) is false
end
