//
//  DBKVOObject.h
//  DBKVOBlock
//
//  Created by Daniel Beard on 6/05/13.
//  Copyright (c) 2013 Daniel Beard. All rights reserved.
//

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
