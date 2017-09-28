

#import "MKStoreManager.h"

@implementation MKStoreManager

@synthesize purchasableObjects, delegate;

// all your features should be managed one and only by StoreManager
static NSString *feature0Id = @"com.zoninsider.morefilters.geteffects";
static NSString *feature1Id = @"com.antheny.outlaw.free.gun2";
static NSString *feature2Id = @"com.antheny.outlaw.free.gun3";

static NSString *featureCoin0Id = @"com.antheny.outlaw.free.coin1";
static NSString *featureCoin1Id = @"com.antheny.outlaw.free.coin2";
static NSString *featureCoin2Id = @"com.antheny.outlaw.free.coin3";
static NSString *featureCoin3Id = @"com.antheny.outlaw.free.coin4";
static NSString *featureCoin4Id = @"com.antheny.outlaw.free.coin5";
static NSString *featureCoin5Id = @"com.antheny.outlaw.free.coin6";

static NSString *featureBottle0Id = @"com.antheny.outlaw.free.bottle1";
static NSString *featureBottle1Id = @"com.antheny.outlaw.free.bottle2";
static NSString *featureBottle2Id = @"com.antheny.outlaw.free.bottle3";
static NSString *featureBottle3Id = @"com.antheny.outlaw.free.bottle4";
static NSString *featureBottle4Id = @"com.antheny.outlaw.free.bottle5";

BOOL feature0Purchased;
BOOL feature1Purchased;
BOOL feature2Purchased;

BOOL featureCoin0Purchased;
BOOL featureCoin1Purchased;
BOOL featureCoin2Purchased;
BOOL featureCoin3Purchased;
BOOL featureCoin4Purchased;
BOOL featureCoin5Purchased;

BOOL featureBottle0Purchased;
BOOL featureBottle1Purchased;
BOOL featureBottle2Purchased;
BOOL featureBottle3Purchased;
BOOL featureBottle4Purchased;

static MKStoreManager* _sharedStoreManager; // self

//- (void)dealloc {
//	
//	[_sharedStoreManager release];
//	[super dealloc];
//}

+ (BOOL) feature0Purchased {	
	return feature0Purchased;
}
+ (BOOL) feature1Purchased {	
	return feature1Purchased;
}
+ (BOOL) feature2Purchased {	
	return feature2Purchased;
}
+ (BOOL) featureCoin0Purchased {
	return featureCoin0Purchased;
}
+ (BOOL) featureCoin1Purchased {
	return featureCoin1Purchased;
}
+ (BOOL) featureCoin2Purchased {
	return featureCoin2Purchased;
}
+ (BOOL) featureCoin3Purchased {
	return featureCoin3Purchased;
}
+ (BOOL) featureCoin4Purchased {
	return featureCoin4Purchased;
}
+ (BOOL) featureCoin5Purchased {
	return featureCoin5Purchased;
}
+ (BOOL) featureBottle0Purchased
{
	return featureBottle0Purchased;
}
+ (BOOL) featureBottle1Purchased
{
	return featureBottle1Purchased;
}
+ (BOOL) featureBottle2Purchased
{
	return featureBottle2Purchased;
}
+ (BOOL) featureBottle3Purchased
{
	return featureBottle3Purchased;
}
+ (BOOL) featureBottle4Purchased
{
	return featureBottle4Purchased;
}


+ (MKStoreManager*)sharedManager
{
	NSLog(@"pass sharedManager");
	@synchronized(self) {
		
        if (_sharedStoreManager == nil) {
			
            [[self alloc] init]; // assignment not done here
			_sharedStoreManager.purchasableObjects = [[NSMutableArray alloc] init];			
			[_sharedStoreManager requestProductData];
			
			[MKStoreManager loadPurchases];
			//_sharedStoreManager.storeObserver = self;
			[[SKPaymentQueue defaultQueue] addTransactionObserver:_sharedStoreManager];
        }
    }
    return _sharedStoreManager;
}


#pragma mark Singleton Methods

+ (id)allocWithZone:(NSZone *)zone
{	
    @synchronized(self) {
		
        if (_sharedStoreManager == nil) {
			
            _sharedStoreManager = [super allocWithZone:zone];			
            return _sharedStoreManager;  // assignment and return on first allocation
        }
    }
	
    return nil; //on subsequent allocation attempts return nil	
}


