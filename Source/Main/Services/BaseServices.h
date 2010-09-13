#import <Foundation/Foundation.h>
#import "ASINetworkQueue.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"


@interface BaseServices : NSObject <ASIHTTPRequestDelegate> {
	ASINetworkQueue *_networkQueue;
	
	NSManagedObjectContext *_managedObjectContext;
	
	NSMutableDictionary *_fetchedDates;
}

@property (nonatomic, readonly) ASINetworkQueue *networkQueue;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, readonly) NSMutableDictionary *fetchedDates;

- (void)saveLastFetchedUrl:(NSString *)url;
- (NSDate *)lastFetchedDateForUrl:(NSString *)url;

@end

@protocol BaseServicesContentManagement <NSObject>

- (void)downloadContentForUrl:(NSString *)url withObject:(id)object;

- (void)fetchCompleted:(ASIHTTPRequest *)request;
- (void)fetchFailed:(ASIHTTPRequest *)request;
- (void)queueFinished:(ASINetworkQueue *)queue;

@end
