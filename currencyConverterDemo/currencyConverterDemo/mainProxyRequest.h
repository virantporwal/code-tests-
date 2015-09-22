//
//  mainProxyRequest.h
//  currencyConverterDemo
//
//  Created by virant on 9/21/15.
//  Copyright (c) 2015 virant. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol currencyProxyDelegate <NSObject>

@optional

- (void)receivedCurrencyDataDetails:(NSArray*)arrayDetail;
- (void)failedWithRequest;

@end

@interface mainProxyRequest : NSObject <NSURLSessionDataDelegate>

@property(nonatomic,weak)id <currencyProxyDelegate> currencyProxyDelegate;
- (void)getRequestDataWithURL;

@end
