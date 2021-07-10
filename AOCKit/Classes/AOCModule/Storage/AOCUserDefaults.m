//
//  AOCUserDefaults.m
//  AOCKit
//
//  Created by pan on 2021/7/10.
//

#import "AOCUserDefaults.h"
#import <objc/runtime.h>

@interface AOCUserDefaults ()

@property (nonatomic, strong) NSUserDefaults *userDefaults;     // 本地存储类
@property (nonatomic, strong) NSMutableDictionary *accessorDic; // 存取方法名称
@end

@implementation AOCUserDefaults

#pragma mark - Initial

+ (instancetype)standardDefaults {
    static AOCUserDefaults *defaults;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaults = [[self alloc] init];
    });
    return defaults;
}

- (instancetype)init {
    if (self = [super init]) {
        NSDictionary *registration = [self registrationDictionary];
        if (registration.count > 0) {
            NSMutableDictionary *mutableDefaults = [NSMutableDictionary dictionaryWithCapacity:[registration count]];
            for (NSString *key in registration) {
                id value = [registration objectForKey:key];
                NSString *transformedKey = [NSString stringWithFormat:@"%@_%@", [self prefixForKey], key];
                [mutableDefaults setObject:value forKey:transformedKey];
            }
            [self.userDefaults registerDefaults:registration];
        }
        [self generateAccessorMethods];
    }
    return self;
}

- (NSUserDefaults *)userDefaults {
    if (_userDefaults == nil) {
        NSString *suiteName = [self suiteNameForUserDefaults];
        if (suiteName.length > 0) {
            _userDefaults = [[NSUserDefaults alloc] initWithSuiteName:suiteName];
        } else {
            _userDefaults = [NSUserDefaults standardUserDefaults];
        }
    }
    return _userDefaults;
}

- (NSMutableDictionary *)accessorDic {
    if (_accessorDic == nil) {
        _accessorDic = [NSMutableDictionary dictionary];
    }
    return _accessorDic;
}

#pragma mark - Public

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wundeclared-selector"
#pragma GCC diagnostic ignored "-Warc-performSelector-leaks"

- (NSString *)suiteNameForUserDefaults {
    if ([self respondsToSelector:@selector(_suiteNameForUserDefaults)]) {
        return [self performSelector:@selector(_suiteNameForUserDefaults)];
    }
    return @"";
}

- (NSDictionary<NSString *,id> *)registrationDictionary {
    if ([self respondsToSelector:@selector(_registrationDictionary)]) {
        return [self performSelector:@selector(_registrationDictionary)];
    }
    return @{};
}

- (NSString *)prefixForKey {
    if ([self respondsToSelector:@selector(_prefixForKey)]) {
        return [self performSelector:@selector(_prefixForKey)];
    }
    return @"AOCKit_UserDefaults";
}

- (NSDictionary<NSString *,NSString *> *)replacedKeysFromPropertyName {
    if ([self respondsToSelector:@selector(_replacedKeysFromPropertyName)]) {
        return [self performSelector:@selector(_replacedKeysFromPropertyName)];
    }
    return @{};
}

- (NSDictionary<NSString *,NSString *> *)replacedClassFromClassName {
    if ([self respondsToSelector:@selector(_replacedClassFromClassName)]) {
        return [self performSelector:@selector(_replacedClassFromClassName)];
    }
    return @{};
}

#pragma GCC diagnostic pop

enum TypeEncodings {
    Char                = 'c',
    Bool                = 'B',
    Short               = 's',
    Int                 = 'i',
    Long                = 'l',
    LongLong            = 'q',
    UnsignedChar        = 'C',
    UnsignedShort       = 'S',
    UnsignedInt         = 'I',
    UnsignedLong        = 'L',
    UnsignedLongLong    = 'Q',
    Float               = 'f',
    Double              = 'd',
    Object              = '@'
};

#pragma mark - Create Setter & Getter

- (void)generateAccessorMethods {
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i ++) {
        objc_property_t property = propertyList[i];
        const char *name = property_getName(property);
        const char *attributes = property_getAttributes(property);
        
        char *getter = strstr(attributes, ",G");
        if (getter) {
            getter = strdup(getter + 2);
            getter = strsep(&getter, ",");
        } else {
            getter = strdup(name);
        }
        SEL getterSel = sel_registerName(getter);
        free(getter);

        char *setter = strstr(attributes, ",S");
        if (setter) {
            setter = strdup(setter + 2);
            setter = strsep(&setter, ",");
        } else {
            asprintf(&setter, "set%c%s:", toupper(name[0]), name + 1);
        }
        SEL setterSel = sel_registerName(setter);
        free(setter);
        
        NSString *key = [self propertyKeyForPropertyNamed:name];
        [self.accessorDic setValue:key forKey:NSStringFromSelector(getterSel)];
        [self.accessorDic setValue:key forKey:NSStringFromSelector(setterSel)];        
        
        IMP getterImp = NULL;
        IMP setterImp = NULL;
        char type = attributes[1];
        switch (type) {
            case Short:
            case Long:
            case LongLong:
            case UnsignedChar:
            case UnsignedShort:
            case UnsignedInt:
            case UnsignedLong:
            case UnsignedLongLong:
                getterImp = (IMP)longLongGetter;
                setterImp = (IMP)longLongSetter;
                break;

            case Bool:
            case Char:
                getterImp = (IMP)boolGetter;
                setterImp = (IMP)boolSetter;
                break;

            case Int:
                getterImp = (IMP)integerGetter;
                setterImp = (IMP)integerSetter;
                break;

            case Float:
                getterImp = (IMP)floatGetter;
                setterImp = (IMP)floatSetter;
                break;

            case Double:
                getterImp = (IMP)doubleGetter;
                setterImp = (IMP)doubleSetter;
                break;

            case Object:
                getterImp = (IMP)objectGetter;
                setterImp = (IMP)objectSetter;
                break;

            default:
                free(propertyList);
                [NSException raise:NSInternalInconsistencyException format:@"Unsupported type of property \"%s\" in class %@", name, self];
                break;
        }

        char types[5];

        snprintf(types, 4, "%c@:", type);
        class_addMethod([self class], getterSel, getterImp, types);
        
        snprintf(types, 5, "v@:%c", type);
        class_addMethod([self class], setterSel, setterImp, types);
    }

    free(propertyList);
}

