//
//  DBKVOObject.h
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

#import <Foundation/Foundation.h>
#import "DBKVOBlock.h"

/** This is an internal class that DBKVOBlock uses to store objects, keyPaths and blocks
 that are being observed using Key-Value Observing.
 You should not use this class directly.
 */
@interface DBKVOObject : NSObject

/** This is the object we are observing. Weak reference because we don't want to own this object */
@property (nonatomic, weak) id object;
/** Stores the keyPaths of the object that we are observing */
@property (nonatomic, strong) NSMutableArray *keyPaths;
/** The blocks that are executed when a key-value is changed */
@property (nonatomic, strong) NSMutableArray *blocks;

/// @section Helper Methods

-(instancetype) initWithObject: (id) object;

/** Helper method to add a keyPath and a block to an existing DBKVOObject
 keyPath - The keyPath that we are observing
 block - The block to execute
 */
-(void) addKeyPath: (NSString*) keyPath forBlock: (DBKVOSimpleBlock) block;

/** Helper method that returns all blocks for a given keyPath for an object
 keyPath - An NSString representing the keyPath that we are observing on the object
 */
-(NSMutableArray*) getBlocksForKeyPath: (NSString*) keyPath;

@end


/** This is an experimental class that should call a block on deallocation */
@interface DBDeallocBlock : NSObject

-(id) initWithBlock: (DBKVOSimpleBlock) block;
@property (nonatomic, copy) DBKVOSimpleBlock block;

@end

@interface NSObject (DBDeallocExtension)

-(void) addDeallocBlock: (DBKVOSimpleBlock) block;

@end
