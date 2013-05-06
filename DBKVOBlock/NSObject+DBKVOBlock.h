//
//  NSObject+DBKVOBlock.h
//  DBKVOBlock
//
//  Created by Daniel Beard on 6/05/13.
//  Copyright (c) 2013 Daniel Beard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBKVOBlock.h"

/** This category just passes the calls onto the DBKVOBlock shared manager */
@interface NSObject (DBKVOBlock)

-(void) observeKeyPath: (id) keyPath withAction: (DBKVOSimpleBlock) block;

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
