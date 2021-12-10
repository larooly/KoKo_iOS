//
//  MainViewController.m
//  kkk
//
//  Created by active on 2020/05/27.
//  Copyright © 2020 activeKJS. All rights reserved.
//

#import "MainViewController.h"
#import "CanvasViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    _ShowNowPenSet.title=@"10";
//    _ShowNowPenSet.tintColor =[UIColor colorWithRed:[[NSUserDefaults standardUserDefaults]floatForKey:@"newRed"] green:[[NSUserDefaults standardUserDefaults]floatForKey:@"newGreen"] blue:[[NSUserDefaults standardUserDefaults]floatForKey:@"newBlue"] alpha:1];
    UpdatePenSetting = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(UpdatePenSetting) userInfo:nil repeats:YES];
    //드랍다운 추가
    self.SendData = [[NSArray alloc] initWithObjects:@"회전",@"배경바꾸기",@"초기화",@"공유하기",@"저장하기",@"누르지마",@"취소",nil];
    self.sendTableView.delegate = self;
    self.sendTableView.dataSource = self;
    self.sendTableView.hidden=YES;
    self.sendTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    self.sendTableView.tableFooterView.hidden=YES;
   // self.sendTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //self.sendTableView.scrollEnabled=false;
    
    //앨범열기
    imagePickerController=[[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    
   // [[NSUserDefaults standardUserDefaults]boolForKey:@"PenChangeEraser"];
     [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"PenChangeEraser"];
    
    
}

#pragma mark - "드랍다운 만들기"
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.SendData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpletable=@"Simple";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:simpletable];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpletable];
    }
    cell.textLabel.text=[self.SendData objectAtIndex:indexPath.row];
    cell.textLabel.font=[UIFont fontWithName:@"Maplestory" size:15];
    cell.separatorInset=UIEdgeInsetsZero;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.sendTableView cellForRowAtIndexPath:indexPath];
  //  [self.penBtn setTitle:cell.textLabel.text];
  //  NSLog(cell.textLabel.text);
    if([cell.textLabel.text isEqual:@"공유하기"]){
//        NSArray* sharedObjects=[NSArray arrayWithObjects:self.captureView,  nil];
//             UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:sharedObjects applicationActivities:nil];
//             activityViewController.popoverPresentationController.sourceView = self.view;
//             [self presentViewController:activityViewController animated:YES completion:nil];
        
        NSMutableArray *activityItems= [NSMutableArray arrayWithObjects:self.captureView, nil];
        UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
        activityViewController.excludedActivityTypes = @[UIActivityTypePostToWeibo, UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll, UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr, UIActivityTypePostToVimeo, UIActivityTypePostToTencentWeibo, UIActivityTypeAirDrop];
        [self presentViewController:activityViewController animated:YES completion:nil];
        //둘다 되긴하는데 메모만 공유 가능 ->메세지는 안됨, 나머지는 확인 안해봄
        
        
            
    }
    else if([cell.textLabel.text isEqual:@"저장하기"]){
        self.sendTableView.hidden =YES;
        //uiImage형태로 가져옴
//        UIImage * im = [UIImage imageWithCGImage:(__bridge CGImageRef _Nonnull)(self.captureView)];
//        NSData * imdata =UIImagePNGRepresentation(im);
//        UIImage * imgPng =[UIImage imageWithData:imdata];
        
        
        UIImageWriteToSavedPhotosAlbum(self.captureView, nil, nil, nil);
       //저장 버튼 알림용
        
        UIAlertController * bigToast=[UIAlertController alertControllerWithTitle:@"저장" message:@"멋진 작품을 저장했어요!" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction * cancel =[UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            [bigToast dismissViewControllerAnimated:YES completion:nil];
        }];
        [bigToast addAction:cancel];
        [self presentViewController:bigToast animated:YES completion:nil];
        
    }
    else if([cell.textLabel.text isEqual:@"배경바꾸기"]){
        UIAlertController * toast=[UIAlertController alertControllerWithTitle:@"배경 선택" message:@"이미지를 가져올 방법을 선택해주세요." preferredStyle:UIAlertControllerStyleActionSheet];
        
        
        UIAlertAction * album =[UIAlertAction actionWithTitle:@"앨범" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            self->imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self->imagePickerController setAllowsEditing:YES];
            [self presentViewController:self->imagePickerController animated:YES completion:nil];
            //[toast dismissViewControllerAnimated:YES completion:nil];
        }];
        
        UIAlertAction * camera =[UIAlertAction actionWithTitle:@"카메라" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            self->imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:self->imagePickerController animated:YES completion:NULL];
            
        }];
        UIAlertAction * cancel =[UIAlertAction actionWithTitle:@"취소" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            [toast dismissViewControllerAnimated:YES completion:nil];
        }];
        [toast addAction:album];
        [toast addAction:camera];
        [toast addAction:cancel];
         [self presentViewController:toast animated:YES completion:nil];
        /*
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [imagePickerController setAllowsEditing:YES];
        [self presentViewController:imagePickerController animated:YES completion:nil];*/
        
    }
    else if([cell.textLabel.text isEqual:@"초기화"]){
         [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"AllClear"];
    }
    else if([cell.textLabel.text isEqual:@"회전"]){
         [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"RotateNow"];
    }
    
    else{
        NSLog(@"요기요");
         self.sendTableView.hidden=YES;
        
        
    }
    self.sendTableView.hidden =YES;
}


