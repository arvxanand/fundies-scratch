use context starter2024

string-to-upper("hello cs2000")

overlay(circle(30, "solid", "blue"),
  rectangle(100, 70, "solid", "yellow"))

overlay(rectangle(60, 40, "solid", "green"),
  rectangle(100, 70, "solid", "purple"))

r = rectangle(100, 20, "solid", "red")
rotate(-45, r)
rotate(45, r)

overlay(text("STOP", 30, "white"),
  regular-polygon(40, 8, "solid", "red"))

above(triangle(90, "solid", "dark-red"),
  overlay(rectangle(20, 20, "solid", "black"),
    rectangle(80, 60, "solid", "brown")))

