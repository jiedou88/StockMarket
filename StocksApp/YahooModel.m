//
//  YahooModel.m
//  StocksApp
//
//  Created by administrator on 8/10/18.
//  Copyright © 2018 administrator. All rights reserved.
//

#import "YahooModel.h"

@implementation YahooModel

-(void)searchYahooForUserText:(NSString *)text{
    self.myQueue = dispatch_queue_create("MyQueue", NULL);
    NSError* error = nil;
    
    dispatch_async(self.myQueue, ^{
        NSString* stringUrl = [NSString stringWithFormat:@"http://d.yimg.com/autoc.finance.yahoo.com/autoc?query=%@&region=1&lang=en&callback=YAHOO.Finance.SymbolSuggest.ssCallback", text];
        
        NSURL* url = [NSURL URLWithString:stringUrl];
        
        NSString* jsonFromUrl = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        
        if(error == nil){
            // get rid of first 39 and last 2 chars of returned json
            jsonFromUrl = [jsonFromUrl substringFromIndex:39];
            jsonFromUrl = [jsonFromUrl substringToIndex:jsonFromUrl.length-2];
            
            // convert json to ns dictionary
            NSData* data = [jsonFromUrl dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary* jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSArray* result = [jsonDictionary valueForKeyPath:@"ResultSet.Result"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate yahooDidFinishWithResults:result];
            });
        }
    });
}

@end
