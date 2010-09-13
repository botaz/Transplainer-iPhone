#import <Foundation/Foundation.h>
#import "BaseServices.h"

typedef enum {
    XMLFormat,
	XMLTreeFormat,
    JSONFormat,    
    PLISTFormat
} DownloadFormat;   

@interface PerformanceServices : BaseServices <BaseServicesContentManagement> {

}

- (void)downloadPeopleUsingFormat:(DownloadFormat)downloadFormat;

+ (PerformanceServices *)sharedPerformanceServices;

@end