- (id)copyWithZone:(NSZone *)zone
{
    return self;	
}

//- (id)retain
//{	
//    return self;	
//}
//
//- (unsigned)retainCount
//{
//    return UINT_MAX;  //denotes an object that cannot be released
//}
//
////- (void)release
////{
////    //do nothing
////}
//
//- (id)autorelease
//{
//    return self;	
//}


- (void) requestProductData
{
	SKProductsRequest *request= [[SKProductsRequest alloc] initWithProductIdentifiers: 
								 [NSSet setWithObjects: 
                                  feature0Id, 
//								  feature1Id, 
//								  feature2Id,
//								  featureCoin0Id,
//								  featureCoin1Id,
//								  featureCoin2Id,
//								  featureCoin3Id,
//								  featureCoin4Id,
//								  featureCoin5Id,
//								  featureBottle0Id,
//								  featureBottle1Id,
//								  featureBottle2Id,
//								  featureBottle3Id,
//								  featureBottle4Id,
								  nil]]; // add any other product here
	request.delegate = self;
	[request start];
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
	[purchasableObjects addObjectsFromArray:response.products];
	// populate your UI Controls here
	for(int i=0;i<[purchasableObjects count];i++)
	{
		
		SKProduct *product = [purchasableObjects objectAtIndex:i];
		NSLog(@"Feature: %@, Cost: %f, ID: %@",[product localizedTitle],
			  [[product price] doubleValue], [product productIdentifier]);
	}
	
//	[request autorelease];
}

- (void) buyFeature0 {
	[self buyFeature:feature0Id];
}
- (void) buyFeature1 {
	[self buyFeature:feature1Id];
}
- (void) buyFeature2 {
	[self buyFeature:feature2Id];
}
- (void) buyFeatureCoin0 {
	[self buyFeature:featureCoin0Id];
}
- (void) buyFeatureCoin1 {
	[self buyFeature:featureCoin1Id];
}
- (void) buyFeatureCoin2 {
	[self buyFeature:featureCoin2Id];
}
- (void) buyFeatureCoin3 {
	[self buyFeature:featureCoin3Id];
}
- (void) buyFeatureCoin4 {
	[self buyFeature:featureCoin4Id];
}
- (void) buyFeatureCoin5 {
	[self buyFeature:featureCoin5Id];
}
- (void) buyFeatureBottle0 {
	[self buyFeature:featureBottle0Id];
}
- (void) buyFeatureBottle1 {
	[self buyFeature:featureBottle1Id];
}
- (void) buyFeatureBottle2 {
	[self buyFeature:featureBottle2Id];
}
- (void) buyFeatureBottle3 {
	[self buyFeature:featureBottle3Id];
}
- (void) buyFeatureBottle4 {
	[self buyFeature:featureBottle4Id];
}


- (void) buyFeature:(NSString*) featureId
{
//	[self setLockKey: featureId];
    
	if ([SKPaymentQueue canMakePayments])
	{
//		SKPayment *payment = [SKPayment paymentWithProductIdentifier:featureId];
//		[[SKPaymentQueue defaultQueue] addPayment:payment];
        SKMutablePayment *payment = [[SKMutablePayment alloc] init] ;
        payment.productIdentifier = featureId;
        payment.quantity = 1;
        [[SKPaymentQueue defaultQueue] addPayment:payment];
        
	}
	else
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"You are not authorized to purchase from AppStore" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[alert show];
//		[alert release];
	}
}

/*
- (void) failedTransaction: (SKPaymentTransaction *)transaction
{
	NSString *messageToBeShown = [NSString stringWithFormat:@"Reason: %@, You can try: %@", [transaction.error localizedFailureReason], [transaction.error localizedRecoverySuggestion]];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unable to complete your purchase" message:messageToBeShown
												   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[alert show];
	[alert release];
}
 */

