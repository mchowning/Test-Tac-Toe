//
//  TTTBoard.m
//  TestTacToe
//
//  Created by Matt Chowning on 3/26/14.
//  Copyright (c) 2014 Matt Chowning. All rights reserved.
//

#import "TTTBoard.h"

@interface TTTBoard()
@property (nonatomic) NSUInteger boardSize;
@property (nonatomic, strong) NSMutableArray *positions;
@property (nonatomic) BOOL player1turn;
@property (nonatomic) BOOL isWin;
@end

@implementation TTTBoard

- (NSString *)getPositionAtRow:(NSUInteger)row andCol:(NSUInteger)col {
    if (self.boardSize <= col || self.boardSize <= row) {
        [[NSException exceptionWithName:@"Invalid Position" reason:nil userInfo:nil] raise];
    }
    NSUInteger index = [self getIndexFromRow:row andCol:col];
    return self.positions[index];
}

- (NSUInteger)getIndexFromRow:(NSUInteger)row andCol:(NSUInteger)col {
    return (3 * row) + col;
}

- (void)touchBoardAtRow:(NSUInteger)row column:(NSUInteger)col {
    NSUInteger index = [self getIndexFromRow:row andCol:col];
    if ([self.positions[index] isEqualToString:@""]) {
        self.positions[index] = (self.player1turn) ? @"X" : @"O";
        self.player1turn = !self.player1turn;
    }
}

- (BOOL)isWin {
    return [self horizontalWin] || [self verticalWin] || [self diagonalWin];
}

- (BOOL)horizontalWin {
    for (NSUInteger row = 0; row < self.boardSize; row++) {
        BOOL allMatchingInRow = YES;
        for (NSUInteger col = 1; col < self.boardSize; col++) {
            if ([self getPositionAtRow:row andCol:(col - 1)] !=
                [self getPositionAtRow:row andCol:col])
            {
                allMatchingInRow = NO;
            }
        }
        if (allMatchingInRow) return YES;
    }
    return NO;
}

- (BOOL)verticalWin {
    for (NSUInteger col = 0; col < self.boardSize; col++) {
        BOOL allMatchingInColumn = YES;
        for (NSUInteger row = 1; row < self.boardSize; row++) {
            if ([self getPositionAtRow:row andCol:col] !=
                [self getPositionAtRow:(row - 1) andCol:col])
            {
                allMatchingInColumn = NO;
            }
                
        }
        if (allMatchingInColumn) return YES;
    }
    return NO;
}

- (BOOL)diagonalWin {
    BOOL forwardDiagonalIsAllMatching = YES;
    BOOL backwardDiagonalIsAllMatching = YES;
    for (NSUInteger i = 1; i < self.boardSize; i++) {
        if ([self getPositionAtRow:i-1 andCol:i-1] !=
            [self getPositionAtRow:i andCol:i])
        {
            forwardDiagonalIsAllMatching = NO;
        }
        if ([self getPositionAtRow:(self.boardSize - i) andCol:(self.boardSize - i)] !=
            [self getPositionAtRow:(self.boardSize - i - 1) andCol:(self.boardSize - i - 1)])
        {
            backwardDiagonalIsAllMatching = NO;
        }
    }
    return forwardDiagonalIsAllMatching || backwardDiagonalIsAllMatching;
}

#pragma mark - Lifecycle methods

- (id)initWithSize:(NSUInteger)size {
    self = [super init];
    if (self) {
        self.boardSize = size;
        self.isWin = false;
        self.player1turn = true;
        self.positions = [[NSMutableArray alloc] init];
        NSUInteger numPositions = pow(self.boardSize, 2);
        for (int i = 0; i < numPositions; i++) {
            [self.positions addObject:@""];
        }
    }
    return self;
}

// Initializes to a 3x3 board by default
-(id)init {
    return [self initWithSize:3];
}

@end
