//
//  DBKVOBlock.h
//  DBKVOBlock
//
//  Created by Daniel Beard on 3/05/13.
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

/** Typedef of the block we are using for performing actions */
 typedef void(^DBKVOSimpleBlock)();

#import <Foundation/Foundation.h>
#import "NSObject+DBKVOBlock.h"

/** This class enables the use of blocks when using Key-Value Observing instead of the normal
 cumbersome interface.
 It also provides some helper methods for registering and unregistering observers.
 */
@interface DBKVOBlock : NSObject

/** Singleton access method */
+(instancetype) sharedManager;

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
