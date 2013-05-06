//
//  DBKVOObject.h
//  DBKVOBlock
//
//  Created by Daniel Beard on 6/05/13.
//  Copyright (c) 2013 Daniel Beard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBKVOBlock.h"

@interface DBKVOObject : NSObject

@property (nonatomic, weak) id object;

@property (nonatomic, strong) NSMutableArray *keyPaths;

@property (nonatomic, strong) NSMutableArray *blocks;

-(void) addKeyPath: (NSString*) keyPath forBlock: (DBKVOSimpleBlock) block;
-(NSMutableArray*) getBlocksForKeyPath: (NSString*) keyPath;

@end
