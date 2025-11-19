use context dcic2024

sales = table: item :: String, unit_price :: Number, units_sold :: Number
  row: "Pen", 2.50, 30
  row: "Notebook", 5.00, 15
  row: "Binder", 7.00, 8
end

fun add-sales-total(t :: Table) -> Table:
  build-column(t, "sales-total", lam(r): r["unit_price"] * r["units_sold"] end)
where:
  add-sales-total(sales).row-n(0)["sales-total"] is 75
end




areas = table: shape :: String, length :: Number, width :: Number
  row: "A", 3, 4
  row: "B", 10, 2
  row: "C", 7, 3
end

fun add-area(t :: Table) -> Table:
  build-column(t, "area", lam(r): r["length"] * r["width"] end)
where:
  add-area(areas).row-n(0)["area"] is 12
end




fruits = table: name :: String, price :: Number, amount :: Number
  row: "Strawberry", 0.20, 40
  row: "Banana", 0.10, 30
  row: "Pear", 0.50, 10
end

fun cheapest-fruits(t :: Table) -> Table:
  g = build-column(t, "total cost", lam(r): r["price"] * r["amount"] end)
  order-by(g, "total cost", true)
where:
  cheapest-fruits(fruits).row-n(0)["total cost"] is 3
end




players = table: name :: String, game1 :: Number, game2 :: Number
  row: "Mia", 20, 25
  row: "Sam", 35, 30
  row: "Alex", 28, 32
end

fun top-player(t :: Table) -> Table:
  g = build-column(t, "total score", lam(r): r["game1"] + r["game2"] end)
  order-by(g, "total score", false)
where:
  top-player(players).row-n(0)["name"] is "Sam"
end



products = table: item :: String, price :: Number, discount :: Number
  row: "Lamp", 25, 10
  row: "Couch", 120, 30
  row: "Desk", 70, 5
end

fun deals(t :: Table) -> Table:
  g = build-column(t, "discounted-price", lam(r): 
      (r["price"] * (1 - (r["discount"] / 100))) end)
    filtered = filter-with(g, lam(r): r["discounted-price"] < 80 end)
    order-by(filtered, "discounted-price", true)
where:
  deals(products).length() is 2
end


workers = table: name :: String, hours :: Number, wage :: Number
  row: "Rita", 40, 20
  row: "Liam", 35, 25
  row: "Nina", 45, 18
  row: "Eli", 30, 30
end

fun top-earners(t :: Table) -> Table:
  g = build-column(t, "pay", lam(r): r["hours"] * r["wage"] end)
  filtered = filter-with(g, lam(r): r["pay"] > 800 end)
  order-by(filtered, "pay", false) 
where:
  top-earners(workers).row-n(0)["name"] is "Eli"
  end