#import "PerformanceServices.h"
#import "SBJSON.h"
#import "Person.h"

@interface PerformanceServices (private)

- (void)downloadXML;
- (void)downloadXMLTree;
- (void)downloadJSON;
- (void)downloadPLIST;

@end

@implementation PerformanceServices

SYNTHESIZE_SINGLETON_FOR_CLASS(PerformanceServices)

- (void)downloadPeopleUsingFormat:(DownloadFormat)downloadFormat
{
	switch (downloadFormat) {
		case XMLFormat:
			[self downloadXML];
			break;
		case XMLTreeFormat:
			[self downloadXMLTree];
			break;
		case JSONFormat:
			[self downloadJSON];
			break;
		case PLISTFormat:
			[self downloadPLIST];
			break;
		default:
			break;
	}
}

- (void)downloadXML
{
	[self downloadContentForUrl:SERVICEURL(@"/people.xml?limit=100") withObject:@"XML"];
}

- (void)downloadXMLTree
{
	[self downloadContentForUrl:SERVICEURL(@"/people.xml?limit=100") withObject:@"XML"];
}

- (void)downloadJSON
{
	[self downloadContentForUrl:SERVICEURL(@"/people.json?limit=100") withObject:@"JSON"];
}

- (void)downloadPLIST
{
	[self downloadContentForUrl:SERVICEURL(@"/people.plist?limit=100") withObject:@"PLIST"];
}

- (void)downloadContentForUrl:(NSString *)url withObject:(id)object
{
	NSDictionary *userInfo = [NSDictionary dictionaryWithObject:object forKey:@"object"];
	
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
	request.shouldPresentAuthenticationDialog = TRUE;
	request.useKeychainPersistence = TRUE;
	request.numberOfTimesToRetryOnTimeout = 2;
	request.timeOutSeconds = RequestTimeOutSeconds;
	request.delegate = self;
	request.userInfo = userInfo;
	[self.networkQueue addOperation:request];
	
	[self.networkQueue go];
}

- (void)fetchStarted:(ASIHTTPRequest *)request
{
	DLog(@"fetch started");
}

- (void)fetchCompleted:(ASIHTTPRequest *)request
{
	 NSDictionary *info = request.userInfo;
	
	[[NSNotificationCenter defaultCenter] postNotificationName:PerformanceFinishedDownloadingForFormat object:[info valueForKey:@"object"]];
	
	NSString *responseString = [request responseString];
	if ([responseString length] != 0)  {
		
		NSDate *now = [NSDate date];
		
		NSError *error = nil;
		NSString *format = [info valueForKey:@"object"];
		if ([format isEqualToString:@"XML"]) {
			
		} else if ([format isEqualToString:@"JSON"]) {
			
		} else if ([format isEqualToString:@"PLIST"]) {
			
		}
		
		SBJSON *json = [[[SBJSON alloc]init] autorelease];
		NSArray *people = (NSArray *)[[json objectWithString:responseString error:&error]valueForKey:@"people"];
		
		if (!error) {
			for (NSDictionary *personDict in people) {
				Person *person = [Person personWithDictionary:personDict managedObjectContext:self.managedObjectContext];
				person.lastModified = now;
			}
		}
		
		[[NSNotificationCenter defaultCenter] postNotificationName:PerformanceFinishedParsingForFormat object:[info valueForKey:@"object"]];
	}
	
	// should refetch content
	
	DLog(@"fetch complete");
}

- (void)fetchFailed:(ASIHTTPRequest *)request
{
	[self saveLastFetchedUrl:[request.originalURL absoluteString]];
	
	DLog(@"fetch failed");
}

- (void)queueFinished:(ASINetworkQueue *)queue
{
	DLog(@"queue finished");
}

@end
