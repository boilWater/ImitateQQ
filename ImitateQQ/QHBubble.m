//
//  QHBubble.m
//  QQBubble
//
//  Created by chen on 14-12-29.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "QHBubble.h"
#import "QHSlimeView.h"
#import "QHShapeLayerView.h"

#define kKGSDK_TIME_ANIMATE_DURATION 0.2

@interface QHBubble ()
{
    UIView *_bgBubbleV;
    UIView *_bubbleV;
    UILabel *_showL;
    CGRect _frame;
    CGSize _size;
    CGPoint _center;
    
    CGAffineTransform _transform;
    float _distance;
    
//    QHSlimeView *_slimeV;
    QHShapeLayerView *_shapeLayerV;
}

@end

@implementation QHBubble

- (instancetype)initWithRadius:(CGFloat)radius color:(UIColor *)color content:(NSString *)title font:(UIFont *)font forSuper:(UIView *)superView
{
    CGRect frame = CGRectMake(superView.frame.size.width - radius*1.5, (superView.frame.size.height - radius)/2, radius, radius);
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = NO;
        
        _bubbleV = [[UIView alloc] initWithFrame:self.bounds];
        _bubbleV.layer.cornerRadius = frame.size.width/2;
//        _bubbleV.layer.borderColor = [UIColor greenColor].CGColor;
        _bubbleV.layer.borderWidth = 0;
        _bubbleV.userInteractionEnabled = YES;
        if (color != nil)
            _bubbleV.backgroundColor = color;
        else
            _bubbleV.backgroundColor = [UIColor orangeColor];
        
        _bgBubbleV = [[UIView alloc] initWithFrame:_bubbleV.bounds];
        _bgBubbleV.backgroundColor = _bubbleV.backgroundColor;
        _bgBubbleV.layer.cornerRadius = frame.size.width/2;
        _bgBubbleV.layer.borderColor = [UIColor greenColor].CGColor;
        _bgBubbleV.layer.borderWidth = 0;
        [self addSubview:_bgBubbleV];
        
        [self addSubview:_bubbleV];
        
        _showL = [[UILabel alloc] initWithFrame:self.bounds];
        _showL.textColor = [UIColor whiteColor];
        _showL.backgroundColor = [UIColor clearColor];
        _showL.textAlignment = NSTextAlignmentCenter;
        _showL.font = font;
        _showL.text = title;
        [_bubbleV addSubview:_showL];
        
        [superView addSubview:self];
        
        _frame = self.frame;
        _size = CGSizeMake(_frame.size.width*3.5, _frame.size.height*3.5);
        _center = CGPointMake(_frame.size.width/2, _frame.size.height/2);
        
        _transform = _bubbleV.transform;
        
        _distance = sqrtf(powf(_size.width, 2) + powf(_size.height, 2));
        
//        _slimeV = [[QHSlimeView alloc] initWithFrame:CGRectMake(-_size.width + _frame.size.width/2, -_size.height + _frame.size.width/2, _size.width*2, _size.height*2) bgColor:_bubbleV.backgroundColor];
//        _slimeV.clipsToBounds = NO;
//        [self insertSubview:_slimeV belowSubview:_bgBubbleV];
        
        _shapeLayerV = [[QHShapeLayerView alloc] initWithFrame:_bubbleV.frame];
        [self insertSubview:_shapeLayerV belowSubview:_bgBubbleV];
    }
    return self;
}

- (void)setValueForBubble:(NSString *)content
{
    _showL.text = content;
}

- (NSString *)getValueForBubble
{
    return _showL.text;
}

- (void)show
{
    _bubbleV.transform = CGAffineTransformScale(_transform, 0.f, 0.f);
    [UIView animateWithDuration:kKGSDK_TIME_ANIMATE_DURATION animations:^
     {
         _bubbleV.transform = CGAffineTransformScale(_transform, 1.f, 1.f);
     }];
}

- (void)hidden
{
    [self removeFromSuperview];
}

