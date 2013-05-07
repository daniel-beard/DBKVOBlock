//
//  NSObject+DBKVOBlock.h
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
