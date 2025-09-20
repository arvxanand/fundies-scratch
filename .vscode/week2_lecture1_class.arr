use context starter2024
side = 35
colour = "orange"
orange-triangle = triangle(side, "solid",colour)
triangle(side, "solid",colour)

sqr-side = 50
sqr-colour = "red"
red-square = square(sqr-side, "solid", sqr-colour)
square(sqr-side, "solid", sqr-colour)

square2 = square(50, "solid", "red")

rect-width = 80
rect-height = 50
rect-colour = "black"
circ-radius = 15
circ-colour = "yellow"
rect-background = rectangle(rect-width, rect-height, "solid", rect-colour)
circ-front = circle(circ-radius, "solid", circ-colour)
overlay(circ-front, rect-background)

overlay(circle(circ-radius, "solid", circ-colour), rectangle(rect-width, rect-height, "solid", rect-colour))

two-circ = beside(circ-front, circ-front)
overlay-align("center", "middle", two-circ, rect-background)

flag-width = 120
flag-height = 100
flag-bg = rectangle(flag-width, flag-height, "solid", "blue")
emblem-radius = 20
emblem = regular-polygon(25, 12, "solid", "white")
emblem2 = regular-polygon(10, 5, "solid", "purple")
overlay(emblem2, overlay(emblem, flag-bg))