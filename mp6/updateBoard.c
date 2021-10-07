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
#define board_2d(i, j) board[i * boardColSize + j]
#define old_board_2d(i, j) old_board[i * boardColSize + j]

int countLiveNeighbor(int* board, int boardRowSize, int boardColSize, int row, int col) {
    int count = 0;
    for (int y = row - 1; y <= row + 1; y++) {
        for (int x = col - 1; x <= col + 1; x++) {
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

    for (int i = 0; i < boardRowSize * boardColSize; i++) {
        old_board[i] = board[i];
    }

    for (int y = 0; y < boardRowSize; y++) {
        for (int x = 0; x < boardColSize; x++) {
            int count = countLiveNeighbor(old_board, boardRowSize, boardColSize, y, x);
            if (old_board_2d(y, x)) {
                if (count != 2 && count != 3) {
                    board_2d(y, x) = 0;
                }
            } else {
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
                if (count != 2 && count != 3) {
                    return 0;
                }
            } else {
                if (count == 3) {
                    return 0;
                }
            }
        }
    }
    return 1;
}


#undef board_2d
#undef old_board_2d
