use context dcic2024

include csv
include data-source

penguins = load-table: rownames, species, island, bill_length_mm, bill_depth_mm, flipper_length_mm, body_mass_g, sex, year
  source: csv-table-file("penguins.csv", default-options)
  sanitize flipper_length_mm using num-sanitizer
  sanitize body_mass_g using num-sanitizer
end


mean-flipper = mean(penguins, "flipper_length_mm")

fun flipper-group(r):
  l = r["flipper_length_mm"]
  if l < mean-flipper:
    "short"
  else if l < (mean-flipper + 10):
    "medium" 
  else: "long" 
  end
end

penguins-flipper-group =
  penguins.build-column("flipper_group", flipper-group)

# Example checks
row0group = penguins-flipper-group.row-n(0)["flipper_group"]
row123group = penguins-flipper-group.row-n(123)["flipper_group"]
row239group = penguins-flipper-group.row-n(239)["flipper_group"]

check:
  row0group is "short"
  row123group is "medium"
  row239group is "long"
end

# Count penguins in each flipper group
flipper-counts-short = penguins-flipper-group.filter(lam(r): r["flipper_group"] == "short" end).length()
flipper-counts-medium = penguins-flipper-group.filter(lam(r): r["flipper_group"] == "medium" end).length()
flipper-counts-long = penguins-flipper-group.filter(lam(r): r["flipper_group"] == "long" end).length()

# Create a manual data table for the chart
flipper-group-counts = table: flipper_group, count
  row: "short", flipper-counts-short
  row: "medium", flipper-counts-medium
  row: "long", flipper-counts-long
end

pie-chart(flipper-group-counts, "flipper_group", "count")








