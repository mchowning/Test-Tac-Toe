#import "Kiwi.h"
#import "TTTBoard.h"

SPEC_BEGIN(BoardSpec)

describe(@"Creating default board of proper size (3x3)", ^{
    
    __block TTTBoard *b;
    
    beforeEach(^{
        b = [[TTTBoard alloc] init];
    });
    
    it(@"board size", ^{
        [[theValue(b.boardSize) should] equal:theValue(3)];
    });
    
    for (int row = 0; row < 3; row++) {
        for (int col = 0; col < 3; col++) {
            it([NSString stringWithFormat:@"has valid position at %d, %d coordinate", row, col], ^{
                [[[b getPositionAtRow:row andCol:col] should] equal:@""];
            });
        }
    }
    
    it(@"has only three columns", ^{
        void(^testBlock)() = ^{[b getPositionAtRow:3 andCol:4];};
        [[theBlock(testBlock) should] raiseWithName:@"Invalid Position"];
    });
    
    
    it(@"has only three rows", ^{
        void(^testBlock)() = ^{[b getPositionAtRow:4 andCol:3];};
        [[theBlock(testBlock) should] raiseWithName:@"Invalid Position"];
    });
    
    for (int row = 0; row < 3; row++) {
        for (int col = 0; col < 3; col++) {
            it([NSString stringWithFormat:@"position %d, %d starts as an empty string", row, col], ^{
                NSString *cellString = [b getPositionAtRow:row andCol:col];
                [[cellString should] equal:@""];
            });
        }
    }
});

describe(@"Creating non-default board", ^{
    
    __block TTTBoard *b;
    __block NSUInteger boardSize = 5;
    
    beforeEach(^{
        b = [[TTTBoard alloc] initWithSize:boardSize];
    });
    
    for (int row = 0; row < boardSize; row++) {
        for (int col = 0; col < boardSize; col++) {
            it([NSString stringWithFormat:@"has valid position at %d, %d coordinate", row, col], ^{
                [[[b getPositionAtRow:row andCol:col] should] equal:@""];
            });
            
        }
    }
    
    __block NSUInteger maxValidPosition = boardSize - 1;
    __block NSUInteger invalidPosition = boardSize;
    
    it([NSString stringWithFormat:@"has only %d columns", boardSize], ^{
        void(^testBlock)() = ^{[b getPositionAtRow:maxValidPosition andCol:invalidPosition];};
        [[theBlock(testBlock) should] raiseWithName:@"Invalid Position"];
    });
    
    
    it([NSString stringWithFormat:@"has only %d rows", boardSize], ^{
        void(^testBlock)() = ^{[b getPositionAtRow:invalidPosition andCol:maxValidPosition];};
        [[theBlock(testBlock) should] raiseWithName:@"Invalid Position"];
    });
    
    for (int row = 0; row < boardSize; row++) {
        for (int col = 0; col < boardSize; col++) {
            it([NSString stringWithFormat:@"position %d, %d starts as an empty string", row, col], ^{
                NSString *cellString = [b getPositionAtRow:row andCol:col];
                [[cellString should] equal:@""];
            });
        }
    }
    
});

describe(@"Touching", ^{
    
    __block TTTBoard *b;
    
    beforeEach(^{
        b = [[TTTBoard alloc] init];
    });
    
    for (int row = 0; row < 3; row++) {
        for (int col = 0; col < 3; col++) {
            it(@"at position (%d, %d) places an 'X'", ^{
                [b touchBoardAtRow:row column:col];
                NSString *positionValue = [b getPositionAtRow:row andCol:col];
                [[positionValue should] equal:@"X"];
            });
        }
    }
    
    it(@"a position with an 'X' a second time leaves the 'X'", ^{
        [b touchBoardAtRow:0 column:0];
        [b touchBoardAtRow:0 column:0];
        NSString *positionValue = [b getPositionAtRow:0 andCol:0];
        [[positionValue should] equal:@"X"];
    });
    
    it(@"a second position places an 'O'", ^{
        [b touchBoardAtRow:0 column:0];
        [b touchBoardAtRow:0 column:1];
        NSString *positionValue = [b getPositionAtRow:0 andCol:1];
        [[positionValue should] equal:@"O"];
    });
    
    it(@"a position with an 'O' a second time leaves the 'O'", ^{
        [b touchBoardAtRow:0 column:0];
        [b touchBoardAtRow:1 column:1];
        [b touchBoardAtRow:1 column:1];
        NSString *positionValue = [b getPositionAtRow:1 andCol:1];
        [[positionValue should] equal:@"O"];
    });
    
    it(@"a third position places a second 'X'", ^{
        [b touchBoardAtRow:0 column:0];
        [b touchBoardAtRow:0 column:1];
        [b touchBoardAtRow:0 column:2];
        NSString *positionValue = [b getPositionAtRow:0 andCol:2];
        [[positionValue should] equal:@"X"];
    });
    
});

describe(@"Recognizing", ^{
    
    __block TTTBoard *b;
    
    beforeEach(^{
        b = [[TTTBoard alloc] init];
    });
    
    it(@"first row with three X's is a win", ^{
        [b touchBoardAtRow:0 column:0]; // Place 'X'
        [b touchBoardAtRow:1 column:0];
        [b touchBoardAtRow:0 column:1]; // Place 'X'
        [b touchBoardAtRow:1 column:1];
        [b touchBoardAtRow:0 column:2]; // Place 'X'
        [[theValue([b isWin]) should] beTrue];
    });
    
    it(@"second column with three O's is a win", ^{
        [b touchBoardAtRow:0 column:0];
        [b touchBoardAtRow:0 column:1]; // Place O
        [b touchBoardAtRow:0 column:2];
        [b touchBoardAtRow:1 column:1]; // Place O
        [b touchBoardAtRow:2 column:0];
        [b touchBoardAtRow:2 column:1]; // Place O
        [[theValue([b isWin]) should] beTrue];
    });
    
    it(@"diagonal win of X's is a win", ^{
        [b touchBoardAtRow:0 column:0];  // Place X
        [b touchBoardAtRow:0 column:1];
        [b touchBoardAtRow:1 column:1];  // Place X
        [b touchBoardAtRow:0 column:2];
        [b touchBoardAtRow:2 column:2];  // Place X
        [[theValue([b isWin]) should] beTrue];
    });
    
    it(@"board with no wins", ^{
        [b touchBoardAtRow:0 column:0];
        [b touchBoardAtRow:0 column:1];
        [b touchBoardAtRow:0 column:2];
        [b touchBoardAtRow:1 column:0];
        [b touchBoardAtRow:1 column:2];
        [b touchBoardAtRow:1 column:1];
        [b touchBoardAtRow:2 column:0];
        [b touchBoardAtRow:2 column:2];
        [b touchBoardAtRow:2 column:1];
        
        //   X | O | X
        //  ---+---+---
        //   O | O | X
        //  ---+---+---
        //   X | X | O
        
        [[theValue([b isWin]) should] beFalse];
    });
    
});

SPEC_END