- (NSString *)propertyKeyForPropertyNamed:(char const *)propertyName {
    NSString *key = [NSString stringWithUTF8String: propertyName];
    NSString *replacedKey = [self replacedKeysFromPropertyName][key];
    if (replacedKey) {
        return [NSString stringWithFormat:@"%@_%@", [self prefixForKey], replacedKey];
    }
    return [NSString stringWithFormat:@"%@_%@", [self prefixForKey], key];
}

- (NSString *)defaultsKeyForSelector:(SEL)selector {
    return [self.accessorDic objectForKey:NSStringFromSelector(selector)];
}

static long long longLongGetter(AOCUserDefaults *self, SEL _cmd) {
    NSString *key = [self defaultsKeyForSelector:_cmd];
    return [[self.userDefaults objectForKey:key] longLongValue];
}

static void longLongSetter(AOCUserDefaults *self, SEL _cmd, long long value) {
    NSString *key = [self defaultsKeyForSelector:_cmd];
    NSNumber *object = [NSNumber numberWithLongLong:value];
    [self.userDefaults setObject:object forKey:key];
}

static bool boolGetter(AOCUserDefaults *self, SEL _cmd) {
    NSString *key = [self defaultsKeyForSelector:_cmd];
    return [self.userDefaults boolForKey:key];
}

static void boolSetter(AOCUserDefaults *self, SEL _cmd, bool value) {
    NSString *key = [self defaultsKeyForSelector:_cmd];
    [self.userDefaults setBool:value forKey:key];
}

static int integerGetter(AOCUserDefaults *self, SEL _cmd) {
    NSString *key = [self defaultsKeyForSelector:_cmd];
    return (int)[self.userDefaults integerForKey:key];
}

static void integerSetter(AOCUserDefaults *self, SEL _cmd, int value) {
    NSString *key = [self defaultsKeyForSelector:_cmd];
    [self.userDefaults setInteger:value forKey:key];
}

static float floatGetter(AOCUserDefaults *self, SEL _cmd) {
    NSString *key = [self defaultsKeyForSelector:_cmd];
    return [self.userDefaults floatForKey:key];
}

static void floatSetter(AOCUserDefaults *self, SEL _cmd, float value) {
    NSString *key = [self defaultsKeyForSelector:_cmd];
    [self.userDefaults setFloat:value forKey:key];
}

static double doubleGetter(AOCUserDefaults *self, SEL _cmd) {
    NSString *key = [self defaultsKeyForSelector:_cmd];
    return [self.userDefaults doubleForKey:key];
}

static void doubleSetter(AOCUserDefaults *self, SEL _cmd, double value) {
    NSString *key = [self defaultsKeyForSelector:_cmd];
    [self.userDefaults setDouble:value forKey:key];
}

static id objectGetter(AOCUserDefaults *self, SEL _cmd) {
    NSString *key = [self defaultsKeyForSelector:_cmd];
    id myEncodedObject = [self.userDefaults objectForKey:key];
    if ([myEncodedObject isKindOfClass:[NSString class]]) {
        return myEncodedObject;
        
    } else if ([myEncodedObject isKindOfClass:[NSData class]]) {
        NSDictionary *dic = [self replacedClassFromClassName];
        [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            Class replacedClass = NSClassFromString(obj);
            if (replacedClass != nil) {
                [NSKeyedUnarchiver setClass:replacedClass forClassName:key];
            }
        }];
        id model = [NSKeyedUnarchiver unarchiveObjectWithData: myEncodedObject];
        return model;
    } else {
        return myEncodedObject;
    }
}

static void objectSetter(AOCUserDefaults *self, SEL _cmd, id object) {
    NSString *key = [self defaultsKeyForSelector:_cmd];
    if (object) {
        if ([object isKindOfClass:[NSString class]]) {
            [self.userDefaults setObject:object forKey:key];
        } else {
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
            [self.userDefaults setObject:data forKey:key];
        }
    } else {
        [self.userDefaults removeObjectForKey:key];
    }
}

@end
