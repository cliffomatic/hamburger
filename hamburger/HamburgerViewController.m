//
//  HamburgerViewController.m
//  hamburger
//
//  Created by Cliff Curry on 7/10/14.
//  Copyright (c) 2014 Cliff Curry. All rights reserved.
//

#import "HamburgerViewController.h"
#import "FeedViewController.h"
#import "MenuViewController.h"

@interface HamburgerViewController ()
- (IBAction)onPanHamburger:(UIPanGestureRecognizer *)sender;
@property (strong,nonatomic) UIView *feedView;
@property (strong,nonatomic) UIView *menuView;


@end

@implementation HamburgerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIViewController *viewController = self.viewControllers[0];
    self.feedView = viewController.view;
    
    UIViewController *viewController2 = self.viewControllers[1];
    self.menuView = viewController2.view;
    
    [self.view addSubview:self.menuView];

    [self.view addSubview:self.feedView];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onPanHamburger:(UIPanGestureRecognizer *)sender {
    CGPoint location = [sender locationInView:self.view];
    CGPoint translation = [sender translationInView:self.view];
    CGPoint velocity = [sender velocityInView:self.view];
    
    static CGRect originalFrame;
    
    
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        NSLog(@"Panning began!");
        originalFrame = sender.view.frame;

        
    }
    else if (sender.state == UIGestureRecognizerStateChanged) {
        NSLog(@"I'm panning!");
        

        
        if (!((originalFrame.origin.x == 0) && (velocity.x <= 0))) {
            self.feedView.frame = CGRectMake(originalFrame.origin.x + translation.x, originalFrame.origin.y, originalFrame.size.width, originalFrame.size.height);
        }
        
        
        
    }
    else if (sender.state == UIGestureRecognizerStateEnded) {
        NSLog(@"Panning ended");
        
        if(velocity.x >= 0){
            [self openBurger];
        }
        
        else{
            [self closeBurger];
        }
        
    }
    
    
}

-(void) openBurger {
    
    [UIView animateWithDuration:.5 animations:^{
        self.feedView.frame = CGRectMake(280, 0, self.feedView.frame.size.width, self.feedView.frame.size.height);
    }];

}

-(void) closeBurger {
    
    [UIView animateWithDuration:.5 animations:^{
        self.feedView.frame = CGRectMake(0, 0, self.feedView.frame.size.width, self.feedView.frame.size.height);
    }];
    
}

@end
