//
//  DBKVOObject.m
//  DBKVOBlock
//
//  Created by Daniel Beard on 6/05/13.
//  Copyright (c) 2013 Daniel Beard. All rights reserved.
//

#import "DBKVOObject.h"

@implementation DBKVOObject

-(void) addKeyPath:(NSString *)keyPath forBlock:(DBKVOSimpleBlock)block {

    [self.keyPaths addObject:keyPath];
    [self.blocks addObject:block];
}

-(NSMutableArray*) getBlocksForKeyPath: (NSString*) keyPath {
   
    NSMutableArray *results = [NSMutableArray array];
    
    for (int i=0; i<self.keyPaths.count; i++) {
        if ([keyPath isEqualToString:self.keyPaths[i]]) {
            [results addObject:self.blocks[i]];
        }
    }
    return results;
}

#pragma mark - Lazy init methods

-(NSMutableArray*) keyPaths {
    if (!_keyPaths) {
        _keyPaths = [NSMutableArray array];
    }
    return _keyPaths;
}

-(NSMutableArray*) blocks {
    if (!_blocks)
        _blocks = [NSMutableArray array];
    return _blocks;
}

@end