#if 0
-(void) setLockKey: (NSString*) productIdentifier
{
	if([productIdentifier isEqualToString:feature0Id])
		[AppSettings setCharLock:1 lockFlag:NO];
	if([productIdentifier isEqualToString:feature1Id])
		[AppSettings setCharLock:2 lockFlag:NO];
	if([productIdentifier isEqualToString:feature2Id])
		[AppSettings setCharLock:3 lockFlag:NO];
	if([productIdentifier isEqualToString:feature3Id])
		[AppSettings setCharLock:4 lockFlag:NO];
	if([productIdentifier isEqualToString:feature4Id])
		[AppSettings setCharLock:5 lockFlag:NO];
	if([productIdentifier isEqualToString:feature5Id])
		[AppSettings setCharLock:6 lockFlag:NO];
	if([productIdentifier isEqualToString:feature6Id])
		[AppSettings setCharLock:7 lockFlag:NO];
	if([productIdentifier isEqualToString:feature7Id])
		[AppSettings setCharLock:8 lockFlag:NO];
	if([productIdentifier isEqualToString:feature8Id])
		[AppSettings setCharLock:9 lockFlag:NO];
	if([productIdentifier isEqualToString:feature9Id])
		[AppSettings setCharLock:10 lockFlag:NO];
	
	if([productIdentifier isEqualToString:featureBoostCoin0])
		[AppSettings addBoostCoin:5];
	if([productIdentifier isEqualToString:featureBoostCoin1])
		[AppSettings addBoostCoin:15];
	if([productIdentifier isEqualToString:featureBoostCoin2])
		[AppSettings setBoostCoin: UNLIMIT];

	if([productIdentifier isEqualToString:featureSkipCoin0])
		[AppSettings addSkipCoin:3];
	if([productIdentifier isEqualToString:featureSkipCoin1])
		[AppSettings addSkipCoin:8];
	if([productIdentifier isEqualToString:featureSkipCoin2])
		[AppSettings setSkipCoin: UNLIMIT];

	if([productIdentifier isEqualToString:featureAllOpenCoin])
		[AppSettings setPurchasedAllOpenCoin: YES];
    int prevCoins = [AppSettings getCoins];
   
    if([productIdentifier isEqualToString:feature50Coin]){
        updatedCoins = prevCoins + 50;
		[AppSettings setCoins:updatedCoins];
    }
    if([productIdentifier isEqualToString:feature100Coin]){
             updatedCoins = prevCoins + 100;
        [AppSettings setCoins:updatedCoins];
    }
    if([productIdentifier isEqualToString:feature250Coin]){
             updatedCoins = prevCoins + 250;
        [AppSettings setCoins:updatedCoins];
    }
	if([productIdentifier isEqualToString:feature500Coin]){
             updatedCoins = prevCoins + 500;
        [AppSettings setCoins:updatedCoins];
    }
    if([productIdentifier isEqualToString:feature1000Coin]){
             updatedCoins = prevCoins + 1000;
        [AppSettings setCoins:updatedCoins];
    }
	if([productIdentifier isEqualToString:feature5000Coin]){
             updatedCoins = prevCoins + 5000;
        [AppSettings setCoins:updatedCoins];
    }
}
#endif

