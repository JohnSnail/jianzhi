//
//  CommendVC.m
//  jianzhi
//
//  Created by li on 15/4/9.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "CommendVC.h"
#import "CommendCell.h"
#import "CommendHeader.h"
#import "DetailVC.h"
#import "CustomVC.h"
#import "LoginVC.h"
#import "MyRecordVC.h"
#define MJRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]
@interface CommendVC ()
{
    NSInteger count;
    NSInteger pageNumber;
}
@property (strong, nonatomic) NSMutableArray *imageArray;
@end

@implementation CommendVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nevBar"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    self.navigationController.navigationBar.translucent=YES;
}
-(NSMutableArray *)mutableArray
{
    if (!_mutableArray) {
        count=0;
        pageNumber=1;
        _mutableArray=[[NSMutableArray alloc] init];
    }
    return _mutableArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self example];
    [self getlocation];
    self.navigationItem.titleView=[CommUtils navTittle:@"推荐"];
    self.navigationItem.rightBarButtonItem=[LocolData setCustomTitle:@"定制" Action:@selector(typeCustomVC) Target:self];
    self.navigationItem.leftBarButtonItem=[LocolData setCityTitle:@"北京" Action:@selector(cityMethod) Target:self];
//    UIImageView *imageview=[LMImageView lmImageView:CGRectMake(0, 20, 10, 14) andUrl:nil andImageName:@"CitySelect"];
//    [self.navigationController.view addSubview:imageview];
}
-(void)cityMethod
{
    
}
#pragma mark - 定位城市
-(void)getlocation
{
    _locationmanager = [[CLLocationManager alloc]init];
    
    //设置精度
    /*
     kCLLocationAccuracyBest
     kCLLocationAccuracyNearestTenMeters
     kCLLocationAccuracyHundredMeters
     kCLLocationAccuracyHundredMeters
     kCLLocationAccuracyKilometer
     kCLLocationAccuracyThreeKilometers
     */
    //设置定位的精度
    [_locationmanager setDesiredAccuracy:kCLLocationAccuracyBest];
    //实现协议
    _locationmanager.delegate = self;
    //TLog(@"开始定位");
    //开始定位
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [_locationmanager requestWhenInUseAuthorization];
    [_locationmanager startUpdatingLocation];
}
#pragma mark - CoreLocation 代理
#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
//可以通过模拟器设置一个虚拟位置，否则在模拟器中无法调用此方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location=[locations firstObject];//取出第一个位置
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    //如果不需要实时定位，使用完即使关闭定位服务
    if (((int)self.lat==0)&&((int)self.lng==0)) {
        self.lat=coordinate.latitude;
        self.lng=coordinate.longitude;
        [ClassModel LMAppModel].lat=coordinate.latitude;
        [ClassModel LMAppModel].lng=coordinate.longitude;
        [Manager getLocationlat:self.lat andlng:self.lng];
        [self loadNewData:nil];
        
    }else
    {
        self.lat=coordinate.latitude;
        self.lng=coordinate.longitude;
    }
    [_locationmanager stopUpdatingLocation];
}

#pragma mark - 加载数据
-(void)getNetworkData:(NSInteger)page andSize:(NSInteger)size
{
    if(![CommUtils getMobileKey]){
        return;
    }////@"110100"[ClassModel LMAppModel].city_id
    if ([Manager isBlankString:[ClassModel LMAppModel].city_id]) {
        [ClassModel LMAppModel].city_id=@"110100";
    }
    __weak typeof(self) weakSelf = self;
    NSDictionary *parameters = @{@"size":@(size),@"page":@(page),@"device_token":[CommUtils getMobileKey],@"city_id":[ClassModel LMAppModel].city_id,@"ads_id":@"1",@"version":[CommUtils getVersion]};
    TLog(@"输出请求内容%@",parameters);
    NSString *stringurl=[NSString stringWithFormat:@"%@recommend",PartyAPI];
    TLog(@"输出请求内容%@",stringurl);
    //[SVProgressHUD show];
    [AFService postMethod:stringurl andDict:parameters completion:^(NSDictionary *results,NSError *error){
        if (results) {
            if ([[results objectForKey:@"code"] intValue]==0)
            {
                weakSelf.adsArray=[results objectForKey:@"ads"];
                NSArray *array=[results objectForKey:@"jobs"];
                NSMutableArray *muArray=[Manager dataAnalysisArray:@"CommendModel" andArray:array];
                TLog(@"输出modle数组%@",muArray);
                if(pageNumber==1){
                    [weakSelf.mutableArray removeAllObjects];
                }
                [weakSelf.mutableArray addObjectsFromArray:muArray];
                TLog(@"输出modle数组%@",weakSelf.mutableArray);
                [weakSelf noDateArray:array];
            }
        }else
        {
            TLog(@"ERROR: %@", error);
            //[weakSelf noDateArray:nil];
        }
    }];
}


