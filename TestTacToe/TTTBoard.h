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

- (id)initWithSize:(NSUInteger)size;
- (NSString *)getPositionAtRow:(NSUInteger)row andCol:(NSUInteger)col;
- (void)touchBoardAtRow:(NSUInteger)row column:(NSUInteger)col;
    
@end
