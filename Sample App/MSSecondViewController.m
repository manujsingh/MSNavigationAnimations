//
//  MSSecondViewController.m
//  MSNavigationAnimations
//
//  Created by Manuj Singh on 2015-03-26.
//  Copyright (c) 2015 Manuj Singh. All rights reserved.
//

#import "MSSecondViewController.h"
#import "MSPopViewControllerToLeft.h"

@interface MSSecondViewController () <UIGestureRecognizerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *panTransition;
@end

@implementation MSSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScreenEdgePanGestureRecognizer *gesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    gesture.delegate = self;
    gesture.edges = UIRectEdgeRight;
    [self.view addGestureRecognizer:gesture];
}
-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.delegate = self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)handlePan:(UIScreenEdgePanGestureRecognizer *)gesture{
    CGPoint point = [gesture translationInView:self.view.window];
    CGFloat percentage = -point.x/CGRectGetWidth([UIScreen mainScreen].bounds);
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            self.panTransition = [UIPercentDrivenInteractiveTransition new];
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case UIGestureRecognizerStateChanged:
            [self.panTransition updateInteractiveTransition:percentage];
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            if (percentage > 0.5)
                [self.panTransition finishInteractiveTransition];
            else
            {
                [self.panTransition cancelInteractiveTransition];
            }
            self.panTransition = nil;
            break;
        default:
            break;
    }
}

#pragma mark - UINavigationControllerDelegate
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPop)
    {
        if ([fromVC isKindOfClass:[MSSecondViewController class]])
        {
            return [MSPopViewControllerToLeft new];
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
