//  DTKeyValueCoding.h
//  Created by Jonathan Nolen on 10/10/12.

#import <Foundation/Foundation.h>

@protocol DTKeyValueCoding <NSObject>
@required
-(id)valueForKey:(NSString *)key;
-(id)valueForKeyPath:(NSString *)keypath;

@end
