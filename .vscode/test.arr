use context dcic2024

fun full-name(first-name :: String, last-name :: String) -> String:
  doc: "Combines first and last name with a space"
  a = string-append(first-name, " ")
  string-append(a, last-name)
where:
  full-name("John", "Doe") is "John Doe"
  full-name("Jane", "Smith") is "Jane Smith"
  full-name("A", "B") is "A B"
end