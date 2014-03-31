//
//  TTTBoard.h
//  TestTacToe
//
//  Created by Matt Chowning on 3/26/14.
//  Copyright (c) 2014 Matt Chowning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTTBoard : NSObject

@property (nonatomic, readonly) NSUInteger boardSize;
@property (nonatomic, readonly) BOOL isWin;

- (NSString *)getPositionAtRow:(NSInteger)row andCol:(NSInteger)col;
- (void)touchBoardAtRow:(NSInteger)row column:(NSInteger)col;
    
@end
