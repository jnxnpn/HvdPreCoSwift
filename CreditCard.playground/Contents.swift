//Jinxin Pan
//jpan@hamdenhall.org
//
//Credit Card Checker
var card = 4222222222206
var sumA = 0
var sumB = 0
var numOfDigit = 0;
var prefix = 0;   //for potential further type identification
var digit : Int
print(card)

repeat{
    if (card/100) == 0 && prefix == 0 {
        prefix = card
    }
    digit = card % 10
    numOfDigit = numOfDigit + 1
    card = card/10
    
    if numOfDigit % 2 == 1{
        sumA = sumA + digit
    }else{
        sumB = sumB + (digit * 2) % 10 + (digit * 2) / 10
    }
    
}while card > 0

    
prefix
numOfDigit
digit

if (sumA + sumB) % 10 == 0{
    print("Valid Number")
    print("\nType: ", terminator : "")
    
    switch digit {
    case 3 : print ("American Express/Diners Club/JCB")
    case 4 : print ("Visa")
    case 5 : print ("MasterCard")
    case 6 : print ("Discover Card")
    default : print ("Unknown")
    }
}
else{
    print("Not Valid Number")
}
