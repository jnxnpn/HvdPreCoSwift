/* Dan Armendariz
 * danallan@cs.harvard.edu
 *
 * Staff-supplied (hidden) functions for game of fifteen exercises.
 */

import Darwin

public class Staff {
    
    /* sign()
     * Finds the inversion count of the board.
     * from: http://www.geeksforgeeks.org/check-instance-15-puzzle-solvable/
     * parameter a: [Int] tiles numbered sequentially, [0,board.length),
     *                    with empty at board.length-1
     * returns inversion count
     */
    private static func sign(a: [Int]) -> Int
    {
        var count = 0
        let empty = a.count - 1
        for (i, num) in a.enumerate()
        {
            if (num == empty)
            {
                continue
            }
            for j in i + 1 ..< a.count
            {
                if a[j] < num
                {
                    count += 1
                }
            }
        }
        return count
    }
    
    /* isBoardSolvable
     * accepts a board with tiles from [1, board.count], massages it for
     * _sign() by converting tiles to [0, board.count), locates the empty
     * tile and ensures the sign of the permutation of the board matches
     * the sign of the distance of the empty tile. Returns true if board
     * is solvable, false otherwise.
     */
    public static func isBoardSolvable(board: [Int]) -> Bool?
    {
        // the width and height of the board
        let size = Int(sqrt(Double(board.count)))
        
        // is inversion count even or odd
        let boardSign = self.sign(board) % 2
        
        // odd-width boards are solvable if sign is even
        if size % 2 == 1
        {
            return boardSign == 0
        }
        
        // even-width boards
        if let index = board.indexOf(board.count - 1)
        {
            // is empty in an odd row from bottom
            let emptyRowSign = (index / size) % 2
            
            // puzzle validity for even width puzzles
            return emptyRowSign != boardSign
        }
        
        // if we're here, we couldn't find empty tile :(
        print("STAFF: Could not find empty tile")
        return nil
    }
    
    /*
     * isBoardSolvable() for two-dimensional boards.
     */
    public static func isBoardSolvable(board: [[Int]]) -> Bool?
    {
        // flatten the board to a 1d array
        return self.isBoardSolvable(board.flatMap({ $0 }))
    }
    
}
