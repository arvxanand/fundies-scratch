import file("lab2-support.arr") as support

#1
#support.encryptor1("hello.")

fun my-encryptor1(input1 :: String) -> String:
  doc: "returns inputted word five times" 
  input1 + input1 + input1 + input1 + input1
end

check: 
  my-encryptor1("hello.") is "hello.hello.hello.hello.hello."
end


#2
#support.encryptor2("hello.")
#support.encryptor2("goodbye")
#support.encryptor2("water")
#support.encryptor2("friend")

fun my-encryptor2(input2 :: String) -> String:
  doc: "takes inputted string and only returns first 4 characthers" 
  string-substring(input2, 0, 4)
end

check: 
  my-encryptor2("hello.") is "hell"
end

#3
#support.encryptor3("hello.")
#support.encryptor3("rainbows!")

fun my-encryptor3(input3 :: String) -> String:
  doc: "switches any . to !" 
  string-replace(input3, ".", "!")
end

check: 
  my-encryptor3("hello.") is "hello!"
end


#4
#support.encryptor4("hello.")
#support.encryptor4("goodbye")
#support.encryptor4("circle")

fun my-encryptor4(input4 :: String) -> String:
  doc: "switches any . to !" 
  input4-1 = string-substring(input4, 0, 4)
   input4-1 +  input4-1 +  input4-1 +  input4-1 +  input4-1
end

check: 
  my-encryptor4("hello.") is "hellhellhellhellhell"
end


#5
#support.encryptor5("abcdefghijklmnopqrstuvwqyz")


fun my-encryptor5(input5 :: String) -> String:
  doc: "switches all the vowels to different letters" 
  input5-1 = string-replace(input5, "a", "b")
  input5-2 = string-replace(input5-1, "e", "f")
  input5-3 = string-replace(input5-2, "i", "j")
  input5-4 = string-replace(input5-3, "o", "p")
  string-replace(input5-4, "u", "v")

end

check: 
  my-encryptor5("abcdefghijklmnopqrstuvwqyz") is "bbcdffghjjklmnppqrstvvwqyz"
end


#6
#support.encryptor6("abcdefghijklmnopqrstuvwqyz")
#support.encryptor6("abcdefghijklmnopqstuvwqyz")

fun my-encryptor6(input6 :: String) -> String:
  doc: ""
  string-replace(input6, "r", "")
end

check: 
  my-encryptor6("rainbows") is "ainbows"
end

#7 
fun my-encryptor7(input7 :: String) -> Number:
  doc: ""
  string-length(input7)
end

check: 
  my-encryptor7("abcdefghijklmnopqrstuvwqyz") is 26
end

#8

#support.encryptor8("hello")
#support.encryptor8("circle")

fun my-encryptor8(input8 :: String) -> String:
  doc: ""
  input8-1 = input8 + "!!!"
  input8-1 + input8-1 + input8-1 
end

check: 
  my-encryptor8("hello") is "hello!!!hello!!!hello!!!"
end

#9
#support.encryptor9("z")
#support.encryptor9("heart")


fun my-encryptor9(input9 :: String) -> Number:
  doc: ""
  input9-1 = string-substring(input9, 0, 1)
  string-to-code-point(input9-1) 

end


check: 
  my-encryptor9("z") is 122
end


support.encryptor10("aeiuo")
support.encryptor10("heart")


fun my-encryptor10(input10 :: String) -> String:
  doc: "switches all the vowels to different letters" 
  input10-1 = string-replace(input10, "a", "b")
  input10-2 = string-replace(input10-1, "e", "f")
  input10-3 = string-replace(input10-2, "i", "j")
  input10-4 = string-replace(input10-3, "o", "")
  input10-5 = string-replace(input10-4, "u", "v")
  
  input10-5 + input10-5 + input10-5 + input10-5 + input10-5

end

check: 
  my-encryptor10("aeiou") is "bfjvbfjvbfjvbfjvbfjv"
end