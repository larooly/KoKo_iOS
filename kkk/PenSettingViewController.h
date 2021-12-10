//
//  PenSettingViewController.h
//  kkk
//
//  Created by active on 2020/05/27.
//  Copyright © 2020 activeKJS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PenSettingViewController : UIViewController
- (IBAction)ClosedChangesetting:(id)sender;
- (IBAction)ClosedoNothing:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *showNowPen;
@property (weak, nonatomic) IBOutlet UISlider *PenSizing;
- (IBAction)sizesliderMove:(id)sender;
- (IBAction)redsliderMove:(id)sender;
- (IBAction)greensliderMove:(id)sender;
- (IBAction)bluesliderMove:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *memoheight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *memowidth;
@property (weak, nonatomic) IBOutlet UISlider *redslider;
@property (weak, nonatomic) IBOutlet UISlider *greenslider;
@property (weak, nonatomic) IBOutlet UISlider *blueslider;
@property (weak, nonatomic) IBOutlet UISlider *sizeslider;


@end

NS_ASSUME_NONNULL_END
