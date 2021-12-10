//
//  CanvasViewController.h
//  kkk
//
//  Created by active on 2020/05/27.
//  Copyright © 2020 activeKJS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CanvasViewController : UIViewController{
    float backX;
    float backY;
    float nowX;
    float nowY;
    NSTimer *ClearNow;
   
}
@property (nonatomic,assign) float newRed;
@property (nonatomic,assign) float newGreen;
@property (nonatomic,assign) float newBlue;
@property (nonatomic,assign) float newPensize;
@property (strong, nonatomic) IBOutlet UIView *totalview;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImage;
- (void)Testremove;


@end

NS_ASSUME_NONNULL_END
