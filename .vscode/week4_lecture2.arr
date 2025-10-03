use context dcic2024

include csv
include data-source

items = table: item :: String, x-coordinate :: Number, y-coordinate :: Number
  row: "Sword of Dawn",           23,  -87
  row: "Healing Potion",         -45,   12
  row: "Dragon Shield",           78,  -56
  row: "Magic Staff",             -9,   64
  row: "Elixir of Strength",      51,  -33
  row: "Cloak of Invisibility",  -66,    5
  row: "Ring of Fire",            38,  -92
  row: "Boots of Swiftness",     -17,   49
  row: "Amulet of Protection",    82,  -74
  row: "Orb of Wisdom",          -29,  -21
end

fun subtract-1(n :: Number) -> Number:
  doc: "subtracts 1 from input"
  n - 1
where:
  subtract-1(10) is 9
  subtract-1(0) is -1
  subtract-1(-3.5) is -4.5
end

moved-items = transform-column(items, "x-coordinate", subtract-1)

transform-column(items, "x-coordinate", lam(n): n - 1 end)

fun calc-distance(r :: Row) -> Number:
  doc: "does distance to origin from fields 'x-coordinate' and 'y-coordinate'"
  num-exact(num-sqrt(
      num-sqr(r["x-coordinate"]) + num-sqr(r["y-coordinate"])))
where:
  calc-distance(items.row-n(0)) is-roughly
    num-sqrt(num-sqr(23) + num-sqr(-87))
      
  calc-distance(items.row-n(3)) is-roughly
    num-sqrt(num-sqr(-9) + num-sqr(64))
end

items-with-dist = build-column(items, "distance", calc-distance)

fun apply-discounts(t :: Table) -> Table:
  doc: "transforms 'price' column by reducing 20%, if value is below 100"
  transform-column(t, "price", lam(price :: Number): 
    if price < 100: price * 0.8 else: price end
  end)
where:
  test-table =
    table: price
      row: 50
      row: 120
      row: 80
      row: 40
    end
  apply-discounts(test-table) is
  table: price
    row: 50 * 0.8
    row: 120
    row: 80 * 0.8
    row: 40 * 0.8
  end
end

newxItems = transform-column(items, "x-coordinate", lam(n): n * 0.9 end)
newItems = transform-column(newxItems, "y-coordinate", lam(n): n * 0.9 end)
itemDistance = build-column(newItems, "distance", calc-distance)

itemDistance

orderedDistance = order-by(itemDistance, "distance", true)

orderedDistance.row-n(0)["item"]




transform-column(items, "item", lam(x): string-repeat("X",string-length(x) )end)


fun obfuscateItem(t :: Table, r :: String) -> Table:
  doc:""

  transform-column(t, r, lam(x): string-repeat("X",string-length(x) )end)
end

obfuscateItem(items,"item")


cpiTable= load-table:
  Code :: String,
  Indicies :: String,
  Aug-24 :: Number,
  Sep-24 :: Number,
  Oct-24 :: Number,
  Nov-24 :: Number,
  Dec-24 :: Number,
  Jan-25 :: Number,
  Feb-25 :: Number,
  Mar-25 :: Number,
  Apr-25 :: Number,
  May-25 :: Number,
  Jun-25 :: Number,
  Jul-25 :: Number,
  Aug-25 :: Number
  source:csv-table-file("ons-cpih-aug25.csv",default-options)
  sanitize Aug-24 using num-sanitizer
  sanitize Sep-24 using num-sanitizer
  sanitize Oct-24 using num-sanitizer
  sanitize Nov-24 using num-sanitizer
  sanitize Dec-24 using num-sanitizer
  sanitize Jan-25 using num-sanitizer
  sanitize Feb-25 using num-sanitizer
  sanitize Mar-25 using num-sanitizer
  sanitize Apr-25 using num-sanitizer
  sanitize May-25 using num-sanitizer
  sanitize Jun-25 using num-sanitizer
  sanitize Jul-25 using num-sanitizer
  sanitize Aug-25 using num-sanitizer
end

cpiTable

fun calc-difference(r :: Row) -> Number:
  num-exact(num-abs(r["Aug-24"]) - num-abs(r["Aug-25"]))
end

fun calc-pct-difference(r :: Row) -> Number:
  (num-abs((r["Aug-24"]) - (r["Aug-25"])) / ((r["Aug-24"]) + (r["Aug-25"])) / 2) * 100
end

cpiTableNew = build-column(cpiTable, "difference", calc-difference)
build-column(cpiTableNew, "pct-difference", calc-pct-difference)