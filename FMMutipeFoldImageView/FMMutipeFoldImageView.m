//
//  FMMutipeFoldImageView.m
//  FMMutipeFoldImage
//
//  Created by fm on 2017/5/2.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "FMMutipeFoldImageView.h"
#import "Masonry.h"
#import <math.h>

@interface FMMutipeFoldImageView()
{
    BOOL isFolding;
    CGFloat W_img;
    CGFloat H_img;
    CGFloat H_Img_part;
}

@end

@implementation FMMutipeFoldImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        W_img = frame.size.width;
        H_img = frame.size.height;
        H_Img_part = H_img/4.f;
        [self configUI];
    }
    return self;
}

#pragma mark - Private methods
- (void)configUI
{
    self.backgroundColor = [UIColor redColor];
    for (NSInteger i = 0; i < 4; i++) {
        UIImageView *image = [[UIImageView alloc] init];
        image.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.f green:arc4random_uniform(255)/255.f blue:arc4random_uniform(255)/255.f alpha:1];
        image.layer.contentsRect = CGRectMake(0, 0.25*i, 1, 0.25);
        image.layer.anchorPoint = CGPointMake(0.5, i%2);
        image.frame = CGRectMake(0, H_Img_part*i, W_img, H_Img_part);
        image.tag = i+100;
        [self addSubview:image];
    }
}

- (CATransform3D)config3DTransformWithRotateAngle:(double)angle andPositionY:(double)y
{
    CATransform3D transform = CATransform3DIdentity;
    // 立体
    transform.m34 = -1/1000.0;
    // 旋转
    CATransform3D rotateTransform = CATransform3DRotate(transform, M_PI*angle/180.f, 1, 0, 0);
    // 移动(这里的y坐标是平面移动的的距离,我们要把他转换成3D移动的距离.这是关键,没有它图片就没办法很好地对接。)
    CATransform3D moveTransform = CATransform3DMakeAffineTransform(CGAffineTransformMakeTranslation(0, y));
    // 合并
    CATransform3D concatTransform = CATransform3DConcat(rotateTransform, moveTransform);
    return concatTransform;
}

#pragma mark - Public methods
- (void)setFoldImage:(UIImage *)image
{
    for (NSInteger i = 0; i < 4; i++) {
        UIImageView *imageView = [self viewWithTag:100+i];
        [imageView setImage:image];
        if (i%2 == 0) {
            UIView *shadowView = [[UIView alloc] initWithFrame:imageView.bounds];
            shadowView.backgroundColor = [UIColor blackColor];
            shadowView.alpha = 0.0;
            shadowView.tag = 200+i;
            [imageView addSubview:shadowView];
        }
    }
}

- (void)foldImage
{
    if(!isFolding) {
        isFolding = YES;
        [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            // 阴影显示
            for (NSInteger i = 0; i < 4; i++) {
                if (i%2 == 0) {
                    UIView *shadowView = [self viewWithTag:200+i];
                    shadowView.alpha = 0.2;
                }
            }
            // 折叠
            for (NSInteger i = 0; i < 4; i++) {
                UIImageView *imageView = [self viewWithTag:100+i];
                if (i == 0) {
                    imageView.layer.transform = [self config3DTransformWithRotateAngle:(i%2==0?-45.0:45.0) andPositionY:0];
                } else if (i == 1) {
                    imageView.layer.transform = [self config3DTransformWithRotateAngle:(i%2==0?-45.0:45.0) andPositionY:0];
                } else if (i == 2) {
                    imageView.layer.transform = [self config3DTransformWithRotateAngle:(i%2==0?-45.0:45.0) andPositionY:0];
                } else if ( i == 3) {
                    imageView.layer.transform = [self config3DTransformWithRotateAngle:(i%2==0?-45.0:45.0) andPositionY:0];
                }
            }
            // 0,
        } completion:^(BOOL finished) {
            if(finished) {
                isFolding = NO;
            }
        }];
    }
}

- (void)resetImage
{
    isFolding = NO;
    [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        // 阴影隐藏
        for (NSInteger i = 0; i < 4; i++) {
            if (i%2 == 0) {
                UIView *shadowView = [self viewWithTag:200+i];
                shadowView.alpha = 0.0;
            }
        }
        // 图片恢复原样
        for (NSInteger i = 0; i < 4; i++) {
            UIImageView *imageView = [self viewWithTag:100+i];
            imageView.layer.transform = CATransform3DIdentity;
        }
    } completion:^(BOOL finished) {
                         
    }];
}

#pragma mark - getter & setter

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
