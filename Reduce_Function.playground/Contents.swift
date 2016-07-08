//Reduce function
//jpan@hamdenhall.org
//Jinxin Pan
//Jun.29



func reduce (input: [Double], _ ini: Double, _ f: (Double, Double)->Double)->Double{
    var x = ini
    for i in 0 ..< input.count {
        x = f( x, input[i]  )
    }
    return x
}

let rr = [98.7,67.1,56.39,123.0,97.8,57]


reduce(rr,0,-)


let celsius = { 1.8 * ($0-32) }


