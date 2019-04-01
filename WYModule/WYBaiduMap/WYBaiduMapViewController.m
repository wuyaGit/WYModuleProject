//
//  WYBaiduMapViewController.m
//  WYModule
//
//  Created by mac on 2019/2/19.
//

#import "WYBaiduMapViewController.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapView.h>

@interface WYBaiduMapViewController () <BMKMapViewDelegate>

@property (nonatomic, strong) BMKMapView *mapView;
@end

@implementation WYBaiduMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    [_mapView setZoomLevel:17];//将当前地图显示缩放等级设置为17级
    [self.view addSubview:_mapView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
