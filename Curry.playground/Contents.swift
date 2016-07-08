//Jinxin Pan   
//jpan@hamdenhall.org
//
//curry


func curry (f: (Double, Double)->Double) -> (Double)-> ((Double)-> Double)
{
    return {
        let para = $0
        return {
            return f(para, $0)
        }
    }
}

func findDiff(a: Double, _ b : Double) -> Double {
    return a-b
}

let diffTo999 = curry(findDiff)(999)

diffTo999 (666)

let diffBetween = curry(findDiff)

diffBetween(123)(23)







