// Jinxin Pan
// jpan@hamdenhall.com
// 6/27/16
// Fahrenheit converter

let NUM_LINES = 21 // odd number only

    for i in 0...(NUM_LINES)/2-1 {
        for _ in 0...(NUM_LINES/2-i-1){
            print (" ", terminator : "")
        }
        for _ in 0...(2*i){
            print ("*", terminator : "")
        }
        print("")
    }
    for _ in 0...(NUM_LINES-1){
        print ("*", terminator : "")
    }
    print("")
    for i in 0...(NUM_LINES)/2-1 {
        for _ in 0...i{
        print (" ", terminator : "")
    }
    for _ in 1...((NUM_LINES)-2*(i+1)){
        print ("*", terminator : "")
    }
    print("")
}
