//
//  CollegeVC.m
//  jianzhi
//
//  Created by Jiangwei on 15/5/29.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "CollegeVC.h"
#import "SchoolCell.h"
#import "SchoolModel.h"

@interface CollegeVC ()

@end

@implementation CollegeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.titleView = [CommUtils navTittle:[CommUtils readUser].college];
    self.navigationItem.leftBarButtonItem=[LMButton setNavleftComboButtonWithImg:@"back" andSelector:@selector(backMethod) andTarget:self];
    
    self.colTbView.backgroundColor = [UIColor clearColor];
    self.colTbView.backgroundView = nil;
    self.colTbView.separatorStyle = NO;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Rectangle 543"]];
    
    _colMuArray = [NSMutableArray arrayWithCapacity:0];
    
    [self getCollegeDate:[CommUtils readUser].college];

}

-(void)backMethod
{
    LM_POP;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.colMuArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *notice=@"SchoolCell";
    SchoolCell *cell=[tableView dequeueReusableCellWithIdentifier:notice];
    if (!cell) {
        cell =[[[NSBundle mainBundle] loadNibNamed:@"SchoolCell" owner:self options:nil] lastObject];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    SchoolModel * schModel = [self.colMuArray objectAtIndex:indexPath.row];
    cell.headLabel.text = schModel.name;
    return cell;
}


-(void)getCollegeDate:(NSString *)name
{
    NSDictionary *parameters = @{@"school_name":name,@"version":[CommUtils getVersion]};
    
    TLog(@"输出请求内容%@",parameters);
    
    [self.colMuArray removeAllObjects];
    
    __weak CollegeVC *bSelf = self;
    NSString *stringurl=[NSString stringWithFormat:@"%@%@",PartyAPI,kInstitute];
    TLog(@"输出请求内容%@",stringurl);
    //[SVProgressHUD show];
    [AFService postMethod:stringurl andDict:parameters completion:^(NSDictionary *results,NSError *error){
        if (results) {
            TLog(@"results == %@",results);
            NSArray *array=[results objectForKey:@"institutes"];
            NSMutableArray *muArray=[Manager dataAnalysisArray:@"SchoolModel" andArray:array];
            TLog(@"输出modle数组%@",muArray);
            [bSelf.colMuArray addObjectsFromArray:muArray];
            TLog(@"输出modle数组%@",bSelf.colMuArray);
            
            [bSelf.colTbView reloadData];
        }else{
            TLog(@"error == %@",error);
        }
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SchoolModel *schModel = [self.colMuArray objectAtIndex:indexPath.row];
    [self.delegate collegeDetail:schModel.name];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    UserModel * userModel = [CommUtils readUser];
    userModel.institute = schModel.name;
    [CommUtils saveUserModel:userModel];

}

@end
