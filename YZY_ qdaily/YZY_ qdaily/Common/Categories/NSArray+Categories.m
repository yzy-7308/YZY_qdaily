//
//  NSArray+Categories.m
//  BaseProject
//
//  Created by Eiwodetianna on 15/8/5.
//  Copyright (c) 2015年 Eiwodetianna. All rights reserved.
//

#import "NSArray+Categories.h"

@implementation NSArray (Categories)

+ (BOOL)isEmpty:(NSArray *)array{
    if(array == nil || array.count == 0)
        return YES;
    return NO;
}
@end

@implementation NSArray (Safe)

- (id)safeObjectAtIndex:(NSInteger)index {
    if ( index < 0 )
        return nil;
    
    if ( index >= self.count )
        return nil;
    
    return [self objectAtIndex:index];
}

- (NSArray *)safeSubarrayWithRange:(NSRange)range {
    if ( 0 == self.count )
        return nil;
    
    if ( range.location >= self.count )
        return nil;
    
    if ( range.location + range.length >= self.count )
        return nil;
    
    return [self subarrayWithRange:NSMakeRange(range.location, range.length)];
}
@end

@implementation NSMutableArray (Sort)

- (void)sort {
    [self sort:^NSComparisonResult(id left, id right) {
        return [left compare:right];
    }];
}

- (void)sort:(NSMutableArrayCompareBlock)compare {
    [self sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return compare( obj1, obj2 );
    }];
}

@end
