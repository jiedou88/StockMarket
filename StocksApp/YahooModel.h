//
//  YahooModel.h
//  StocksApp
//
//  Created by administrator on 8/10/18.
//  Copyright © 2018 administrator. All rights reserved.
//

// Call Api
#import <Foundation/Foundation.h>

@protocol yahooSearchDelegate
@required
-(void)yahooDidFinishWithResults :(NSArray*)YahooResults;
@end

@interface YahooModel : NSObject


@property (nonatomic) dispatch_queue_t myQueue;
@property (nonatomic) id<yahooSearchDelegate> delegate;
-(void)searchYahooForUserText :(NSString*)text;

@end
