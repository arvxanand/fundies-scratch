use context dcic2024


include lists
include data-source
include csv

student_score = 
  load-table: Name, Surname, Email, Score
    source: csv-table-file("students_gate_exam_score.csv", default-options)
  end

top-3-table = student_score.order-by("Score", false).take(3)

data Student:
  | student(name :: String, surname :: String, score :: Number)
end

s1 = student("Ethan", "Gray", 97)
s2 = student("Oscar", "Young", 92)
s3 = student("Adrian", "Bennett", 80)

scores :: List<Number> =
  link(s1.score,
    link(s2.score,
      link(s3.score, empty)))

fun count-above-90(lst :: List<Number>) -> Number:
  doc: "Counts how many scores in the list are greater than 90"
  cases (List) lst:
    | empty => 0
    | link(first, rest) =>
      if first > 90:
        1 + count-above-90(rest)
      else:
        count-above-90(rest)
      end
  end
where:
  count-above-90(empty) is 0
  count-above-90(link(95, empty)) is 1
  count-above-90(link(85, link(92, empty))) is 1
  count-above-90(link(91, link(97, link(88, empty)))) is 2
end

result-count = count-above-90(scores)

top3 :: List<Student> = link(s1, link(s2, link(s3, empty)))

fun filter-above-80(students :: List<Student>) -> List<Student>:
  doc: "Returns a list of students whose scores are greater than 80"
  cases (List) students:
    | empty => empty
    | link(first, rest) =>
      if first.score > 80:
        link(first, filter-above-80(rest))
      else:
        filter-above-80(rest)
      end
  end
where:
  filter-above-80(empty) is empty
  s-test = student("Test", "Student", 85)
  s-test2 = student("Test2", "Student2", 75)
  filter-above-80(link(s-test, link(s-test2, empty))).length() is 1
end

result-students = filter-above-80(top3)

# TASK 2 - PROCESSING LISTS


all-emails :: List<String> = student_score.get-column("Email")

fun get-domain(email :: String) -> String:
  doc: "Extracts the university name from an email address"
  parts = string-split(email, "@")
  domain = parts.get(1)
  domain-parts = string-split(domain, ".")
  university = domain-parts.get(0)
  university
where:
  get-domain("e.gray@nulondon.ac.uk") is "nulondon"
  get-domain("a.bennett@northeastern.edu") is "northeastern"
  get-domain("b.clark@virginia.edu") is "virginia"
end

uni-domain :: List<String> = map(get-domain, all-emails)
unique-universities :: List<String> = distinct(uni-domain)

fun replace-domain(email :: String) -> String:
  doc: "Replaces nulondon.ac.uk domain with northeastern.edu"
  parts = string-split(email, "@")
  username = parts.get(0)
  domain = parts.get(1)
  
  if domain == "nulondon.ac.uk":
    username + "@northeastern.edu"
  else:
    email
  end
where:
  replace-domain("e.gray@nulondon.ac.uk") is "e.gray@northeastern.edu"
  replace-domain("a.bennett@northeastern.edu") is "a.bennett@northeastern.edu"
  replace-domain("b.clark@virginia.edu") is "b.clark@virginia.edu"
end

all-emails-transformed :: List<String> = map(replace-domain, all-emails)


print("=== TASK 1 RESULTS ===")
print("Top 3 Students:")
print(s1)
print(s2)
print(s3)
print("")
print("Count of scores > 90: " + to-string(result-count))
print("Students with score > 80: " + to-string(result-students.length()))
print("")

print("=== TASK 2 RESULTS ===")
print("Total emails: " + to-string(all-emails.length()))
print("Unique universities: ")
print(unique-universities)
print("")
print("First 3 original emails:")
print(all-emails.take(3))
print("")
print("First 3 transformed emails:")
print(all-emails-transformed.take(3))
