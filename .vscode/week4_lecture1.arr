use context dcic2024
include csv

# 1. Orders table
orders = table: time, amount
  row: "08:00", 10.50
  row: "09:30", 5.75
  row: "10:15", 8.00
  row: "11:00", 3.95
  row: "14:00", 4.95
  row: "16:45", 7.95
end

# 2. Function to check if time is morning
fun is-morning(o):
  o["time"] < "12:00"
end

# 3. Filter for morning orders (named and lambda)
morning-orders = filter-with(orders, is-morning)
morning-orders2 = filter-with(orders, lam(o): o["time"] < "12:00" end)

# 4. Orders sorted by time, latest to earliest
orders-by-latest = order-by(orders, "time", false)

# 5. Amount of latest morning order
latest-morning-order = order-by(morning-orders, "time", false)
amount-latest-morning = latest-morning-order.row-n(0)["amount"]

# 6. Load photo data directly from URL
photos-csv = csv-table-url("https://pdi.run/f25-2000-photos.csv", default-options)
photos = load-table: Subject, Date, Location
  source: photos-csv
end

# 7. Filter for subject "Forest"
forest-photos = filter-with(photos, lam(r): r["Subject"] == "Forest" end)

# 8. Order forest photos by date
forest-photos-by-date = order-by(forest-photos, "Date", false)

# 9. Extract the location of the most recent forest photo, safely
most-recent-location =
  if forest-photos-by-date.count > 0:
    forest-photos-by-date.row-n(0)["Location"]
  else:
    "No forest photos found"
  end

# 10. Count photos per location
location-counts = count(photos, "Location")

# 11. Order location counts by most photos
location-counts-ordered = order-by(location-counts, "count", false)

# 12. Frequency bar chart for Location
freq-bar-chart(photos, "Location")