-(void) provideContent: (NSString*) productIdentifier
{
	if([productIdentifier isEqualToString:feature0Id])
	{
		feature0Purchased = YES;
//		[[PurchaseInfoManager sharedInstance] setUnlockGunFlag:0];
		
		[self.delegate releaseIAP];
	}
	
//	if([productIdentifier isEqualToString:feature1Id])
//	{
//		feature1Purchased = YES;
//		[[PurchaseInfoManager sharedInstance] setUnlockGunFlag:1];
//		
//		[self.delegate onSelectBuyGunButton:1];
//	}
//	
//	if([productIdentifier isEqualToString:feature2Id])
//	{
//		feature2Purchased = YES;
//		[[PurchaseInfoManager sharedInstance] setUnlockGunFlag:3];
//		
//		[self.delegate onSelectBuyGunButton:3];
//	}
//    
//    if([productIdentifier isEqualToString:featureCoin0Id])
//	{
//		//featureBoostCoin0Purchased = YES;
//		int curCoin = [[PurchaseInfoManager sharedInstance] getTotalCoins];
//		[[PurchaseInfoManager sharedInstance] setTotalCoins:(curCoin + 200)];
//	}
//	
//	if([productIdentifier isEqualToString:featureCoin1Id])
//	{
//		//featureBoostCoin1Purchased = YES;
//		int curCoin = [[PurchaseInfoManager sharedInstance] getTotalCoins];
//		[[PurchaseInfoManager sharedInstance] setTotalCoins:(curCoin + 450)];
//	}
//	
//	if([productIdentifier isEqualToString:featureCoin2Id])
//	{
//		//featureBoostCoin1Purchased = YES;
//		int curCoin = [[PurchaseInfoManager sharedInstance] getTotalCoins];
//		[[PurchaseInfoManager sharedInstance] setTotalCoins:(curCoin + 1000)];
//	}
//	
//	if([productIdentifier isEqualToString:featureCoin3Id])
//	{
//		//featureBoostCoin1Purchased = YES;
//		int curCoin = [[PurchaseInfoManager sharedInstance] getTotalCoins];
//		[[PurchaseInfoManager sharedInstance] setTotalCoins:(curCoin + 2200)];
//	}
//	
//	if([productIdentifier isEqualToString:featureCoin4Id])
//	{
//		//featureBoostCoin1Purchased = YES;
//		int curCoin = [[PurchaseInfoManager sharedInstance] getTotalCoins];
//		[[PurchaseInfoManager sharedInstance] setTotalCoins:(curCoin + 2700)];
//	}
//	
//	if([productIdentifier isEqualToString:featureCoin5Id])
//	{
//		//featureBoostCoin1Purchased = YES;
//		int curCoin = [[PurchaseInfoManager sharedInstance] getTotalCoins];
//		[[PurchaseInfoManager sharedInstance] setTotalCoins:(curCoin + 5900)];
//	}
//	
//	if ([productIdentifier isEqualToString:featureBottle0Id]) {
//		int curMoonshine = [[PurchaseInfoManager sharedInstance] getMoonshineCount];
//		[[PurchaseInfoManager sharedInstance] setMoonshineCount:(curMoonshine + 1)];
//	}
//	
//	if ([productIdentifier isEqualToString:featureBottle1Id]) {
//		int curMoonshine = [[PurchaseInfoManager sharedInstance] getMoonshineCount];
//		[[PurchaseInfoManager sharedInstance] setMoonshineCount:(curMoonshine + 10)];
//	}
//	
//	if ([productIdentifier isEqualToString:featureBottle2Id]) {
//		int curMoonshine = [[PurchaseInfoManager sharedInstance] getMoonshineCount];
//		[[PurchaseInfoManager sharedInstance] setMoonshineCount:(curMoonshine + 25)];
//	}
//	
//	if ([productIdentifier isEqualToString:featureBottle3Id]) {
//		int curMoonshine = [[PurchaseInfoManager sharedInstance] getMoonshineCount];
//		[[PurchaseInfoManager sharedInstance] setMoonshineCount:(curMoonshine + 45)];
//	}
//	
//	if ([productIdentifier isEqualToString:featureBottle4Id]) {
//		int curMoonshine = [[PurchaseInfoManager sharedInstance] getMoonshineCount];
//		[[PurchaseInfoManager sharedInstance] setMoonshineCount:(curMoonshine + 100)];
//	}
    
	[MKStoreManager updatePurchases];
}


+(void) loadPurchases 
{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];	
	feature0Purchased = [userDefaults boolForKey:feature0Id];
//	feature1Purchased = [userDefaults boolForKey:feature1Id];
//	feature2Purchased = [userDefaults boolForKey:feature2Id];
//	featureCoin0Purchased = [userDefaults boolForKey:featureCoin0Id];
//	featureCoin1Purchased = [userDefaults boolForKey:featureCoin1Id];
//	featureCoin2Purchased = [userDefaults boolForKey:featureCoin2Id];
//	featureCoin3Purchased = [userDefaults boolForKey:featureCoin3Id];
//	featureCoin4Purchased = [userDefaults boolForKey:featureCoin4Id];
//	featureCoin5Purchased = [userDefaults boolForKey:featureCoin5Id];
//	featureBottle0Purchased = [userDefaults boolForKey:featureBottle0Id];
//	featureBottle1Purchased = [userDefaults boolForKey:featureBottle1Id];
//	featureBottle2Purchased = [userDefaults boolForKey:featureBottle2Id];
//	featureBottle3Purchased = [userDefaults boolForKey:featureBottle3Id];
//	featureBottle4Purchased = [userDefaults boolForKey:featureBottle4Id];
}


