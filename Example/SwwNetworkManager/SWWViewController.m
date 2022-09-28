//
//  SWWViewController.m
//  SwwNetworkManager
//
//  Created by bhshuangww on 09/28/2022.
//  Copyright (c) 2022 bhshuangww. All rights reserved.
//

#import "SWWViewController.h"
#import <SwwNetworkManager.h>

@interface SWWViewController ()

@end

@implementation SWWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [SwwNetworkManager requestWithRequstType:SwwRequestType_Get requestUrl:@"https://www.baidu.com" params:nil success:^(id  _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
