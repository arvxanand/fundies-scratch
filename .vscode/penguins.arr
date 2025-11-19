use context dcic2024
include csv
include data-source


penguins = load-table: rownames, species, island, bill_length_mm, bill_depth_mm, flipper_length_mm, body_mass_g, sex, year
  source: csv-table-file("penguins.csv", default-options)
  sanitize flipper_length_mm using num-sanitizer
  sanitize body_mass_g using num-sanitizer
end


#Section 1: Scalar Processing
fun long-flipper(r):
  r["flipper_length_mm"] > 190
end

penguins-boolean =
  penguins.build-column("long_flipper", lam(p): long-flipper(p) end)

row0 = penguins.row-n(0)
row14 = penguins.row-n(14)
row30 = penguins.row-n(30)


check:
  long-flipper(row0) is false
  long-flipper(row14) is true
  long-flipper(row30) is true
end



  

#Section 2: 
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


row0group = penguins-flipper-group.row-n(0)["flipper_group"]
row123group = penguins-flipper-group.row-n(123)["flipper_group"]
row239group = penguins-flipper-group.row-n(239)["flipper_group"]

check:
  row0group is "short"
  row123group is "medium"
  row239group is "long"
end


#Section 3: 

power-swimmers =
  penguins-flipper-group.filter(lam(r):
    (r["flipper_group"] == "long") and
    (r["body_mass_g"] >= 5000) and
    ((r["island"] == "Biscoe") or (r["island"] == "Dream"))
  end)

num-power-swimmers = power-swimmers.length()


fun is-in-power-swimmers(original-row):
  power-swimmers.filter(lam(ps-row):
    (ps-row["species"] == original-row["species"]) and
    (ps-row["body_mass_g"] == original-row["body_mass_g"]) and
    (ps-row["flipper_length_mm"] == original-row["flipper_length_mm"])
  end).length() > 0
end


check:
  is-in-power-swimmers(penguins-flipper-group.row-n(239)) is true
  is-in-power-swimmers(penguins-flipper-group.row-n(0)) is false
  is-in-power-swimmers(penguins-flipper-group.row-n(258)) is true
end


#Section 4: 
