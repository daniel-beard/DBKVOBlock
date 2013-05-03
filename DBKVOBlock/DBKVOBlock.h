//
//  DBKVOBlock.h
//  DBKVOBlock
//
//  Created by Daniel Beard on 3/05/13.
//  Copyright (c) 2013 Daniel Beard. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Typedef of the block we are using for performing actions */
 typedef void(^DBKVOSimpleBlock)();

@interface DBKVOBlock : NSObject

/** Observe a keyPath for an object with a result action
 @param object - The object that contains a keyPath that we want to observer
 @param keyPath - The keyPath of the object that contains the value we want to observer
 @param block - The block that should be called when the keyPath changes
 
 TODO: Include a default NSKeyValueObservingOptions value in the documentation with the ability to change it
 */
-(void) observeObject: (id) object withKeyPath: (id) keyPath withAction: (DBKVOSimpleBlock) block;

/** Removes all keyPath observers that are registered with this object 
 @param object - The object to stop observing
 */
-(void) removeObserverForObject: (id) object;

/** Removes KVO for a specific keyPath for a given object
 @param object - The object that we are targeting
 @param keyPath - The keyPath to stop observing for this object
 */
-(void) removeObserverForObject: (id) object withKeyPath: (id) keyPath;

/** Stop KVO for all registered observers */
-(void) removeAllObservers;

@end
