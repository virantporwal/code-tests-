//
//  ViewController.m
//  currencyConverterDemo
//
//  Created by virant on 9/21/15.
//  Copyright (c) 2015 virant. All rights reserved.
//

#import "ViewController.h"
#import "mainProxyRequest.h"
#import "NIDropDown.h"
#import "MBProgressHUD.h"

@interface ViewController ()
{
    BOOL IsDropDownOpen;
    MBProgressHUD *hud;
}
@property (nonatomic, strong) IBOutlet UIButton *fromButton;
@property (nonatomic, strong) IBOutlet UIButton *toButton;
@property (nonatomic, strong) NSArray *mainDAtaArray;
@property (nonatomic, strong)NSArray *currencyUniq;
@property (nonatomic, strong)mainProxyRequest *mainRequestObject;
@property (nonatomic, strong)IBOutlet UITextField *convertedCurrencyField;
@property (nonatomic, strong)IBOutlet UITextField *currencyTextField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    hud = [[MBProgressHUD alloc]init];
    IsDropDownOpen = YES;
    _mainDAtaArray = [[NSArray alloc]init];
    _mainRequestObject = [[mainProxyRequest alloc]init];
    //[hud show:YES];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    _mainRequestObject.currencyProxyDelegate = self;
    [_mainRequestObject getRequestDataWithURL];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Mark  - IBAction Button Methods

-(IBAction)convertButtonClicked:(id)sender
{
    if ([self.fromButton.currentTitle isEqualToString:@"From"] ||  [self.toButton.currentTitle isEqualToString:@"To"] ||  !self.currencyTextField.text.length>0) {
        return;
    }
    
    NSString *fromStr = self.fromButton.currentTitle;
    NSString *toStr = self.toButton.currentTitle;
    
    
    for (NSDictionary *currencyDic in _mainDAtaArray) {
        
        //NSLog(@"main = %@",currencyDic );
        if ([[currencyDic valueForKey:@"from"] isEqualToString:fromStr]) {
            if ([[currencyDic valueForKey:@"to"] isEqualToString:toStr]) {
                NSLog(@"value is present");
                
                self.convertedCurrencyField.text = [NSString stringWithFormat:@"%f",[self.currencyTextField.text floatValue] * [[currencyDic valueForKey:@"rate"] floatValue] ];
                return;
            }else{self.convertedCurrencyField.text = @"";}
        }else if ([[currencyDic valueForKey:@"from"] isEqualToString:toStr]){
        
            if ([[currencyDic valueForKey:@"to"] isEqualToString:fromStr]) {
                
                self.convertedCurrencyField.text = [NSString stringWithFormat:@"%f",[self.currencyTextField.text floatValue] / [[currencyDic valueForKey:@"rate"] floatValue] ];
                return;

            }else{
            
            self.convertedCurrencyField.text = @"";
            }
        
        }else{
             self.convertedCurrencyField.text = @"";
            //NSLog(@"value is (A)not present");

        }
        
    }
    
    

}
- (IBAction)selectClicked:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    arr = _currencyUniq;
    if(IsDropDownOpen) {
        IsDropDownOpen = NO;
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showdropDown:sender height: &f array: _currencyUniq imagArray:nil directioin:@"down"];
        dropDown.delegate = self;
    }
    else {
        IsDropDownOpen = YES;
        [dropDown hideDropDown:sender];
        
    }
}

#pragma Mark - NIDropDownDelegate

- (void) niDropDownDelegateMethod: (NIDropDown *) sender{
    
    IsDropDownOpen = YES;
}

#pragma  Mark - Web Services Response 

- (void)receivedCurrencyDataDetails:(NSArray*)arrayDetail{
   [MBProgressHUD hideHUDForView:self.view animated:YES];
    _mainDAtaArray = arrayDetail;
    NSMutableArray *totalCurrency = [NSMutableArray new];
   
    for (int  i = 0;i<_mainDAtaArray.count; i++) {
        
        NSString *valueFrom = [[_mainDAtaArray objectAtIndex:i]valueForKey:@"from"];
      [totalCurrency addObject:valueFrom ];
        NSString *valueto = [[_mainDAtaArray objectAtIndex:i]valueForKey:@"to"];
        [totalCurrency addObject:valueto ];
    }
    _currencyUniq = totalCurrency;
    
    _currencyUniq =  [[NSSet setWithArray:_currencyUniq] allObjects];
  
    NSLog(@"main = %@", _currencyUniq);
    
}
- (void)failedWithRequest{


}
@end
