/*:

# Morse Code

**Hari Anbarasu**\
[hari.anbarasu@yale.edu](mailto:hari.anbarasu@yale.edu)\
**Dan Armendariz**\
[danallan@cs.harvard.edu](mailto:danallan@cs.harvard.edu)\
[iOS App Development with Swift](http://danallan.github.io/swift-precop/)
 
Morse Code is a way to transfer information through a series of "dots" and "dashes", primarily used now in aviation and radio. In this problem, we'll be creating two functions: One, which will encode english into morse code and one which will decode Morse Code into English. To get you started, we've provided the dictionaries converting between english characters and morse code and vice-versa (but note how the english to morse only has lowercase characters!).
*/
var encodeToMorse: [Character:String] = [
    "a" : ".-",
    "b" : "-...",
    "c" : "-.-.",
    "d" : "-..",
    "e" : ".",
    "f" : "..-.",
    "g" : "--.",
    "h" : "....",
    "i" : "..",
    "j" : ".---",
    "k" : "-.-",
    "l" : ".-..",
    "m" : "--",
    "n" : "-.",
    "o" : "---",
    "p" : ".--.",
    "q" : "--.-",
    "r" : ".-.",
    "s" : "...",
    "t" : "-",
    "u" : "..-",
    "v" : "...-",
    "w" : ".--",
    "x" : "-..-",
    "y" : "-.--",
    "z" : "--..",
    "🆘": "... --- ..."
]




/*:
 # Problem A: Encode
 Write a function that will encode plain english text into morse code. This function should only work with alphabetic characters (and the SOS emoji) and should return the morse code translation. Delete the `return` line when you begin working on a solution; we provide it only to make sure Swift doesn't display any errors.
 */
func encode(input: String) -> [String?] {
    var answer : [String?] = []
    if input.characters.count > 0 {
    for i in 0 ..< input.characters.count {
        if let a = encodeToMorse [input [input.startIndex.advancedBy(i)]]{
            answer.append(a)
        }
        else{
            answer.append(nil)
        }
        }
    }
     return answer
}


encode ("djfs  aoi")


/*:
 # Problem B: Invert
 Write a function that will take the encodeToMorse dictionary and invert the keys and values to create a dictionary which can be used by Problem 3, to decode morse code into english. Delete the `return` line when you begin working on a solution; we provide it only to make sure Swift doesn't display any errors.
 */
func invert() -> [String: Character] {
    var answer: [String: Character] = [:]
    for (theC, theS) in encodeToMorse{
        answer [theS] = theC
    }
    return answer
}

var decodeMorse = invert()
/*:
 # Problem C: Decode
 Write a function that will take morse code and decode it back to english text. Use `decodeMorse`, since that will allow you to easily look up a character from a given morse code. Keep in mind that when inputting a morse code string, it will have spaces in between each character to correspond to each letter. Delete the `return` line when you begin working on a solution; we provide it only to make sure Swift doesn't display any errors.
 */

// LOOK UP ANSWER FOR HERE

func decode(input: [String?]) -> String {
    var ans : String = ""
    for i in input{
        if let a = i{
            if let b = decodeMorse [a]{
                ans += String(b)
            }
            else {
                ans += " "
            }
        }
    }
    return ans
}




print (decode([".--","...","---","... --- ..." ," gfd",".-."]))




