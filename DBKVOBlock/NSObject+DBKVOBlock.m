//
//  NSObject+DBKVOBlock.m
//  DBKVOBlock
//
//  Created by Daniel Beard on 6/05/13.
//  Copyright (c) 2013 Daniel Beard. All rights reserved.
//

#import "NSObject+DBKVOBlock.h"

@implementation NSObject (DBKVOBlock)

-(void) observeKeyPath: (id) keyPath withAction: (DBKVOSimpleBlock) block {
    [[DBKVOBlock sharedManager] observeObject:self withKeyPath:keyPath withAction:block];
}

-(void) removeObserverForObject: (id) object {
    [[DBKVOBlock sharedManager] removeObserverForObject:object];
}

-(void) removeObserverForObject: (id) object withKeyPath: (id) keyPath {
    [[DBKVOBlock sharedManager] removeObserverForObject:object withKeyPath:keyPath];
}

-(void) removeAllObservers {
    [[DBKVOBlock sharedManager] removeAllObservers];
}

@end
