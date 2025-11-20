use context dcic2024
include csv
include data-source

#Here we are calling the Penguins CSV file and loading all the columns and rows in the file. We are also making sure to sanitize the the numeric values we are using so their is no errors when it comes to our functions.  
penguins = load-table: rownames, species, island, bill_length_mm, bill_depth_mm, flipper_length_mm, body_mass_g, sex, year
  source: csv-table-file("penguins.csv", default-options)
  sanitize flipper_length_mm using num-sanitizer
  sanitize body_mass_g using num-sanitizer
end


#Section 1: Scalar Processing
fun flipper-is-long(r):
  r["flipper_length_mm"] > 190 #Here we are checking each value in the column flipper length and seeing if its over 190mm. If it is, it is true and if it not it is false. 
end

penguins-boolean =
  penguins.build-column("flipper_is_long", lam(p): flipper-is-long(p) end)
#Here we build a new column containing the true and false values called long flipper. 

row0 = penguins.row-n(0)
row14 = penguins.row-n(14)
row30 = penguins.row-n(30)
#Here we are just setting the certain rows as variables so we can call them when we do the check function. 


check:
  flipper-is-long(row0) is false
  flipper-is-long(row14) is true
  flipper-is-long(row30) is true
end
#Simple check function to see if if the code works. 










#Section 2: Selection 
mean-flipper = mean(penguins, "flipper_length_mm") #We are creating a variable called mean-flipper where we are finding the mean of all of the values in the column flipper length mm in the penguins csv. 

fun flipper-group(r):
  l = r["flipper_length_mm"]
  if l < mean-flipper:
    "short"
  else if l < (mean-flipper + 10):
    "medium" 
  else: "long" 
  end
end
#Simple if/else function. We are setting L as the flipper length column and if L is less then the mean of all the flipper lengths we say its short. If its less than the mean + 10 then we call it medium. If none of those then its long. 

penguins-flipper-group =
  penguins.build-column("flipper_group", flipper-group)
#Creating a new column here called flipper group where it holds in each row if a penguin has a short, medium, or long flipper. 

row0group = penguins-flipper-group.row-n(0)["flipper_group"]
row123group = penguins-flipper-group.row-n(123)["flipper_group"]
row239group = penguins-flipper-group.row-n(239)["flipper_group"]

check:
  row0group is "short"
  row123group is "medium"
  row239group is "long"
end
#Simple check function to see if a certain row is short, medium, or long.

num-of-flipper-short = penguins-flipper-group.filter(lam(r): r["flipper_group"] == "short" end).length()
num-of-flipper-medium = penguins-flipper-group.filter(lam(r): r["flipper_group"] == "medium" end).length()
num-of-flipper-long = penguins-flipper-group.filter(lam(r): r["flipper_group"] == "long" end).length()
#What I am doing here is filtering in the penguins flipper group by short, medium, and long and putting them in seperate variables. I am doing this because I am then going to use these variables for a pie chart. 

all-flipper = table: flipper_group, count
  row: "short", num-of-flipper-short
  row: "medium", num-of-flipper-medium
  row: "long", num-of-flipper-long
end
#Here I am just manually creating a new table so that I can call this table for my pie chart. 

pie-chart(all-flipper, "flipper_group", "count")
#function to call the interactive pie chart that you can see in my report. 








#Section 3: Selection

power-swimmers =
  penguins-flipper-group.filter(lam(r):
    (r["flipper_group"] == "long") and
    (r["body_mass_g"] >= 5000) and
    ((r["island"] == "Biscoe") or (r["island"] == "Dream"))
  end)
#I am creating a new variable called power swimmers. I am trying to find the penguins in the csv file that have are considered powerful swimmers based on a criteria that I set above. 

num-power-swimmers = power-swimmers.length()
#This doesnt really do anything for the code except I put it here so I can see how many rows are in the new table. 

fun is-in-power-swimmers(original-row):
  power-swimmers.filter(lam(r):
      (r["species"] == original-row["species"]) and
      (r["body_mass_g"] == original-row["body_mass_g"]) and
      (r["flipper_length_mm"] == original-row["flipper_length_mm"])
  end).length() > 0
end
#This function here is checking to see what rows match and if they do match they are over 0. 

check:
  is-in-power-swimmers(penguins-flipper-group.row-n(239)) is true
  is-in-power-swimmers(penguins-flipper-group.row-n(0)) is false
  is-in-power-swimmers(penguins-flipper-group.row-n(258)) is true
end

num-of-male = power-swimmers.filter(lam(r): r["sex"] == "male" end).length()
num-of-female = power-swimmers.filter(lam(r): r["sex"] == "female" end).length()
#Here again I am doing the same thing I did in the previos section of creating seperate variables to see ratio of how many males there are compared to females as powerful swimmers. 

#Doing this doesnt help it become a Selection but I am creating this chart as a visual for my report. 

m-to-f-ratio-table = table: sex, count
  row: "male", num-of-male
  row: "female", num-of-female
end
#Once again here I am creating a manual table for my pie chart. 

pie-chart(m-to-f-ratio-table, "sex", "count")
#Calling my pie chart. 












#Section 4: Accumulation
fun body-mass-kg(r):
  r["body_mass_g"] / 1000
end
#I am converting the body mass column from grams to kilograms

penguins-mass-kg =
  penguins-flipper-group.build-column("body_mass_kg", body-mass-kg)
#Building a new column called penguins mass kg that holds all the penguins masses in kg in the existing table. 

adelie-avg = mean(penguins-mass-kg.filter(lam(r): r["species"] == "Adelie" end), "body_mass_kg")
gentoo-avg = mean(penguins-mass-kg.filter(lam(r): r["species"] == "Gentoo" end), "body_mass_kg")
chinstrap-avg = mean(penguins-mass-kg.filter(lam(r): r["species"] == "Chinstrap" end), "body_mass_kg")
#Here we are doing the same thing we did in the previos two sections where we are creating seperate varaibles for three diferent species and finding the avg of mass for all the kgs in each of the species. 

avg-mass-per-species = table: species, avg_body_mass_kg
  row: "Adelie", adelie-avg
  row: "Gentoo", gentoo-avg
  row: "Chinstrap", chinstrap-avg
end
#Here we are creating the new table where we show the avg of the means for each of the species. Here we are showing accumulation because we are taking combining a bunch of rows into one value which in this is our avg value of the weight. 

bar-chart(avg-mass-per-species, "species", "avg_body_mass_kg")
#Once again we are calling a bar chart to show how great the avg mass of a certain species is. 

check:
  adelie-avg > 0 is true
  gentoo-avg > 0 is true
  chinstrap-avg > 0 is true
end