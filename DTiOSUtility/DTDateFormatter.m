//
//  DTDateFormatters.m
//  PassagewaysBoard
//
//  Created by Jonathan Nolen on 10/11/12.
//  Copyright (c) 2012 Passageways. All rights reserved.
//

#import "DTDateFormatter.h"

@interface DTDateFormatter()
-(id)initWithDate:(NSDate *)date;
@end

@implementation DTDateFormatter
@synthesize date;

static NSMutableDictionary *formats;
static dispatch_once_t once;

-(NSMutableDictionary *)createEmptyDictionary{
    return [NSMutableDictionary dictionaryWithCapacity:4];
}

-(void)resetFormats{
    formats= nil;
    once = 0; //dispatch once will fire on this after this is zeroed.
}
-(NSDateFormatter *)formatterForFormatString:(NSString *)format{

    dispatch_once(&once, ^{
        formats = [self createEmptyDictionary];
    });
    
    NSDateFormatter *result;
    
    result = [formats objectForKey:format];
    
    if(!result){
        result = [NSDateFormatter new];
        result.dateFormat = format;
        [formats setObject:result forKey:format];
    }
    return result;
}

+(DTDateFormatter *)dateFormatterForDate:(NSDate *)date{
    return [[self alloc] initWithDate:date];
}

-(id)initWithDate:(NSDate *)inDate{
    self = [super init];
    if(self){
        self.date = inDate;
    }
    return self;
}


@end
