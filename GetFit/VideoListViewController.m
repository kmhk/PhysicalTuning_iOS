//
//  VideoListViewController.m
//  GetFit
//
//  Created by jin on 1/8/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#import "VideoListViewController.h"
#import "VideoTutorialViewController.h"
#import "VideoCell.h"

@interface VideoListViewController ()

@end

@implementation VideoListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil color:(exerciseType)type
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        eType = type;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSMutableArray *redArray = [NSMutableArray arrayWithObjects: @"Red_Burpees",
                       @"Red_Mountain_climbers",
                       @"Red_Combined_burpees",
                       @"Red_Sprinting",
                                @"Red_Starjumps", nil];
    NSMutableArray *yellowArray = [NSMutableArray arrayWithObjects:
                       @"Yellow_PushUps_Regular",
                       @"Yellow_PushUps_Staggered",
                       @"Yellow_PushUps_Hindu",
                       @"Yellow_PushUps_Small",
                                   @"Yellow_PushUps_Spiderman", nil];
    NSMutableArray *blueArray = [NSMutableArray arrayWithObjects:
                       @"Blue_ReverseCrunch",
                       @"Blue_V_Snaps",
                       @"Blue_Cycling",
                       @"Blue_SitUps_Regular",
                                 @"Blue_Penguin", nil];
    NSMutableArray *greenArray = [NSMutableArray arrayWithObjects:
                       @"Green_Lunges",
                       @"Green_Lunges_jumps",
                       @"Green_Squat_jumps",
                       @"Green_Skating",
                                  @"Green_Prison_squats", nil];
    NSMutableArray *orangeArray = [NSMutableArray arrayWithObjects:
                       @"Orange_Hip_raises",
                       @"Orange_Planking_regular",
                       @"Orange_Planking_superman",
                       @"Orange_Para_regular",
                       @"Orange_Planking_expert", nil];
    NSMutableArray *allArray = [NSMutableArray arrayWithObjects: @"Red_Burpees",
                       @"Red_Mountain_climbers",
                       @"Red_Combined_burpees",
                       @"Red_Sprinting",
                       @"Red_Starjumps",
                       @"Yellow_PushUps_Regular",
                       @"Yellow_PushUps_Staggered",
                       @"Yellow_PushUps_Hindu",
                       @"Yellow_PushUps_Small",
                       @"Yellow_PushUps_Spiderman",
                       @"Blue_ReverseCrunch",
                       @"Blue_V_Snaps",
                       @"Blue_Cycling",
                       @"Blue_SitUps_Regular",
                       @"Blue_Penguin",
                       @"Green_Lunges",
                       @"Green_Lunges_jumps",
                       @"Green_Squat_jumps",
                       @"Green_Skating",
                       @"Green_Prison_squats",
                       @"Orange_Hip_raises",
                       @"Orange_Planking_regular",
                       @"Orange_Planking_superman",
                       @"Orange_Para_regular",
                       @"Orange_Planking_expert", nil];
    
    NSMutableArray *redNameArray = [NSMutableArray arrayWithObjects: @"Burpees",
                                @"Mountain Climbers",
                                @"Combined Burpees",
                                @"Sprinting",
                                @"Starjumps", nil];
    NSMutableArray *yellowNameArray = [NSMutableArray arrayWithObjects:
                                   @"Push-Ups Regular",
                                   @"Push-Ups Staggered",
                                   @"Push-Ups Hindu",
                                   @"Push-Ups Small",
                                   @"Push-Ups Spiderman", nil];
    NSMutableArray *blueNameArray = [NSMutableArray arrayWithObjects:
                                 @"Reverse Crunch",
                                 @"V-Snaps",
                                 @"Cycling",
                                 @"Sit-Ups Regular",
                                 @"Penguin", nil];
    NSMutableArray *greenNameArray = [NSMutableArray arrayWithObjects:
                                  @"Lunges",
                                  @"Lunges Jumps",
                                  @"Squat Jumps",
                                  @"Skating",
                                  @"Prison Squats", nil];
    NSMutableArray *orangeNameArray = [NSMutableArray arrayWithObjects:
                                   @"Hip Raises",
                                   @"Planking Regular",
                                   @"Planking Superman",
                                   @"Para Regular",
                                   @"Planking Expert", nil];
    NSMutableArray *allNameArray = [NSMutableArray arrayWithObjects: @"Burpees",
                                    @"Mountain Climbers",
                                    @"Combined Burpees",
                                    @"Sprinting",
                                    @"Starjumps",
                                    @"Push-Ups Regular",
                                    @"Push-Ups Staggered",
                                    @"Push-Ups Hindu",
                                    @"Push-Ups Small",
                                    @"Push-Ups Spiderman",
                                    @"Reverse Crunch",
                                    @"V-Snaps",
                                    @"Cycling",
                                    @"Sit-Ups Regular",
                                    @"Penguin",
                                    @"Lunges",
                                    @"Lunges Jumps",
                                    @"Squat Jumps",
                                    @"Skating",
                                    @"Prison Squats",
                                    @"Hip Raises",
                                    @"Planking Regular",
                                    @"Planking Superman",
                                    @"Para Regular",
                                    @"Planking Expert", nil];


    videoNameArray = [NSMutableArray array];
    switch (eType) {
        case FAT_BURNER:
            videoArray = redArray;
            videoNameArray = redNameArray;
            [self.titleLabel setText:@"RED MUSCLE GROUP"];
            break;
        case UPPER_BODY:
            videoArray = yellowArray;
            videoNameArray = yellowNameArray;
            [self.titleLabel setText:@"YELLOW MUSCLE GROUP"];
            break;
        case BELLY:
            videoArray = blueArray;
            videoNameArray = blueNameArray;
            [self.titleLabel setText:@"BLUE MUSCLE GROUP"];
            break;
        case LEGS:
            videoArray = greenArray;
            videoNameArray = greenNameArray;
            [self.titleLabel setText:@"GREEN MUSCLE GROUP"];
            break;
        case CORE:
            videoArray = orangeArray;
            videoNameArray = orangeNameArray;
            [self.titleLabel setText:@"ORANGE MUSCLE GROUP"];
            break;
        case ALL:
            videoArray = allArray;
            videoNameArray = allNameArray;
            [self.titleLabel setText:@"ALL VIDEO TUTORIALS"];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonTUI:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableView
- (int)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return videoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *setCellIdentfier = @"setCellIdentifier";
    
    VideoCell *cell = (VideoCell *)[tableView dequeueReusableCellWithIdentifier:setCellIdentfier];// [[UITableViewCell alloc] init];
    if(nil==cell) {
        cell = [[VideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:setCellIdentfier];
    }
    
    NSString *videoNanme = (NSString *)[videoArray objectAtIndex:indexPath.row];
    NSArray *frontArray = [videoNanme componentsSeparatedByString:@"_"];
    NSString *titleName = (NSString *)[videoNameArray objectAtIndex:indexPath.row];
    
    [cell.videoLabel setText:titleName];
    cell.videoName = titleName;
    cell.videoPath = [[NSBundle mainBundle] pathForResource:videoNanme ofType:@"mp4"];
    
    NSString *color = (NSString *)[frontArray objectAtIndex:0];
    if([color isEqualToString:@"Red"]) [cell.mvImageView setImage:[UIImage imageNamed:@"Red_mv.png"]];
    else if([color isEqualToString:@"Yellow"]) [cell.mvImageView setImage:[UIImage imageNamed:@"Yellow_mv.png"]];
    else if([color isEqualToString:@"Blue"]) [cell.mvImageView setImage:[UIImage imageNamed:@"Blue_mv.png"]];
    else if([color isEqualToString:@"Green"]) [cell.mvImageView setImage:[UIImage imageNamed:@"Green_mv.png"]];
    else if([color isEqualToString:@"Orange"]) [cell.mvImageView setImage:[UIImage imageNamed:@"Orange_mv.png"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoCell *cell = (VideoCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    VideoTutorialViewController *tView = [[VideoTutorialViewController alloc] initWithNibName:(rect.size.height < 568) ? @"VideoTutorialViewController_4s" : @"VideoTutorialViewController" bundle:nil label:cell.videoName path:cell.videoPath];
    [self.navigationController pushViewController:tView animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

@end
