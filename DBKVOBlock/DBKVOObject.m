//
//  DBKVOObject.m
//  DBKVOBlock
//
//  Created by Daniel Beard on 6/05/13.
//  Copyright (c) 2013 Daniel Beard. All rights reserved.
//
/* @author daniel beard
 * http://danielbeard.wordpress.com
 * http://github.com/daniel-beard
 *
 * Copyright (C) 2013 Daniel Beard
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

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
