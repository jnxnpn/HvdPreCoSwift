/*
1. Multiple all elements of a list together.
2. Transform an array of values represented in Fahrenheit to Celsius.
3. Find the largest element of a list.
4. Transform a double array into it's reciprocal values. Be sure to get rid of 0s! For example: [-0.5, 0, 8] should become to [-2, 0.125]
 ---
 Jun.29 the higher-order functions
 Jinxin Pan :jpan@hamdenhall.org
 */



func reduce <v> (input: [v], _ ini: v, _ f: (v, v)->v)->v{
    var x = ini
    for i in 0 ..< input.count {
        x = f( input[i] , x )
    }
    return x
}

let theList1 = [23.3,65.2,18.6,44,32,29.4,99.4,0.23,34,0.231,23.2999]
let theList2 = [123,14.3,0,2.34,0.22,4.7,5]


//Q1
//print ("product: \(reduce(theList1, 1 , {return $0*$1}))")



func map (input:[Double], f : (Double)->Double) -> [Double]{
    var answer : [Double] = []
    for i in input {
        answer.append(f(i))
    }
    return answer
}


func filter (input:[Double], f : (Double)->Bool ) -> [Double]{
    
    var answer : [Double] = []
    for i in input {
        if f (i)==true{
            answer.append(i)
        }
    }
    return answer
    
}


//Q2
//print ("Degree celsius: \(map(theList1, f: {($0-32)/1.8}))")

//Q3
//print ("max: \(reduce(theList1, 0, {return max($1, $0)}))")

//Q4

//print( map(filter(theList2, f: {return ($0 != 0.0)}), f: {return 1/$0}))



//QuickSort

func QuickSort (input : [Double]) -> [Double] {
    
    if input.count == 0{
        return []
    }
    var ans : [Double] = []
        
    let LA = filter(input, f: {return $0 < input[input.count-1]})
    let LB = filter(input, f: {return $0 > input[input.count-1]})
    let pivot = filter(input, f: {return $0 == input[input.count-1]})
    
    if LA.count <= 1 && LB.count <= 1  {
        ans = LA + pivot + LB
    }else{
        ans = QuickSort(LA) + pivot + QuickSort(LB)
    }
    
    return ans
    
}


print(QuickSort([3,3,3,3,3,3,3,3,3,22,22,22,22,23,4,1,1,1,1,1,1,1,1,0.1,2,2,2,2,2,34,12]))