#pragma mark - touch

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    _bubbleV.transform = CGAffineTransformScale(_transform, 1.1f, 1.1f);
    if (_shapeLayerV != nil)
    {
        _bgBubbleV.hidden = NO;
        _shapeLayerV.hidden = NO;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    CGPoint movedPT = [[touches anyObject] locationInView:self];
    _bubbleV.center = movedPT;
//    [self.delegate movePoint:movedPT];
    if (((_bubbleV.center.x - _center.x > _size.width) || (_bubbleV.center.y - _center.y > _size.height)) ||
        ((_bubbleV.center.x - _center.x < -_size.width) || (_bubbleV.center.y - _center.y < -_size.height)))
    {
        _bgBubbleV.transform = CGAffineTransformScale(_transform, 0, 0);
//        if (_bubbleV.layer.borderWidth == 0)
//            _bubbleV.layer.borderWidth = 2;
        
        if (_shapeLayerV != nil)
        {
            CGPoint pS = [_bgBubbleV convertPoint:_shapeLayerV.center toView:_shapeLayerV];
            [_shapeLayerV drawQHPicture:pS point2:pS point3:pS point4:pS];
            _shapeLayerV.hidden = YES;
        }
    }else
    {
        float distance = sqrtf(powf(_bubbleV.center.x - _center.x, 2) + powf(_bubbleV.center.y - _center.y, 2));
        float d = (_distance - distance)/_distance;
        _bgBubbleV.transform = CGAffineTransformScale(_transform, d, d);
        if (_shapeLayerV != nil)
        {
            if (_shapeLayerV.hidden)
                _shapeLayerV.hidden = NO;
            CGPoint pS = [_bgBubbleV convertPoint:_shapeLayerV.center toView:_shapeLayerV];
            CGPoint pE = [[touches anyObject] locationInView:_shapeLayerV];
            float xL = fabs(pE.x - pS.x);
            float yL = fabs(pE.y - pS.y);
            float zL = sqrtf(powf(xL, 2) + powf(yL, 2));
            float x = _bgBubbleV.frame.size.width/2/(zL/yL);
            float y = _bgBubbleV.frame.size.height/2/(zL/xL);
            float x1 = _bubbleV.frame.size.width/2/(zL/yL);
            float y1 = _bubbleV.frame.size.height/2/(zL/xL);
            
            CGPoint p1 = CGPointZero;
            CGPoint p4 = CGPointZero;
            CGPoint p2 = CGPointZero;
            CGPoint p3 = CGPointZero;
            float xx = pE.x - pS.x;
            float yy = pE.y - pS.y;
            if (xx > 0 && yy < 0)
            {
                p1 = CGPointMake(pS.x + x, pS.y + y);
                p4 = CGPointMake(pS.x - x, pS.y - y);
                p2 = CGPointMake(pE.x + x1, pE.y + y1);
                p3 = CGPointMake(pE.x - x1, pE.y - y1);
            }else if (xx < 0 && yy < 0)
            {
                p1 = CGPointMake(pS.x + x, pS.y - y);
                p4 = CGPointMake(pS.x - x, pS.y + y);
                p2 = CGPointMake(pE.x + x1, pE.y - y1);
                p3 = CGPointMake(pE.x - x1, pE.y + y1);
            }else if (xx < 0 && yy > 0)
            {
                p1 = CGPointMake(pS.x - x, pS.y - y);
                p4 = CGPointMake(pS.x + x, pS.y + y);
                p2 = CGPointMake(pE.x - x1, pE.y - y1);
                p3 = CGPointMake(pE.x + x1, pE.y + y1);
            }else if (xx > 0 && yy > 0)
            {
                p1 = CGPointMake(pS.x - x, pS.y + y);
                p4 = CGPointMake(pS.x + x, pS.y - y);
                p2 = CGPointMake(pE.x - x1, pE.y + y1);
                p3 = CGPointMake(pE.x + x1, pE.y - y1);
            }
            
//            [_slimeV drawQHPicture:p1 point2:p2 point3:p3 point4:p4];
            [_shapeLayerV drawQHPicture:p1 point2:p2 point3:p3 point4:p4];
        }
        
//        if (_bubbleV.layer.borderWidth == 2)
//            _bubbleV.layer.borderWidth = 0;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if (((_bubbleV.center.x - _center.x > _size.width) || (_bubbleV.center.y - _center.y > _size.height)) ||
        ((_bubbleV.center.x - _center.x < -_size.width) || (_bubbleV.center.y - _center.y < -_size.height)))
    {
        if ([self.delegate respondsToSelector:@selector(removeBubble:)])
        {
            [self.delegate removeBubble:self];
        }
    }else
    {
        _bubbleV.transform = CGAffineTransformIdentity;
        _bgBubbleV.hidden = YES;
        [UIView animateWithDuration:kKGSDK_TIME_ANIMATE_DURATION animations:^
         {
             _bubbleV.center = _center;
             
             if (_shapeLayerV != nil)
             {
                 CGPoint pS = [_bgBubbleV convertPoint:_shapeLayerV.center toView:_shapeLayerV];
                 [_shapeLayerV drawQHPicture:pS point2:pS point3:pS point4:pS];
             }
         }completion:^(BOOL finished)
         {
             CGPoint pS = [_bgBubbleV convertPoint:_shapeLayerV.center toView:_shapeLayerV];
             CGPoint pE = [[touches anyObject] locationInView:_shapeLayerV];
             float xL = fabs(pE.x - pS.x);
             float yL = fabs(pE.y - pS.y);
             float zL = sqrtf(powf(xL, 2) + powf(yL, 2));
             float x1 = _bubbleV.frame.size.width/2/(zL/yL);
             float y1 = _bubbleV.frame.size.height/2/(zL/xL);
             
             float xx = pE.x - pS.x;
             float yy = pE.y - pS.y;
             
             if (xx > 0 && yy < 0)
             {
                 [self shakeMenu:_bubbleV x:-y1 y:x1];
             }else if (xx < 0 && yy < 0)
             {
                 [self shakeMenu:_bubbleV x:y1 y:x1];
             }else if (xx < 0 && yy > 0)
             {
                 [self shakeMenu:_bubbleV x:y1 y:-x1];
             }else if (xx > 0 && yy > 0)
             {
                 [self shakeMenu:_bubbleV x:-y1 y:-x1];
             }
         }];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    _bubbleV.center = _center;
}

- (void)shakeMenu:(UIView *)view x:(float)xL y:(float)yL
{
    self.userInteractionEnabled = NO;
    
    CALayer *lbl = [view layer];
    CGPoint posLbl = [lbl position];
    CGPoint y = CGPointMake(posLbl.x+xL, posLbl.y+yL);
    CGPoint x = CGPointMake(posLbl.x-xL, posLbl.y-yL);
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.delegate = self;
    [animation setValue:@"toViewValue" forKey:@"toViewKey"];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.1];
    [animation setRepeatCount:1];
    [lbl addAnimation:animation forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([[anim valueForKey:@"toViewKey"] isEqualToString:@"toViewValue"])
    {
        dispatch_async(dispatch_get_main_queue(), ^
        {
            self.userInteractionEnabled = YES;
        });
    }
}

@end
