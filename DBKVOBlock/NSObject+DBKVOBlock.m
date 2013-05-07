//
//  NSObject+DBKVOBlock.m
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
