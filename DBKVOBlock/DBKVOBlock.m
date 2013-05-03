//
//  DBKVOBlock.m
//  DBKVOBlock
//
//  Created by Daniel Beard on 3/05/13.
//  Copyright (c) 2013 Daniel Beard. All rights reserved.
//

#import "DBKVOBlock.h"

@interface DBKVOBlock ()

/** This dictionary stores the keys with the objects that are being observed 
 
 The format is: 
 
 Object 1
    - KeyPath1
        -Block
    - KeyPath2
        -Block
        -Block
 Object 2
    - KeyPath1
        -Block
 
 */
@property (nonatomic, strong) NSMutableDictionary *objectsAndKeys;

@end

@implementation DBKVOBlock

#pragma mark - Register / Unregister Observers

-(void) observeObject: (id) object withKeyPath: (id) keyPath withAction: (DBKVOSimpleBlock) block {
   
    //The object is used as the key in the dictionary, get the KeyPath dictionary if it exists
    NSMutableDictionary *keyPaths = [self.objectsAndKeys objectForKey:object];
    
    if (!keyPaths) {
        //create new keyPath dictionary
        keyPaths = [NSMutableDictionary dictionary];
        [self.objectsAndKeys setObject:keyPaths forKey:object];
    }
    
    //Check if any existing block arrays exist for this keyPath
    NSMutableArray *blocksForKeyPath = [keyPaths objectForKey:keyPath];

    if (!blocksForKeyPath) {
        //Create the block array if it doesn't exist
        blocksForKeyPath = [NSMutableArray array];
        [keyPaths setObject:blocksForKeyPath forKey:keyPath];
    }

    //Add the block to the blocks array
    [blocksForKeyPath addObject:block];

    //Register the observer
    [object addObserver:self forKeyPath:keyPath options:0 context:NULL];
}

-(void) removeObserverForObject: (id) object {
    
}

-(void) removeObserverForObject: (id) object withKeyPath: (id) keyPath {
    
}

-(void) removeAllObservers {
    
}

#pragma mark - Implemented KVO Method

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
   
    //Get Blocks for keypath of object
    NSMutableDictionary *keyPathsForObject = [self.objectsAndKeys objectForKey:object];
    NSMutableArray *blocksForKeyPath;
    if (keyPathsForObject) {
        blocksForKeyPath = [keyPathsForObject objectForKey:keyPath];
    }
    
    for (DBKVOSimpleBlock block in blocksForKeyPath) {
        if (block)
            block();
    }
    
}

#pragma mark - Memory Management

/** Lazy init for objectsAndKeys dictionary */
-(NSMutableDictionary*) objectsAndKeys {
    if (!_objectsAndKeys)
        _objectsAndKeys = [NSMutableDictionary dictionary];
    return _objectsAndKeys;
}


@end
