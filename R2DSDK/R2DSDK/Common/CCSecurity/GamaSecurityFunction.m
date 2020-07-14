

#import "GamaSecurityFunction.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation GamaBase64Encoding

#define ArrayLength(x) (sizeof(x)/sizeof(*(x)))

//这是一个静态的char数组，
static char gamaDecodingTable[128];

+ (void) initialize
{
    //一串char数组，用来初始化spDecodingTable
    char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    if (self == [GamaBase64Encoding class])
    {
        //把char 数组清零
        memset(gamaDecodingTable, 0, ArrayLength(gamaDecodingTable));
        //利用 encodingTable，循环初始化，gamaDecodingTable 数组的一部分char，值是xxx
        for (NSInteger i = 0; i < ArrayLength(encodingTable); i++)
        {
            gamaDecodingTable[encodingTable[i]] = i;
        }
    }
}

+ (NSString*) encode:(const uint8_t*) input length:(NSInteger) length
{
    char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    // 声明一个可变的OC数据
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    //uint8_t 你会发现是一个unsign char；但是，这里还有一个*
    uint8_t * output = (uint8_t*)data.mutableBytes;
    
    //注意这个循环，每次跳跃仨
    for (NSInteger i = 0; i < length; i += 3)
    {
        NSInteger value = 0;
        for (NSInteger j = i; j < (i + 3); j++)
        {
            value <<= 8;
            
            if (j < length)
            {
                value |= (0xFF & input[j]);
            }
        }
        NSInteger index = (i / 3) * 4;
        output[index + 0] =                    encodingTable[(value >> 18) & 0x3F];
        output[index + 1] =                    encodingTable[(value >> 12) & 0x3F];
        output[index + 2] = (i + 1) < length ? encodingTable[(value >> 6)  & 0x3F] : '=';
        output[index + 3] = (i + 2) < length ? encodingTable[(value >> 0)  & 0x3F] : '=';
    }
    //他妈，之前没有autorelease，函数返回值，一定记得autorelease，内存不能坑爹有木有
    return [[NSString alloc] initWithData:data
                                  encoding:NSASCIIStringEncoding];
}

+ (NSString*) encode:(NSData*) rawBytes
{
    return [self encode:(const uint8_t*) rawBytes.bytes length:rawBytes.length];
}

+ (NSData*) decode:(const char*) string length:(NSInteger) inputLength
{
    //如果字符串为空，或者长度不是4的整数倍，直接返回空。
    if ((string == NULL) || (inputLength % 4 != 0)) {
        return nil;
    }
    //去掉字符串后面的所有“＝”
    while (inputLength > 0 && string[inputLength - 1] == '=') {
        inputLength--;
    }
    
    NSInteger outputLength = inputLength * 3 / 4;
    NSMutableData* data = [NSMutableData dataWithLength:outputLength];
    uint8_t* output = data.mutableBytes;
    
    NSInteger inputPoint = 0;
    NSInteger outputPoint = 0;
    while (inputPoint < inputLength)
    {
        char i0 = string[inputPoint++];
        char i1 = string[inputPoint++];
        char i2 = inputPoint < inputLength ? string[inputPoint++] : 'A';
        char i3 = inputPoint < inputLength ? string[inputPoint++] : 'A';
        output[outputPoint++] = (gamaDecodingTable[i0] << 2) | (gamaDecodingTable[i1] >> 4);
        if (outputPoint < outputLength)
        {
            output[outputPoint++] = ((gamaDecodingTable[i1] & 0xf) << 4) | (gamaDecodingTable[i2] >> 2);
        }
        if (outputPoint < outputLength)
        {
            output[outputPoint++] = ((gamaDecodingTable[i2] & 0x3) << 6) | gamaDecodingTable[i3];
        }
    }
    return data;
}

+ (NSData*) decode:(NSString*) string
{
    return [self decode:[string cStringUsingEncoding:NSASCIIStringEncoding] length:string.length];
}

@end



@implementation NSData (GamaAES128)

- (NSData *)gama_AES128Operation:(CCOperation)operation key:(NSString *)key iv:(NSString *)iv
{
    //一个char数组，kCCKeySizeAES128 ＝ 16
    char keyPtr[kCCKeySizeAES128 + 1];
    //把数组全部设置为0，
    memset(keyPtr, 0, sizeof(keyPtr));
    //把NSString存放到字符数组里面，字符数组最多是16位
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    //创建一个字符数组，kCCBlockSizeAES128 ＝ 16
    char ivPtr[kCCBlockSizeAES128 + 1];
    //把字符数组全部值为 0
    memset(ivPtr, 0, sizeof(ivPtr));
    //把NSString 放进字符数组里面，最多16位 17位的话，最后一个不晓得要不要存放"\0"
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    //取出要加密的数据的长度
    NSUInteger dataLength = [self length];
    //把该长度加上 kCCBlockSizeAES128 ＝ 16
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    //从内存中开辟一个bufferSize大小的空间，指针给buffer （void *） 任意类型
    void * buffer = malloc(bufferSize);
    
    //numBytesCrypted 接收加密解密后的数据的长度
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          ivPtr,
                                          [self bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess)
    {
        //注意，此时的buffer是一个局部变量
        NSData * cryptData=[NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        //这里的buffer没有free哦
        return cryptData;
    }
    //buffer是malloc出来的，要释放掉
    free(buffer);
    return nil;
}

- (NSData *)gama_AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv
{
    return [self gama_AES128Operation:kCCEncrypt key:key iv:iv];
}

- (NSData *)gama_AES128DecryptWithKey:(NSString *)key iv:(NSString *)iv
{
    return [self gama_AES128Operation:kCCDecrypt key:key iv:iv];
}

@end
