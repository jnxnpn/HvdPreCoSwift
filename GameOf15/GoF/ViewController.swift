//
//  ViewController.swift
//  Game of fifteen
//
//  Based on Sample skeleton code for Game of Fifteen
//  Provided July 5 in class by Dan Armendariz.
//
//  Jinxin Pan
//  Copyright © 2016 Jinxin Pan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var Shuffle: UIButton!
    @IBOutlet var Timer: UIButton!
    
    var numOfRows : Int = 4
    var theBoard : [Int] = []
    var theTiles : [UIButton] = []
    var moves = 0
    
    func swapTilesZeroAndOne( board: [Int]) -> [Int] // 2D
    {
        var tem = board
        swap( &tem [0], &tem [1])
        print("ran")
        return tem

    }
    
    
    
    func generateNewBoard (row : Int) -> [Int]
    {
        Timer.enabled = true
        var ans : [Int] = []
        self.moves = 0
        Record.hidden = true
        winLabel.hidden = true
        myView.hidden = false

        MovesLabel.text = "Move: \(moves)"
        TimerGoing = false
        TimerIsOn = false
        TimerOn = 0
        Timer.hidden = false
        Pause.hidden = true
        TimeLabel.hidden = true
        for i in 0 ..< row*row {
            ans.append(i)
        }
        
        for i in 0 ..< ans.count {
            let swapTo = Int(arc4random_uniform(UInt32(ans.count-i)))
            if swapTo != ans.count-i-1{
                swap( &ans[swapTo], &ans[ans.count-i-1])
            }
        }
        
        if Staff.isBoardSolvable(ans)! == false{
            ans = swapTilesZeroAndOne(ans)
        }
        if Staff.isBoardSolvable(ans)! == false{
            ans = swapTilesZeroAndOne(ans)
        }
        
        return ans
        
    }
    
    
    @IBOutlet var TimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        theBoard = generateNewBoard(numOfRows)
        Shuffle!.addTarget(self, action: #selector(ViewController.ShuffleTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        MovesLabel.text = "Move: \(moves)"
        
        Timer!.addTarget(self, action: #selector(ViewController.TimerTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        TimeLabel.hidden = true
        
        
        Pause!.addTarget(self, action: #selector(ViewController.TimerTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        Difficulty.setEnabled(false, forSegmentAtIndex: 0)
        Difficulty.setEnabled(true, forSegmentAtIndex: 0)//updateConstraints()
    }
    
    
    @IBOutlet  var TimerYL: NSLayoutConstraint!
    @IBOutlet  var TimerXL: NSLayoutConstraint!
    @IBOutlet  var TimerXP: NSLayoutConstraint!
    @IBOutlet var TimerYP: NSLayoutConstraint!
    @IBOutlet var Pause: UIButton!
    
    @IBOutlet var Record: UILabel!
    
    func startTimer(interval: Int)
    {
        NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(interval), target: self, selector: #selector(ViewController.TheTimer), userInfo: nil, repeats: false)
    }
    
    var TimerGoing = false
    var TimerOn = 0
    var TimerIsOn = false
    var allowNextTimerAction = true
    @IBOutlet var Difficulty: UISegmentedControl!
    
    
    func TimerTapped (sender : UIButton){
        
        

            TimerGoing = TimerGoing ? false : true
            if TimerGoing{
                TimeLabel.hidden = false
                Timer.hidden = true
                Pause.hidden = false
                TimerIsOn = true
                TimeLabel.text = "Time:\(TimerOn)"
                toTime()
            }else{
                if TimerIsOn {
                    TimeLabel.hidden = false
                    Timer.hidden = true
                    TimeLabel.text = "Paused"
                    Pause.hidden = false
                }else{
                    TimeLabel.hidden = true
                    Timer.hidden = false
                    Pause.hidden = true

                
            }
            
        }
        
        
    }
    
    func toTime () {
        
        if TimerGoing && allowNextTimerAction {
            allowNextTimerAction = false
            startTimer(1)
            
        }
        
    }
    
    
    
    func TheTimer () {
        allowNextTimerAction = true
        if TimerGoing {
            TimerOn += 1
            TimeLabel.text = "Time:\(TimerOn)"
            toTime()
        }
    }
    
    
    
    
    @IBOutlet var MovesLabel: UILabel!
    @IBOutlet var MovesPY: NSLayoutConstraint!
    @IBOutlet var MovesPX: NSLayoutConstraint!
    @IBOutlet var MovesLY: NSLayoutConstraint!
    @IBOutlet var MovesLX: NSLayoutConstraint!
    @IBOutlet var DiffYL: NSLayoutConstraint!
    @IBOutlet var DiffXL: NSLayoutConstraint!
    
    
    
    func updateConstraints(){
        
        
        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation))
        {
            shuffleCX.active = false
            shuffleCY.active = false
            MovesPY.active = false
            MovesPX.active = false
            shuffleCX_L.active = true
            shuffleCY_L.active = true
            MovesLY.active = true
            MovesLX.active = true
            TimerXP.active = false
            TimerYP.active = false
            TimerYL.active = true
            TimerXL.active = true
            DiffXL.active = true
            DiffYL.active = true
        }
        
        else
        {
            
            shuffleCX.active = true
            shuffleCY.active = true
            MovesPY.active = true
            MovesPX.active = true
            shuffleCX_L.active = false
            shuffleCY_L.active = false
            MovesLY.active = false
            MovesLX.active = false
            TimerXL.active = false
            TimerYL.active = false
            TimerYP.active = true
            TimerXP.active = true
            DiffXL.active = false
            DiffYL.active = false

        }
        
    }
    
    
    
    
    
    func ShuffleTapped (sender : UIButton){
        
        print("Shuffle is tapped")
        doubleCheckShuffle()
        
        
    }
    
    
    func doubleCheckShuffle()
    {
        
        // construct an alert
        let alert = UIAlertController(title: "Shuffle?",
                                      message: "Do you really want to shuffle the board? All progress will be lost.",
                                      preferredStyle: UIAlertControllerStyle.Alert)
        
        // create a button for that alert
        let ok = UIAlertAction(title: "Yes", style: .Default)
        { (action) in
            print("Shuffle requested")
            switch self.Difficulty.selectedSegmentIndex{
                
            case 0 : self.numOfRows = 2
            case 1 : self.numOfRows = 3
            case 2 : self.numOfRows = 4
            case 3 : self.numOfRows = 6
            case 4 : self.numOfRows = 8
            default: self.numOfRows = 4
                
            }
            self.theBoard = self.generateNewBoard(self.numOfRows)
            self.InitializeTheTiles ()
            self.refeshTheTiles()
            self.updateTiles ()
        }
        
        // link OK button to alert
        alert.addAction(ok)
        
        // create a button for that alert
        let cancel = UIAlertAction(title: "No", style: .Cancel)
        { (action) in
            print("Cancel requested")
        }
        
        // link OK button to alert
        alert.addAction(cancel)
        
        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    func refeshTheTiles(){
        
        var tileSize = Float(Float(myView.bounds.size.width)/Float(numOfRows))
        
        func rect (x : Float, _ y : Float) -> CGRect
        {return CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(tileSize), height: CGFloat(tileSize))
        }
        for i in 0 ..< Int(numOfRows*numOfRows){
            
            theTiles[theBoard[i]].frame = (rect(Float(i % numOfRows) * tileSize, Float(i/numOfRows) * tileSize))
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func won(board: [Int]) -> Bool
    {
        for i in 0 ..< board.count{
            if board[i] != i{
                return false
            }
        }
        return true
    }
    
    
    var animating = false
    
    @IBOutlet var winLabel: UILabel!
    
    func tileTapped(sender: UIButton)
    {
        print ("\(sender.tag+1) is pressed")
        
        if isValidMove(sender.tag) && animating == false {
            
            
                animating = true
                let tile0 = myView.viewWithTag(numOfRows*numOfRows-1)!
                let frame0 = tile0.frame
                let frame1 = sender.frame
            swap (&theBoard[whereIsTileNumber(sender.tag)], &theBoard[whereIsTileNumber(numOfRows*numOfRows-1)])
            
            
            UIView.animateWithDuration(0.18, animations:
                {() -> Void in
                    // swap the frames to swap their positions on screen
                    tile0.frame = frame1
                    sender.frame = frame0
                    self.moves += 1
                    self.MovesLabel.text = "Move: \(self.moves)"
                }, completion: { (_: (Bool)) -> Void in
                    self.animating = false
                    if self.won (self.theBoard){
                        //self.myView.hidden = true
                        self.Record.hidden = false
                        self.winLabel.hidden = false
                    }
            })
            
            
                if won (theBoard){
                    
                    print ("you win")
                    TimerIsOn = false
                    TimerGoing = true
                    Timer.enabled = false
                    Record.text = "You used \(TimerOn) Secs \n   and \(moves) steps"
                    
                    //myView.hidden = true
                    TimerTapped(Timer)
                }else{
                    TimerIsOn = true
                    if !TimerGoing {
                        TimerTapped(Timer)
                    }
            }
            
            
            
            
        }
    }
    
    
    func whereIsTileNumber (num : Int)->Int{
        var ans = 0
        for i in theBoard {
            
            if i == num {
                return ans
            }else{
                ans += 1
            }
        }
        return 0
    }
    
    func CoorPositionOf (posInArr : Int) -> (Int,Int){
        return(posInArr % numOfRows, posInArr / numOfRows)
    }
    
    func isValidMove ( obj : Int )->Bool{
        
        let posLast = CoorPositionOf(whereIsTileNumber(numOfRows*numOfRows-1))
        let posObj = CoorPositionOf(whereIsTileNumber(obj))
        print("\(posObj);---\(posLast)")
        
        if abs(posObj.0 - posLast.0) <= 1 && abs(posObj.1 - posLast.1) <= 1 && (abs(posObj.0 - posLast.0)+abs(posObj.1 - posLast.1)) != 2{
            return true
        }else {
            return false
        }
    }
    
    
    
    @IBOutlet var shuffleCY_L: NSLayoutConstraint!
    @IBOutlet var shuffleCX_L: NSLayoutConstraint!
    @IBOutlet var shuffleCY: NSLayoutConstraint!
    @IBOutlet var shuffleCX: NSLayoutConstraint!
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        
        updateConstraints()
        
        
        //when rotation occures: resize each tile
        refeshTheTiles()
    }
    
    
    func InitializeTheTiles () {
        
        for i in theTiles{
            i.removeFromSuperview()
        }
        
        theTiles.removeAll()
        
        let tileSize = Float(Float(myView.bounds.size.width)/Float(numOfRows))//if change the size of the big square, change here
        
        func rect (x : Float, _ y : Float) -> CGRect
        {return CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(tileSize), height: CGFloat(tileSize))
        }
        
        for i in 0 ..< Int(numOfRows*numOfRows-1){
            
            theTiles.append(UIButton(frame: rect(0,0)))
            theTiles[i].tag = i
            theTiles[i].setTitle("\(i+1)", forState: UIControlState.Normal)
        }
        theTiles.append(UIButton(frame: rect(0,0)))
        theTiles[numOfRows*numOfRows-1].tag = numOfRows*numOfRows-1
        
    }
    
    
    override func viewDidAppear(animted: Bool)
    {
        updateConstraints()
        InitializeTheTiles ()
        myView.layer.shadowColor = UIColor.blackColor().CGColor
        myView.layer.shadowOffset = CGSizeMake(2.5, 2.5)
        myView.layer.shadowRadius = 5
        myView.layer.borderColor = UIColor.blackColor().CGColor
        myView.layer.borderWidth = 2
        //
        
        
        
        updateTiles ()
        
    }
    
    
    func updateTiles (){
        
        let tileSize = Float(Float(myView.bounds.size.width)/Float(numOfRows))
        
        func rect (x : Float, _ y : Float) -> CGRect
        {return CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(tileSize), height: CGFloat(tileSize))
        }

        
        for i in 0..<theBoard.count{
            
            if theBoard[i] == (numOfRows*numOfRows-1)
            {
                theTiles[theBoard[i]].frame = rect(Float(i % numOfRows) * tileSize, Float(i/numOfRows) * tileSize)//a placeholder with correct position but no display
                myView.addSubview(theTiles[theBoard[i]])
            }else
            {
                theTiles[theBoard[i]].frame = rect(Float(i % numOfRows) * tileSize, Float(i/numOfRows) * tileSize)
                theTiles[theBoard[i]].layer.borderColor = UIColor.blackColor().CGColor
                theTiles[theBoard[i]].layer.borderWidth = 2
                
                
                // add a shadow!!!!!
                theTiles[theBoard[i]].layer.shadowRadius = 2
                theTiles[theBoard[i]].layer.shadowColor = UIColor.blackColor().CGColor
                theTiles[theBoard[i]].layer.shadowOffset = CGSizeMake(2.0, 2.0)
                theTiles[theBoard[i]].layer.shadowOpacity = 0.5
                
                myView.addSubview(theTiles[theBoard[i]])
                
                theTiles[theBoard[i]].addTarget(self, action: #selector(ViewController.tileTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            }
        }
        
    }
}

