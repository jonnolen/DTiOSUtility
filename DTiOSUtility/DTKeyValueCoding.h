//
//  DTKeyValueCoding.h
//  PassagewaysBoard
//
//  Created by Jonathan Nolen on 10/10/12.
//  Copyright (c) 2012 Passageways. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DTKeyValueCoding <NSObject>
@required
-(id)valueForKey:(NSString *)key;
-(id)valueForKeyPath:(NSString *)keypath;

@end
