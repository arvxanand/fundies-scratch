use context starter2024

fun choose-hat(temp-in-C :: Number) -> String:
  doc: "determines appropriate head gear, with above 27C a sun hat, below nothing, below 10C a winter hat"
  ask:
    | temp-in-C < 10 then: "winter hat"
    | temp-in-C >= 27 then: "sun hat"
    | otherwise: "no hat"
  end
where:
  choose-hat(5) is "winter hat"
  choose-hat(25) is "no hat"
  choose-hat(27) is "sun hat"
  choose-hat(32) is "sun hat"
end

fun add-glasses(outfit :: String) -> String:
  doc: "adds glasses to given outfit description"
  outfit + ", and glasses"
where:
  add-glasses("sun hat") is "sun hat, and glasses"
  add-glasses("no hat") is "no hat, and glasses"
end

fun choose-outfit(temp-in-C :: Number) -> String:
  doc: "makes the whole outfit based on temperature and always adds glasses"
  add-glasses(choose-hat(temp-in-C))
where:
  choose-outfit(5) is "winter hat, and glasses"
  choose-outfit(25) is "no hat, and glasses"
  choose-outfit(27) is "sun hat, and glasses"
end

fun choose-hat-or-visor(temp-in-C :: Number, has-visor :: Boolean) -> String:
  doc: "wears a visor if the person has one and temp > 30, otherwises just does choose-hat"
  if has-visor and (temp-in-C > 30):
    "visor"
  else:
    choose-hat(temp-in-C)
  end
where:
  choose-hat-or-visor(32, true) is "visor"
  choose-hat-or-visor(32, false) is "sun hat"
  choose-hat-or-visor(25, true) is "no hat"
  choose-hat-or-visor(5, false) is "winter hat"
end
    