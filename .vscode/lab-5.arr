use context dcic2024

include csv
include data-source
#Task 1

#Task 2

flights-53 = load-table: 
  rownames :: Number, 
  dep-time :: Number, 
  sched-dep-time :: Number, 
  dep-delay :: Number, 
  arr-time :: Number, 
  sched-arr-time :: Number, 
  arr-delay :: Number, 
  carrier :: String, 
  flight :: Number, 
  tailnum :: String, 
  origin :: String, 
  dest :: String, 
  air-time :: Number, 
  distance :: Number, 
  hour :: Number, 
  minute :: Number, 
  time-hour :: String
  source: csv-table-file("flights_sample53.csv", default-options)
  sanitize rownames using string-sanitizer
  sanitize dep-time using strict-num-sanitizer  
  sanitize sched-dep-time using strict-num-sanitizer
  sanitize dep-delay using strict-num-sanitizer
  sanitize arr-time using strict-num-sanitizer
  sanitize sched-arr-time using strict-num-sanitizer
  sanitize arr-delay using strict-num-sanitizer
  sanitize carrier using string-sanitizer
  sanitize flight using strict-num-sanitizer
  sanitize tailnum using string-sanitizer
  sanitize origin using string-sanitizer
  sanitize dest using string-sanitizer
  sanitize air-time using strict-num-sanitizer
  sanitize distance using strict-num-sanitizer  
  sanitize hour using strict-num-sanitizer
  sanitize minute using strict-num-sanitizer
  sanitize time-hour using string-sanitizer
end

fun trim(s :: String) -> String:
  doc: "Remove spaces from the string"
  string-replace(string-replace(s, " ", ""), " ", "")
end

fun fix-tailnum(tn :: String) -> String:
  doc: "Replace empty tailnum with 'UNKNOWN'."
  if tn == "":
    "UNKNOWN"
  else:
    tn
  end
end

flights-53-tail = transform-column(flights-53, "tailnum", fix-tailnum)

fun dep-time-to-hhmm(dt :: Number) -> String:
  doc: "Convert departure time (e.g., 517) to '05:17' format."
  hours = num-floor(dt / 100)
  minutes = dt - (hours * 100)
  h-str = if hours < 10: "0" + tostring(hours) else: tostring(hours) end
  m-str = if minutes < 10: "0" + tostring(minutes) else: tostring(minutes) end
  h-str + ":" + m-str
end

fun fix-delay(d :: Number) -> Number:
  doc: "Replace negative delay values with 0."
  if d < 0:
    0
  else:
    d
  end
end

flights-53-delay1 = transform-column(flights-53-tail, "dep-delay", fix-delay)
flights-53-delay2 = transform-column(flights-53-delay1, "arr-delay", fix-delay)

fun make-dedup-key(row) -> String:
  doc: "Create dedup_key as 'flight-CARRIER-HH:MM' combining flight, normalized carrier, and formatted dep_time."
  
  flight-str = tostring(row["flight"])
  
  carrier-raw = row["carrier"]
  carrier-trimmed = trim(carrier-raw)
  carrier-upper = string-to-upper(carrier-trimmed)

  dep-time-formatted = dep-time-to-hhmm(row["dep-time"])

  flight-str + "-" + carrier-upper + "-" + dep-time-formatted
end

flights-53-with-dedup = build-column(flights-53-delay2, "dedup-key", make-dedup-key)