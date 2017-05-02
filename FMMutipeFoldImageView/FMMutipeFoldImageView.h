//
//  FMMutipeFoldImageView.h
//  FMMutipeFoldImage
//
//  Created by fm on 2017/5/2.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FMMutipeFoldImageType) {
    FMMutipeFoldImageTypeOpen = 1<<0,
    FMMutipeFoldImageTypeClose = 1<<1
};

@interface FMMutipeFoldImageView : UIControl

- (void)setFoldImage:(UIImage *)image;
- (void)foldImage;
- (void)resetImage;

@end
