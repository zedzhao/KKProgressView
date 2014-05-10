//
//  KKViewController.m
//  KKProgressView
//
//  Created by Kun on 14-5-10.
//  Copyright (c) 2014年 Kun. All rights reserved.
//

#import "KKViewController.h"
#import "KKProgressView.h"

@interface KKViewController (){
    CGFloat progress;
}
@property (weak, nonatomic) IBOutlet KKProgressView *kkProgressView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation KKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.kkProgressView.progress = 1;
//    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateView) userInfo:nil repeats:YES];
}

-(void)updateView{
 	progress += 0.2;
    self.progressView.progress = progress;
    self.kkProgressView.progress = progress;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
