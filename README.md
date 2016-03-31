# photoCarousel
自定义轮播图
用法

   XGCirculScrollView *cirSc = [XGCirculScrollView circulScrollView];
    
    cirSc.frame = CGRectMake(20, 50, 300, 130);
    
    cirSc.timerVal = 2.0;
    
    //    cirSc.imageNamesArray = @[@"img_00"];
    
    cirSc.imageNamesArray = @[@"img_00",@"img_01",@"img_02",@"img_03",@"img_04"];
    
    cirSc.userEnabled = YES;
    
    cirSc.scrollDirection = YES;
    
    cirSc.pageTintColor = [UIColor blueColor];
    
    cirSc.currentPageTintColor = [UIColor orangeColor];
    
    [self.view addSubview:cirSc];
