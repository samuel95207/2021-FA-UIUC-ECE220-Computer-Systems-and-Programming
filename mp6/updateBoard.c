/*
  Intro Paragraph:
  partners: swhuang3, ycc6, dhhuang3
    Finish all functions.
    1. Define board_2d(i, j) and old_board_2d(i, j) to access 1D array with 2D position.
    2. In countLiveNeighbor(), iterate through all surrounding cells of the given cell to count the alive surrounding cell.
    3. In updateBoard(), deep copy the original board, then iterate through all cells in board,
       and decide if the cell needs to change state by using countLiveNeighbor() on the original board.
    4. In aliveStable(), do the same thing as updateBoard() without deep copy, return 0 if cell state change, 
       return 1 if the iterate complete without return.
  partners: swhuang3, ycc6, dhhuang3
*/


/*
 * countLiveNeighbor
 * Inputs:
 * board: 1-D array of the current game board. 1 represents a live cell.
 * 0 represents a dead cell
 * boardRowSize: the number of rows on the game board.
 * boardColSize: the number of cols on the game board.
 * row: the row of the cell that needs to count alive neighbors.
 * col: the col of the cell that needs to count alive neighbors.
 * Output:
 * return the number of alive neighbors. There are at most eight neighbors.
 * Pay attention for the edge and corner cells, they have less neighbors.
 */

// Define convenient macros to map 2D access to 1D
#define board_2d(i, j) board[i * boardColSize + j]
#define old_board_2d(i, j) old_board[i * boardColSize + j]

int countLiveNeighbor(int* board, int boardRowSize, int boardColSize, int row, int col) {
    int count = 0;
    // Iterate through the board
    for (int y = row - 1; y <= row + 1; y++) {
        for (int x = col - 1; x <= col + 1; x++) {
            // Check self and out of bound
            if ((y == row && x == col) || y >= boardRowSize || y < 0 || x >= boardColSize || x < 0) {
                continue;
            }
            if (board_2d(y, x)) {
                count++;
            }
        }
    }
    return count;
}
/*
 * Update the game board to the next step.
 * Input: 
 * board: 1-D array of the current game board. 1 represents a live cell.
 * 0 represents a dead cell
 * boardRowSize: the number of rows on the game board.
 * boardColSize: the number of cols on the game board.
 * Output: board is updated with new values for next step.
 */
void updateBoard(int* board, int boardRowSize, int boardColSize) {
    int old_board[boardRowSize * boardColSize];

    // Deep copy the board
    for (int i = 0; i < boardRowSize * boardColSize; i++) {
        old_board[i] = board[i];
    }

    for (int y = 0; y < boardRowSize; y++) {
        for (int x = 0; x < boardColSize; x++) {
            int count = countLiveNeighbor(old_board, boardRowSize, boardColSize, y, x);

            if (old_board_2d(y, x)) {
                // If cell is alive
                if (count != 2 && count != 3) {
                    board_2d(y, x) = 0;
                }
            } else {
                // If cell is not alive
                if (count == 3) {
                    board_2d(y, x) = 1;
                }
            }
        }
    }
}

/*
 * aliveStable
 * Checks if the alive cells stay the same for next step
 * board: 1-D array of the current game board. 1 represents a live cell.
 * 0 represents a dead cell
 * boardRowSize: the number of rows on the game board.
 * boardColSize: the number of cols on the game board.
 * Output: return 1 if the alive cells for next step is exactly the same with 
 * current step or there is no alive cells at all.
 * return 0 if the alive cells change for the next step.
 */
int aliveStable(int* board, int boardRowSize, int boardColSize) {
    for (int y = 0; y < boardRowSize; y++) {
        for (int x = 0; x < boardColSize; x++) {
            int count = countLiveNeighbor(board, boardRowSize, boardColSize, y, x);
            if (board_2d(y, x)) {
                // If cell is alive
                if (count != 2 && count != 3) {
                    // Board change => not stable
                    return 0;
                }
            } else {
                // If cell is not alive
                if (count == 3) {
                    // Board change => not stable
                    return 0;
                }
            }
        }
    }

    // Board didn't change => stable
    return 1;
}


#undef board_2d
#undef old_board_2d
