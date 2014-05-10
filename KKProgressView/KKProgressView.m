//
//  KKProgressView.m
//  KKProgressView
//
//  Created by Kun on 14-5-10.
//  Copyright (c) 2014年 Kun. All rights reserved.
//

#import "KKProgressView.h"

#define Tracking_Color [UIColor colorWithRed:0 green:120/255.0 blue:251/255.0 alpha:1]
#define Background_Color         [UIColor colorWithRed:183/255.0 green:183/255.0 blue:183/255.0 alpha:1];

@interface KKProgressView()
{
    UIImageView *_trackView;

}

@end

@implementation KKProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initializer];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self initializer];
}

- (void)initializer{
	_trackView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0 , self.progress *CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
	_trackView.backgroundColor = Tracking_Color;
    [self addSubview:_trackView];
    self.backgroundColor = Background_Color;
}

- (void)dashedImage{
    UIGraphicsBeginImageContext(_trackView.frame.size);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapButt);
    CGFloat lengths[] = {1,1};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextBeginPath(line);
    CGContextSetStrokeColorWithColor(line, Tracking_Color.CGColor);
    CGContextSetLineWidth(line, 2);
    CGContextSetLineDash(line, 0, lengths, 2);
    CGContextMoveToPoint(line, 0, 0);
    CGContextAddLineToPoint(line, CGRectGetMaxX(self.bounds), CGRectGetMinY(self.bounds));
    CGContextStrokePath(line);
    _trackView.image = UIGraphicsGetImageFromCurrentImageContext();
}

-(void)updateLine{
    
    // Important, otherwise we will be adding multiple sub layers
    if ([[[self layer] sublayers] objectAtIndex:0])
    {
        self.layer.sublayers = nil;
    }
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:self.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [shapeLayer setStrokeColor:[[UIColor blackColor] CGColor]];
    [shapeLayer setLineWidth:3.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:10],
      [NSNumber numberWithInt:5],nil]];
    
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0,0);
    CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(self.bounds), CGRectGetMinY(self.bounds));
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    [[self layer] addSublayer:shapeLayer];
}

- (void)setProgress:(CGFloat)progress{
    _progress = progress >= 1 ? 1: progress;
    CGRect frame = _trackView.frame;
    frame.size.width = _progress * CGRectGetWidth(self.frame);
    _trackView.frame = frame;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
