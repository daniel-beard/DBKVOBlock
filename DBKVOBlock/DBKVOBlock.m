//
//  DBKVOBlock.m
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

#import "DBKVOBlock.h"
#import "DBKVOObject.h"

@interface DBKVOBlock ()

/** This dictionary stores the observed objects in a custom DBKVOObject that stores
 the object itself, an array of keyPaths and an array of blocks.
 */
@property (nonatomic, strong) NSMutableDictionary *objectsAndKeys;

@end

@implementation DBKVOBlock

#pragma mark - Singleton Methods

+ (id)sharedManager {
    static DBKVOBlock *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

#pragma mark - Register / Unregister Observers

-(void) observeObject: (id) object withKeyPath: (id) keyPath withAction: (DBKVOSimpleBlock) block {
  
    //Add a new object using the object's hash as the key
    DBKVOObject *kvoObject = [self.objectsAndKeys objectForKey:[NSNumber numberWithInteger:[object hash]]];
    
    if (!kvoObject) {
        kvoObject = [[DBKVOObject alloc] initWithObject:object];
        [self.objectsAndKeys setObject:kvoObject forKey:[NSNumber numberWithInteger:[object hash]]];
    }
    
    [kvoObject addKeyPath:keyPath forBlock:block];
    
    //Register the observer
    [object addObserver:self forKeyPath:keyPath options:0 context:NULL];
}

-(void) removeAllObservers {
  
    //get all observed objects
    NSArray *kvoObjects = [self.objectsAndKeys allValues];
    for (DBKVOObject *kvoObject in kvoObjects) {
        //pass up to next method
        [self removeObserverForObject:kvoObject.object];
    }
}

-(void) removeObserverForObject: (id) object {

    if (!object)
        return;
    
    //get kvoObject for object
    DBKVOObject *kvoObject = [self.objectsAndKeys objectForKey:[NSNumber numberWithInteger:[object hash]]];
    
    if (!kvoObject)
        return;
    
    //remove all keypaths
    for (NSString *keyPath in kvoObject.keyPaths) {
        //pass up to next method
        if (kvoObject.object)
            [self removeObserverForObject:kvoObject.object withKeyPath:keyPath];
    }
}

-(void) removeObserverForObject: (id) object withKeyPath: (id) keyPath {
    
    if (!object)
        return;
    
    //stop observing the object
    [object removeObserver:self forKeyPath:keyPath];
   
    //we only remove the full object when no other keyPaths or blocks remain registered
    DBKVOObject *kvoObject = [self.objectsAndKeys objectForKey:[NSNumber numberWithInteger:[object hash]]];
    for (int i=0; i<kvoObject.keyPaths.count; i++) {
        
        if ([keyPath isEqualToString:kvoObject.keyPaths[i]]) {
            //remove the keyPath and the block
            [kvoObject.keyPaths removeObjectAtIndex:i];
            [kvoObject.blocks removeObjectAtIndex:i];
        }
    }
    
    if (kvoObject.keyPaths.count == 0)
        [self.objectsAndKeys removeObjectForKey:[NSNumber numberWithInteger:[object hash]]];
}

#pragma mark - Implemented KVO Method

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
   
    //Get DBKVOObject for object
    DBKVOObject *kvoObject = [self.objectsAndKeys objectForKey:[NSNumber numberWithInteger:[object hash]]];
    
    if (!kvoObject)
        return;
    
    //Get blocks for keyPath
    NSArray *blocks = [kvoObject getBlocksForKeyPath:keyPath];
    
    for (DBKVOSimpleBlock block in blocks) {
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