+(void) updatePurchases
{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults setBool:feature0Purchased forKey:feature0Id];
	[userDefaults setBool:feature1Purchased forKey:feature1Id]; 
	[userDefaults setBool:feature2Purchased forKey:feature2Id];
	[userDefaults setBool:featureCoin0Purchased forKey:featureCoin0Id];
	[userDefaults setBool:featureCoin1Purchased forKey:featureCoin1Id];
	[userDefaults setBool:featureCoin2Purchased forKey:featureCoin2Id];
	[userDefaults setBool:featureCoin3Purchased forKey:featureCoin3Id];
	[userDefaults setBool:featureCoin4Purchased forKey:featureCoin4Id];
	[userDefaults setBool:featureCoin5Purchased forKey:featureCoin5Id];
	[userDefaults setBool:featureBottle0Purchased forKey:featureBottle0Id];
	[userDefaults setBool:featureBottle1Purchased forKey:featureBottle1Id];
	[userDefaults setBool:featureBottle2Purchased forKey:featureBottle2Id];
	[userDefaults setBool:featureBottle3Purchased forKey:featureBottle3Id];
	[userDefaults setBool:featureBottle4Purchased forKey:featureBottle4Id];
}
-(void)restorePurchase
{
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}


#pragma mark - for store observer

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
	for (SKPaymentTransaction *transaction in transactions)
	{
		switch (transaction.transactionState)
		{
			case SKPaymentTransactionStatePurchased:
				
                [self completeTransaction:transaction];
				
                break;
				
            case SKPaymentTransactionStateFailed:
				
                [self failedTransaction:transaction];
				
                break;
				
            case SKPaymentTransactionStateRestored:
				
                [self restoreTransaction:transaction];
				
            default:
				
                break;
		}
	}
}

- (void) failedTransaction: (SKPaymentTransaction *)transaction
{
    if (transaction.error.code != SKErrorPaymentCancelled){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please check your Internet connection and your App Store account information." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[alert show];
//		[alert release];
	}
	
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (void) completeTransaction: (SKPaymentTransaction *)transaction
{
    [self provideContent: transaction.payment.productIdentifier];
	//[[MKStoreManager sharedManager] setLockKey: transaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (void) restoreTransaction: (SKPaymentTransaction *)transaction
{
    [self provideContent: transaction.originalTransaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}
- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue {
    
    NSLog(@"paymentQueueRestoreCompletedTransactionsFinished");
    if ([queue.transactions count] == 0) {
        // Queue does not include any transactions, so either user has not yet made a purchase
        // or the user's prior purchase is unavailable, so notify app (and user) accordingly.
        
		//  NSLog(@" restore queue.transactions count == 0");
        
        // Release the transaction observer since no prior transactions were found.
        [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
        
        [self incompleteRestore];
        
    } else{
        
        for (SKPaymentTransaction *transaction in queue.transactions)
        {
            
            [self  provideContent: transaction.originalTransaction.payment.productIdentifier];
            //[[MKStoreManager sharedManager] setLockKey: transaction.payment.productIdentifier];
            [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
			//  NSLog (@"product id is %@" , transaction.originalTransaction.payment.productIdentifier);
            // here put an if/then statement to write files based on previously purchased items
            // example if ([productID isequaltostring: @"youruniqueproductidentifier]){write files} else { nslog sorry}
        }
	}
}
- (void)paymentQueue:(SKPaymentQueue*)queue restoreCompletedTransactionsFailedWithError:(NSError*)error
{
    UIAlertView *failedAlert = [[UIAlertView alloc] initWithTitle:@"Restore Stopped" message:@"Either you cancelled the request or your prior purchase could not be restored. Please try again later, or contact the app's customer support for assistance." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [failedAlert show];
//    [failedAlert release];
    
    //This Method will be called if user has cancelled transaction or some error occurred..
}
-(void) incompleteRestore
{
    //NSLog(@"ViewController incompleteRestore");
    
    // Restore queue did not include any transactions, so either the user has not yet made a purchase
    // or the user's prior purchase is unavailable, so notify user to make a purchase within the app.
    // If the user previously purchased the item, they will NOT be re-charged again, but it should
    // restore their purchase.
    
    UIAlertView *restoreAlert = [[UIAlertView alloc] initWithTitle:@"Restore Issue" message:@"A prior purchase transaction could not be found. To restore the purchased product, tap the Buy button. Paid customers will NOT be charged again, but the purchase will be restored." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [restoreAlert show];
//    [restoreAlert release];
}

@end
