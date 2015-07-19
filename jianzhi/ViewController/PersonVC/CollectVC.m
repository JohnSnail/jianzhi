//
//  CollectVC.m
//  jianzhi
//
//  Created by Jiangwei on 15/4/10.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "CollectVC.h"
#import "CommendCell.h"
#import "DetailVC.h"

@interface CollectVC ()

@end

@implementation CollectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [CommUtils navTittle:@"我的收藏"];

    self.navigationItem.leftBarButtonItem=[LMButton setNavleftComboButtonWithImg:@"back" andSelector:@selector(backMethod) andTarget:self];
    
    _mutableArray=[[NSMutableArray alloc] init];

    [self getNetworkData];
    
    self.colTbView.separatorStyle = NO;
    
    self.emptyImageView.hidden = YES;
}

-(void)backMethod
{
    LM_POP;
}

#pragma mark - 加载数据
-(void)getNetworkData
{
    if(![CommUtils getMobileKey]){
        return;
    }
    __weak typeof(self) weakSelf = self;
    NSDictionary *parameters = @{@"device_token":[CommUtils getMobileKey],@"user_token":[CommUtils getUserKey],@"version":[CommUtils getVersion]};
    TLog(@"输出请求内容%@",parameters);
    
    NSString *stringurl=[NSString stringWithFormat:@"%@%@",PartyAPI,kUserSave];
    TLog(@"输出请求内容%@",stringurl);
    
    //[SVProgressHUD show];
    [AFService postMethod:stringurl andDict:parameters completion:^(NSDictionary *results,NSError *error){
        if (results) {
            if ([[results objectForKey:@"code"] intValue]==0)
            {
                NSArray *array=[results objectForKey:@"jobs"];
                NSMutableArray *muArray=[Manager dataAnalysisArray:@"CommendModel" andArray:array];
                TLog(@"输出modle数组%@",muArray);
                [weakSelf.mutableArray addObjectsFromArray:muArray];
                TLog(@"输出modle数组%@",weakSelf.mutableArray);
            }
        }else
        {
            TLog(@"ERROR: %@", error);
            //[weakSelf noDateArray:nil];
        }
        
        [self.colTbView reloadData];
        
        if (self.mutableArray.count == 0) {
            self.emptyImageView.hidden = NO;
        }else{
            self.emptyImageView.hidden = YES;
        }
    }];
}


#pragma mark - tableview代理方法

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
