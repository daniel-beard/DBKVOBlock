DBKVOBlock
==========
[![Build Status](https://travis-ci.org/daniel-beard/DBKVOBlock.png?branch=master)](https://travis-ci.org/daniel-beard/DBKVOBlock)

* DBKVOBlock is an attempt to simplify the use of Key Value Observing by using blocks instead of the clunky built in way.
* DBKVOBlock also automatically unregisters KVO notifications for objects that are deallocated.
* You can set multiple actions for a single keyPath.

### Registering for KVO notifications

There are several ways that you can use the class, the first is using the `sharedManager`:

    id objectToObserve; // assum initialized
    [[DBKVOBlock sharedManager] observeObject: objectToObserve withKeyPath: @"textValue" withAction:^{
        NSLog(@"Textvalue changed!");
    }];

The other way is a category on `NSObject` that forwards relevant calls to the sharedManager:

    id objectToObserve; // assume initialized
    [objectToObserve observeKeyPath: @"textValue" withAction: ^{
        NSLog(@"Textvalue changed!");
    }];

### Unregistering notifications

You can set the object that is being observed to `nil` and DBKVOBlock will automatically unregister notifications.

Or you can use one of the following `sharedManager` methods:

    //Remove all notifications for an object
    [[DBKVOBlock sharedManager] removeObserverForObject: objectToObserve];

    //Remove all notifications that match a keyPath on an object
    [[DBKVOBlock sharedManager] removeObserverForObject: objectToObserve withKeyPath: keyPath];
    
    //Remove all notifications for all objects and all keyPaths
    [[DBKVOBlock sharedManager] removeAllObservers];
    
### Including in your project

* Clone the repository locally
* Copy the contents of the `DBKVOBlock` into your project and add to your target
* You should now have the following files in your project:
 * `DBKVOBlock.h` + `DBKVOBlock.m`
 * `DBKVOObject.h` + `DBKVOObject.m`
 * `NSObject+DBKVOBlock.h` + `NSObject+DBKVOBlock.m`
* Import the `DBKVOBlock.h` file in the class you want to use it. `#import "DBKVOBlock.h"` 

### Licence + Notes

Copyright (C) 2013 Daniel Beard http://danielbeard.wordpress.com
 
Distributed under [MIT License](http://opensource.org/licenses/mit-license.php)
