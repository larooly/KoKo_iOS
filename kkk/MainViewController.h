//
//  MainViewController.h
//  kkk
//
//  Created by active on 2020/05/27.
//  Copyright © 2020 activeKJS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    NSTimer *UpdatePenSetting;
    UIImagePickerController *imagePickerController;
}
- (IBAction)TrashCanClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *MainCanvaslo;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *ShowNowPenSet;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *PenSeet;
//@property (weak, nonatomic) IBOutlet UIImageView *TestImageAlbum;
- (IBAction)ChangePenandEraser:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonPenEraser;

- (IBAction)Sharebutton:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *sendTableView;
@property(strong,nonatomic)NSArray *SendData;
@end

NS_ASSUME_NONNULL_END
