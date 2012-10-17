//
//  DTDateFormatters.h
//  PassagewaysBoard
//
//  Created by Jonathan Nolen on 10/11/12.
//  Copyright (c) 2012 Passageways. All rights reserved.
//


#import <Foundation/Foundation.h>


//DateFormatter class that caches NSDateFormatters across all instances.
//subclass this to add a formatter.  example
/*
 -(NSString *)shortMonth{
    return [[self formatterForFormatString:@"MMM"] stringFromDate:self.date]; 
 }
*/

@interface DTDateFormatter : NSObject{
   
}

@property (nonatomic, strong) NSDate *date;

//Return a DTDateFormatter that will allow a date to be returned in different formats.
+(id)dateFormatterForDate:(NSDate *)date;

//internal helper method that creates an NSDateFormatter for the format string if it
//doesn't exist, otherwise returns a cached NSDateFormatter.
-(NSDateFormatter *)formatterForFormatString:(NSString *)format;

//clear out all of the cached formats across all instances... this is mainly meant for testing.
//doing thid often is dumb and will eat memory and performance.
-(void)resetFormats;


@end