-(void)noDateArray:(NSArray *)array
{
    [self.commendTable.footer endRefreshing];
    [self.commendTable.header endRefreshing];
    [self.commendTable reloadData];
    if (array.count<20) {
        [self.commendTable.footer noticeNoMoreData];
    }
}
#pragma mark - 私人定制
-(void)typeCustomVC
{
//    MyRecordVC *vc=LM_CREATE_OBJECT(MyRecordVC);
//    LM_PUSH;
    if (![CommUtils is_onLine]) {
        LoginVC *loginViewController = [[LoginVC alloc]init];
        [self.navigationController presentViewController:loginViewController animated:YES completion:nil];
        return;
    }
    TLog(@"输出城市id%@",[ClassModel LMAppModel].city_id);
    if ([Manager isBlankString:[NSString stringWithFormat:@"%@",[ClassModel LMAppModel].city_id]]) {
        [ClassManager getClassCity:@"北京" Success:^(NSString *success){
            if ([success isEqualToString:@"success"]) {
                CustomVC *vc=LM_CREATE_OBJECT(CustomVC);
                vc.hidesBottomBarWhenPushed=YES;
                LM_PUSH;
            }else
            {
                [Manager textNoSpace:@"请打开您的位置"];
            }
        }];
    }else
    {
        CustomVC *vc=LM_CREATE_OBJECT(CustomVC);
        vc.hidesBottomBarWhenPushed=YES;
        LM_PUSH;
    }
}
#pragma mark - 刷新方法
- (void)example
{
    //__weak typeof(self) weakSelf = self;
    
    [self.commendTable addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData:)];
    // 隐藏时间
    //隐藏时间显示
    //self.businessTableview.header.updatedTimeHidden = YES;
    // 马上进入刷新状态
    [self.commendTable.header beginRefreshing];
    //self.commendTable.header.hidden=YES;
    // 添加传统的上拉刷新
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    [self.commendTable addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMore:)];
}
-(void)loadMore:(id)my
{
    pageNumber++;
    [self getNetworkData:pageNumber andSize:20];
}
-(void)loadNewData:(id)mjrefresh
{
    pageNumber=1;
    [self getNetworkData:pageNumber andSize:20];
}
#pragma mark - tableview代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 130;
    }
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        CommendHeader* header = [[[NSBundle mainBundle] loadNibNamed: @"CommendHeader" owner: self options: nil] lastObject];//[_imageArray count]
        header.message.hidden=YES;
        header.imageShow.hidden=YES;
        NSMutableArray *tempArray = [NSMutableArray array];
        for (int i = 0 ; i <self.adsArray.count ; i++)
        {
            //HeaderModel *model=[_imageArray objectAtIndex:i];
            NSDictionary *dict=[self.adsArray objectAtIndex:i];
            SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithTitle:@"title" image:[NSString stringWithFormat:@"http://tongxuejianzhi.com%@",[dict objectForKey:@"image_url"]] tag:i];
            TLog(@"输出id%@",[NSString stringWithFormat:@"http://tongxuejianzhi.com%@",[dict objectForKey:@"image_rul"]]);
            [tempArray addObject:item];
        }
        SGFocusImageFrame *imageFrame = [[SGFocusImageFrame alloc] initWithFrame:CGRectMake(0, 0, mainscreenwidth, header.bounds.size.height) delegate:self focusImageItems:tempArray andView:header];
        [header addSubview:imageFrame];
        return header;
    }
    return nil;
}
- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame didSelectItem:(SGFocusImageItem *)item
{
    TLog(@"chuchu%ld,11111111,%@",(long)item.tag,item.title);
    if (self.mutableArray.count>0) {
        CommendModel *model=[self.mutableArray objectAtIndex:0];
        if (model.id.integerValue != 0) {
            DetailVC *vc=LM_CREATE_OBJECT(DetailVC);
            vc.jobId=model.id;
            vc.hidesBottomBarWhenPushed=YES;
            LM_PUSH;
        }
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.mutableArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *notice=@"CommendCell";
    CommendCell *cell=[tableView dequeueReusableCellWithIdentifier:notice];
    if (!cell) {
        cell =[[[NSBundle mainBundle] loadNibNamed:@"CommendCell" owner:self options:nil] lastObject];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    CommendModel *model=[self.mutableArray objectAtIndex:indexPath.section];
    [cell showCommend:model];
    //cell.textLabel.text=@"显示数据";
//    BureauListModel *model=[self.mutableArray objectAtIndex:indexPath.section];
//    [cell showData:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommendModel *model=[self.mutableArray objectAtIndex:indexPath.section];
    if (model.id.integerValue != 0) {
        DetailVC *vc=LM_CREATE_OBJECT(DetailVC);
        vc.jobId=model.id;
        vc.hidesBottomBarWhenPushed=YES;
        LM_PUSH;
    }
}

@end