#pragma mark - "드랍다운 관련 기타등등"
-(UIImage *)captureView{
    CGRect rect =[self.MainCanvaslo bounds];
    UIGraphicsBeginImageContextWithOptions(rect.size,NO,0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.MainCanvaslo.layer renderInContext:context];
    UIImage *image= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

   UIImage *pickedImage = info[UIImagePickerControllerOriginalImage];//선택한 이미지 가져옴

    if (pickedImage) {
    //이미지 어떻게 전달할까?
        [[NSUserDefaults standardUserDefaults]setObject:UIImagePNGRepresentation(pickedImage) forKey:@"newBack"];
            
        
        //You have pickedImage now, do your logic here
    
    }

    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {

    [self dismissViewControllerAnimated:YES completion:nil];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)UpdatePenSetting{
     _ShowNowPenSet.title=[NSString stringWithFormat:@"%d",(int)[[NSUserDefaults standardUserDefaults]floatForKey:@"newPen"]];
    _PenSeet.tintColor =[UIColor colorWithRed:[[NSUserDefaults standardUserDefaults]floatForKey:@"newRed"] green:[[NSUserDefaults standardUserDefaults]floatForKey:@"newGreen"] blue:[[NSUserDefaults standardUserDefaults]floatForKey:@"newBlue"] alpha:1];
}
- (IBAction)ChangePenSetting:(id)sender {
    //지우개 전환
    
}
- (IBAction)TrashCanClick:(id)sender {
       //싹다 지우기
    NSLog(@"여기부터 클릭");
       [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"ClearAction"];
   // CanvasViewController *con=[[CanvasViewController alloc] init] ;
   // CanvasViewController *con =
//    NSLog( @"범인? %d",con.view.layer.sublayers.count);//안통함
//    
   
    
//    CanvasViewController *con = [CanvasViewController new];

   // NSLog(@"%d",_MainCanvaslo.layer.sublayers.count);//안통함
    
   
    //NSLog(@"$$$$ %d", con.view.layer.sublayers.count);
   // [CanvasViewController Testremove];
   // NSLog(@"snf");
   
}
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    if([segue.identifier isEqualToString:@"testsegue"]){
//         NSLog(@"yyyyyyy");
//        //CanvasViewController *con = segue.destinationViewController;
//        //con.testbuttonlayout.backgroundColor = UIColor.blackColor;
//    }
    
//}


- (IBAction)Sharebutton:(id)sender {
    if(self.sendTableView.hidden==YES){
        self.sendTableView.hidden=NO;
    }else{
        self.sendTableView.hidden=YES;
    }
    //이건 텍스트 공유하는 방법
//     NSArray* sharedObjects=[NSArray arrayWithObjects:@"sharecontent",  nil];
//     UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:sharedObjects applicationActivities:nil];
//     activityViewController.popoverPresentationController.sourceView = self.view;
//     [self presentViewController:activityViewController animated:YES completion:nil];
    
    
   
}

- (IBAction)ChangePenandEraser:(id)sender {
    //연필 지우개 전환 버튼
   bool PEPE= [[NSUserDefaults standardUserDefaults]boolForKey:@"PenChangeEraser"];
    
    
    if(PEPE){//연필->지우개
        if (@available(iOS 13.0, *)) {
            _buttonPenEraser.title=@"Era";
            _buttonPenEraser.image=[UIImage systemImageNamed:@"bandage"];
        } else {
            // Fallback on earlier versions
            _buttonPenEraser.title=@"Era";
            _buttonPenEraser.image=[UIImage imageNamed:@"name_of_system_bandage"];
            }
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"PenChangeEraser"];
        PEPE=NO;
    }
    else{//지우개->연필
        if (@available(iOS 13.0, *)) {
            _buttonPenEraser.title=@"Pens";
            _buttonPenEraser.image=[UIImage systemImageNamed:@"pencil.tip"];
        } else {
            // Fallback on earlier versions
            _buttonPenEraser.title=@"Pens";
            _buttonPenEraser.image=[UIImage imageNamed:@"pencil.tip"];
            }
        PEPE=YES;
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"PenChangeEraser"];
        
        
        
    }
}
@end
