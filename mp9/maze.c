#include "maze.h"

#include <stdio.h>
#include <stdlib.h>

/*
  Intro Paragraph:
  partners: swhuang3, ycc6, dhhuang3
  Finish all functions
  partners: swhuang3, ycc6, dhhuang3
*/

int inBound(maze_t *maze, int row, int col) {
    return col >= 0 && col < maze->width && row >= 0 && row < maze->height;
}

typedef struct {
    int first;
    int second;
} pair;

/*
 * createMaze -- Creates and fills a maze structure from the given file
 * INPUTS:       fileName - character array containing the name of the maze file
 * OUTPUTS:      None
 * RETURN:       A filled maze structure that represents the contents of the input file
 * SIDE EFFECTS: None
 */
maze_t *createMaze(char *fileName) {
    // Your code here. Make sure to replace following line with your own code.
    maze_t *maze = malloc(sizeof(maze_t));

    FILE *infile = fopen(fileName, "r");
    fscanf(infile, "%d %d\n", &maze->width, &maze->height);

    maze->cells = malloc(maze->height * sizeof(char *));
    
    int y;
    for (y = 0; y < maze->height; y++) {
        maze->cells[y] = malloc(maze->width * sizeof(char));
        int x;
        for (x = 0; x < maze->width; x++) {
            char input = fgetc(infile);
            if (input == START) {
                maze->startRow = y;
                maze->startColumn = x;
            } else if (input == END) {
                maze->endRow = y;
                maze->endColumn = x;
            }
            maze->cells[y][x] = input;
        }
        fgetc(infile);
    }

    fclose(infile);

    return maze;
}

/*
 * destroyMaze -- Frees all memory associated with the maze structure, including the structure itself
 * INPUTS:        maze -- pointer to maze structure that contains all necessary information
 * OUTPUTS:       None
 * RETURN:        None
 * SIDE EFFECTS:  All memory that has been allocated for the maze is freed
 */
void destroyMaze(maze_t *maze) {
    // Your code here.
    int y;
    for (y = 0; y < maze->height; y++) {
        free(maze->cells[y]);
    }
    free(maze->cells);
    free(maze);
}

/*
 * printMaze --  Prints out the maze in a human readable format (should look like examples)
 * INPUTS:       maze -- pointer to maze structure that contains all necessary information
 *               width -- width of the maze
 *               height -- height of the maze
 * OUTPUTS:      None
 * RETURN:       None
 * SIDE EFFECTS: Prints the maze to the console
 */
void printMaze(maze_t *maze) {
    // Your code here.
    int y;
    for (y = 0; y < maze->height; y++) {
        int x;
        for (x = 0; x < maze->width; x++) {
            printf("%c", maze->cells[y][x]);
        }
        printf("\n");
    }
}

/*
 * solveMazeManhattanDFS -- recursively solves the maze using depth first search,
 * INPUTS:               maze -- pointer to maze structure with all necessary maze information
 *                       col -- the column of the cell currently beinging visited within the maze
 *                       row -- the row of the cell currently being visited within the maze
 * OUTPUTS:              None
 * RETURNS:              0 if the maze is unsolvable, 1 if it is solved
 * SIDE EFFECTS:         Marks maze cells as visited or part of the solution path
 */
int solveMazeDFS(maze_t *maze, int col, int row) {
    // Your code here. Make sure to replace following line with your own code.

    pair up, down, left, right;
    up.first = row - 1;
    up.second = col;
    down.first = row + 1;
    down.second = col;
    left.first = row;
    left.second = col - 1;
    right.first = row;
    right.second = col + 1;

    pair adjacentCellPos[4] = {up, down, left, right};
    int adjacentHasPath = 0;

    int i;
    for (i = 0; i < 4; i++) {
        pair pos = adjacentCellPos[i];
        if (!inBound(maze, pos.first, pos.second)) {
            continue;
        }
        char cellValue = maze->cells[pos.first][pos.second];
        // printf("%d %d %d %c\n",i, pos.first, pos.second, cellValue);
        if (cellValue == END) {
            maze->cells[row][col] = PATH;
            if (row == maze->startRow && col == maze->startColumn) {
                maze->cells[row][col] = START;
            }
            return 1;
        }
        if (cellValue == EMPTY) {
            maze->cells[row][col] = PATH;
            if (solveMazeDFS(maze, pos.second, pos.first)) {
                adjacentHasPath = 1;
            }
            // printf("find adjacent %d %d %d %c\n",i, pos.first, pos.second, cellValue);
        }
    }

    // printf("\n");

    if (!adjacentHasPath) {
        maze->cells[row][col] = VISITED;
    }

    if (row == maze->startRow && col == maze->startColumn) {
        maze->cells[row][col] = START;
    }

    return adjacentHasPath;
}
