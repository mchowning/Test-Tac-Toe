#import "Kiwi.h"
#import "TTTBoard.h"

SPEC_BEGIN(BoardSpec)

describe(@"Creating board of proper size", ^{
    
    __block TTTBoard *b;
    
    beforeEach(^{
        b = [[TTTBoard alloc] init];
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

describe(@"Recognizing win condition of", ^{
    
    __block TTTBoard *b;
    
    beforeEach(^{
        b = [[TTTBoard alloc] init];
    });
    
    it(@"first row with three X's", ^{
        [b touchBoardAtRow:0 column:0]; // Place 'X'
        [b touchBoardAtRow:1 column:0];
        [b touchBoardAtRow:0 column:1]; // Place 'X'
        [b touchBoardAtRow:1 column:1];
        [b touchBoardAtRow:0 column:2]; // Place 'X'
        [[theValue([b isWin]) should] beTrue];
    });
    
    it(@"second column with three O's", ^{
        [b touchBoardAtRow:0 column:0];
        [b touchBoardAtRow:0 column:1]; // Place O
        [b touchBoardAtRow:0 column:2];
        [b touchBoardAtRow:1 column:1]; // Place O
        [b touchBoardAtRow:2 column:0];
        [b touchBoardAtRow:2 column:1]; // Place O
        [[theValue([b isWin]) should] beTrue];
    });
    
    it(@"diagnol win of X's", ^{
        [b touchBoardAtRow:0 column:0];  // Place X
        [b touchBoardAtRow:0 column:1];
        [b touchBoardAtRow:1 column:1];  // Place X
        [b touchBoardAtRow:0 column:2];
        [b touchBoardAtRow:2 column:2];  // Place X
        [[theValue([b isWin]) should] beTrue];
    });
    
    it(@"board with no wins", ^{
        
        //   X | O | X
        //  ---+---+---
        //   O | O | X
        //  ---+---+---
        //   X | X | O
        
        [b touchBoardAtRow:0 column:0];
        [b touchBoardAtRow:0 column:1];
        [b touchBoardAtRow:0 column:2];
        [b touchBoardAtRow:1 column:0];
        [b touchBoardAtRow:1 column:2];
        [b touchBoardAtRow:1 column:1];
        [b touchBoardAtRow:2 column:0];
        [b touchBoardAtRow:2 column:2];
        [b touchBoardAtRow:2 column:1];
        [[theValue([b isWin]) should] beFalse];
    });
    
});

SPEC_END