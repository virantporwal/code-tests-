//
//  mainProxyRequest.m
//  currencyConverterDemo
//
//  Created by virant on 9/21/15.
//  Copyright (c) 2015 virant. All rights reserved.
//

#import "mainProxyRequest.h"

@implementation mainProxyRequest 

@synthesize currencyProxyDelegate;

#define BASEURLString @"https://raw.githubusercontent.com/mydrive/code-tests/master/iOS-currency-exchange-rates/rates.json"


- (void)getRequestDataWithURL
{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:BASEURLString];
    
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithURL:url
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                        if(error == nil)
                                                        {
                                                            //NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                                            
                                                            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                            
                                                            NSArray *dataArray = [json valueForKey:@"conversions"];
                                                            
                                                            if ([self.currencyProxyDelegate respondsToSelector:@selector(receivedCurrencyDataDetails:)]) {
                                                                [self.currencyProxyDelegate receivedCurrencyDataDetails:dataArray];
                                                            }
                                                            
                                                            NSLog(@"Data = %@",dataArray);
                                                        }
                                                        
                                                    }];
    
    [dataTask resume];
    

}


@end
