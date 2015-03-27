//
//  ViewController.m
//  MSNavigationAnimations
//
//  Created by Manuj Singh on 2015-03-26.
//  Copyright (c) 2015 Manuj Singh. All rights reserved.
//

#import "MSFirstViewController.h"
#import "MSSecondViewController.h"
#import "MSPushViewControllerFromLeft.h"
#import "MSPopViewControllerToLeft.h"

@interface MSFirstViewController () <UINavigationControllerDelegate>

@end

@implementation MSFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UINavigationControllerDelegate
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush)
    {
        if ([toVC isKindOfClass:[MSSecondViewController class]])
        {
            return [MSPushViewControllerFromLeft new];
        }
    }
    else if (operation == UINavigationControllerOperationPop)
    {
        if ([fromVC isKindOfClass:[MSSecondViewController class]])
        {
            return [MSPopViewControllerToLeft new];
        }
    }
    return nil;
}

@end
