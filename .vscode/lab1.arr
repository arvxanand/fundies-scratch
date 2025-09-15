use context starter2024

# This is Question 1 (T-shirt Shop)

price_per_shirt = 12
fee = 3

fee + (price_per_shirt * 5)  #cost for 5 shirts


fee + (price_per_shirt * 7)  #cost for 7 shirts


(fee + (price_per_shirt * 7)) - (fee + (price_per_shirt * 5))  #difference of cost of 7 and 5 shirts


# This is Question 2 (T-shirt Shop)

perimeter = 2 * (420 + 594) #2028
0.10 * perimeter #cost of posters

#For part C if I forget the parentheses, I run into an error where the code will say that the * and + are at the same grouping level and that I must make the order of operations clear. Even if the code let me run it, I would get a different answer since the 2 will multiply with the 420 and then add into the 594 instead of doing it the correct way of inside the parentheses and then multiplying. 


# This is Questions 2 (String Surprises)

#Part 1
test1 = "Designs for everyone!"
test1

test2 = "Designs for everyone!" 
test2
  #If I leave out the punctuation, the code wil run into an error because it thinks the string is still not finished. TO fix it I have to make sure there is correct punctuation on both sides. 


#Part 2
"red"
"red" + "blue" 
"red" + " blue" 
#If I try to add them together then the red + blue combine to become one word.If you add a space in one of thr strings, a space between them is created. Using the + basically just adds them as one string. 

#1 + "blue" wont work because the code expects either two numbers or two strings not one of the two at the same time. 1 + "blue" wont work. 



#This is Question 3 (Traffic Light)
r1 = rectangle(40, 100, "solid", "black")
re = circle(15, "solid", "red")
ye = circle(15, "solid", "yellow")
gr = circle(15, "solid", "green")
three_circles = above(re, above(ye, gr))
overlay-align("center", "middle", three_circles, r1)
pole = rectangle(5, 50, "solid", "black")
above(overlay-align("center", "middle", three_circles, r1), pole)


#This is Question 4 (Broken Code Hunt)
# rectangle(50, "solid", 20, "black") This is an error
rectangle(50, 20, "solid", "black") # This is the correct way to do it. Numbers in the front followed by the way the shape should be filled and the color. 

#circle(30, solid, "red") This is an error
circle(30, "solid", "red") #Solid  needs to be in quotes for the code to work


#This is Question 5 (Create a Flag or Shield)
re1 = rectangle(300, 200, "solid", "purple")
re2 = rectangle(310, 210, "solid", "white")

base = overlay-align("center", "middle", re1, re2)

sha = regular-polygon(50, 19, "solid", "black")

overlay-align("center", "middle", sha, base)

#This is my shape with a white border, a purple flag base, and a regular polygon in the middle. 
