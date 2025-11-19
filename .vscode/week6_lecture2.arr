use context starter2024

fun string-concat(l :: List<String>) -> String:
  doc: "Joins all strings in the list into a single string"
  cases (List) l:
    | empty      => ""
    | link(f, r) => string-append(f, string-concat(r))
  end
where:
  string-concat([list: "hello", " ", "world"]) is "hello world"
  string-concat([list: "a", "b", "c"]) is "abc"
  string-concat([list: "only"]) is "only"
  string-concat([list: ]) is ""
end


fun strings-upper(l :: List<String>) -> List<String>:
  doc: "Returns a list of strings with all values converted to uppercase"
  cases (List) l:
    | empty      => empty
    | link(f, r) => link(string-to-upper(f), strings-upper(r))
  end
where:
  strings-upper([list: "hello", "world"]) is [list: "HELLO", "WORLD"]
  strings-upper([list: "Pyret", "is", "fun"]) is [list: "PYRET", "IS", "FUN"]
  strings-upper([list: "test"]) is [list: "TEST"]
  strings-upper([list: ]) is [list: ]
end


fun round-numbers(l :: List<Number>) -> List<Number>:
  doc: "Returns a list of numbers with each decimal rounded to the nearest integer"
  cases (List) l:
    | empty      => empty
    | link(f, r) => link(num-round(f), round-numbers(r))
  end
where:
  round-numbers([list: 3.7, 2.3, 5.5]) is [list: 4, 2, 6]
  round-numbers([list: 1.4, 8.6, 2.5]) is [list: 1, 9, 3]
  round-numbers([list: -3.2, -7.8]) is [list: -3, -8]
  round-numbers([list: 10.0]) is [list: 10]
  round-numbers([list: ]) is [list: ]
end
