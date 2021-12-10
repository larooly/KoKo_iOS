//
//  ViewController.h
//  kkk
//
//  Created by active on 2020/05/19.
//  Copyright © 2020 activeKJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    NSTimer *loadingTimer;
    int count;
}
@property (weak, nonatomic) IBOutlet UIImageView *LogoJPG;
@property (weak, nonatomic) IBOutlet UILabel *MainTitle;


@end

