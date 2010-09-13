#import "BaseServices.h"

@implementation BaseServices

@synthesize managedObjectContext=_managedObjectContext;

- (ASINetworkQueue *)networkQueue
{
	if (!_networkQueue) {
		_networkQueue = [[ASINetworkQueue alloc] init];
		_networkQueue.shouldCancelAllRequestsOnFailure = TRUE;
		if ([self respondsToSelector:@selector(fetchStarted:)]) {
			[_networkQueue setRequestDidStartSelector:@selector(fetchStarted:)];
		}
		if ([self respondsToSelector:@selector(fetchCompleted:)]) {
			[_networkQueue setRequestDidFinishSelector:@selector(fetchCompleted:)];
		}
		if ([self respondsToSelector:@selector(fetchFailed:)]) {
			[_networkQueue setRequestDidFailSelector:@selector(fetchFailed:)];
		}
		if ([self respondsToSelector:@selector(queueFinished:)]) {
			[_networkQueue setQueueDidFinishSelector:@selector(queueFinished:)];
		}
		
		[_networkQueue setDelegate:self];
	}
	
	return _networkQueue;
}

- (NSMutableDictionary *)fetchedDates
{
	if (!_fetchedDates) {
		_fetchedDates = [[NSMutableDictionary alloc]init];
	}
	
	return _fetchedDates;
}

- (void)saveLastFetchedUrl:(NSString *)url
{
	if (!url) {
		return;
	}
	
	[self.fetchedDates setObject:[NSDate date] forKey:url];
}

- (NSDate *)lastFetchedDateForUrl:(NSString *)url
{
	return [self.fetchedDates objectForKey:url];
}

- (void)dealloc {
	
	[_fetchedDates release];
	[_networkQueue release];
	[_managedObjectContext release];
	
    [super dealloc];
}


@end
