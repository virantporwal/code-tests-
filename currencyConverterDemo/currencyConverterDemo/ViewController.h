//
//  ViewController.h
//  currencyConverterDemo
//
//  Created by virant on 9/21/15.
//  Copyright (c) 2015 virant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mainProxyRequest.h"
#import "NIDropDown.h"


@interface ViewController : UIViewController <currencyProxyDelegate,NIDropDownDelegate>

{
     NIDropDown *dropDown;

}


@end

