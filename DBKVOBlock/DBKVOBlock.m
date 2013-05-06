//
//  DBKVOBlock.m
//  DBKVOBlock
//
//  Created by Daniel Beard on 3/05/13.
//  Copyright (c) 2013 Daniel Beard. All rights reserved.
//

#import "DBKVOBlock.h"
#import "DBKVOObject.h"

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

/** Currently trying to change this so it's:
 [ObjectDictionary]
 KeyPath1:
    [Object,
    Block],
    [Object,
    Block]
 KeyPath2:
    [Object,
    Block]
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
        kvoObject = [[DBKVOObject alloc] init];
        [self.objectsAndKeys setObject:kvoObject forKey:[NSNumber numberWithInteger:[object hash]]];
    }
    
    kvoObject.object = object;
    [kvoObject addKeyPath:keyPath forBlock:block];
    
    //Register the observer
    [object addObserver:self forKeyPath:keyPath options:0 context:NULL];
}

-(void) removeAllObservers {
  
    /*
    //get all observed objects
    NSArray *kvoObjects = [self.objectsAndKeys allValues];
    for (DBKVOObject *kvoObject in kvoObjects) {
        [self removeObserverForObject:kvoObject.object];
    }
     */
}

-(void) removeObserverForObject: (id) object {
    /*
    if (!object)
        return;
    
    self removeObserverForObject:object withKeyPath:<#(id)#>
     */
}

-(void) removeObserverForObject: (id) object withKeyPath: (id) keyPath {
    
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
