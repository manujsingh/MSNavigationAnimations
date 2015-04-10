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

@interface MSFirstViewController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *panTransition;
@end

@implementation MSFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIScreenEdgePanGestureRecognizer *gesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    gesture.delegate = self;
    gesture.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:gesture];
}

-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.delegate = self;
}

-(void)handlePan:(UIScreenEdgePanGestureRecognizer *)gesture{
    CGPoint point = [gesture translationInView:self.view.window];
    CGFloat percentage = point.x/CGRectGetWidth([UIScreen mainScreen].bounds);
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            self.panTransition = [UIPercentDrivenInteractiveTransition new];
            [self performSegueWithIdentifier:@"showSecondScreen" sender:self];
            break;
        case UIGestureRecognizerStateChanged:
            [self.panTransition updateInteractiveTransition:percentage];
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            if (percentage > 0.5)
                [self.panTransition finishInteractiveTransition];
            else
                [self.panTransition cancelInteractiveTransition];
            self.panTransition = nil;
            break;
        default:
            break;
    }
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
    return nil;
}

-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    return self.panTransition;
}

#pragma mark - Gesture recognizer
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

@end
