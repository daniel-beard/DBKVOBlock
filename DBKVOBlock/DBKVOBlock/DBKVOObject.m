//
//  DBKVOObject.m
//  DBKVOBlock
//
//  Created by Daniel Beard on 6/05/13.
//  Copyright (c) 2013 Daniel Beard. All rights reserved.
//

#import <objc/runtime.h>
#import "DBKVOObject.h"

@implementation DBKVOObject

-(instancetype) initWithObject: (id) object {
    
    if (self = [super init]) {
        self.object = object;
        
        //this is where set our block to auto remove any observers if this object is deallocated
        [self.object addDeallocBlock:^{
            [[DBKVOBlock sharedManager] removeObserverForObject:self.object];
        }];
    }
    return self;
}

-(void) addKeyPath:(NSString *)keyPath forBlock:(DBKVOSimpleBlock)block {

    //have to copy a block when we add it to an array, yes even under ARC!
    [self.keyPaths addObject:keyPath];
    [self.blocks addObject:[block copy]];
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

@implementation DBDeallocBlock

-(id) initWithBlock:(DBKVOSimpleBlock)block {
    
    if (self = [super init]) {
        self.block = block;
    }
    return self;
}

-(void) dealloc {
    if (self.block)
        self.block();
}

@end

@implementation NSObject (DBDeallocExtension)

-(void) addDeallocBlock:(DBKVOSimpleBlock)block {
    
    //Alloc dealloc block object and associate with the object
    DBDeallocBlock *deallocBlockObject = [[DBDeallocBlock alloc] initWithBlock: block];
    objc_setAssociatedObject(self, (__bridge void*)deallocBlockObject, deallocBlockObject, OBJC_ASSOCIATION_RETAIN);
}

@end
