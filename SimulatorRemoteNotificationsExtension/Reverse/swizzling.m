#import <objc/runtime.h>

void __attribute__((weak)) MethodSwizzle(Class c, SEL origSEL, SEL overrideSEL, IMP overrideIMP) {
    Method origMethod = class_getInstanceMethod(c, origSEL);
    
    class_addMethod(c, overrideSEL, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    class_replaceMethod(c, origSEL, overrideIMP, method_getTypeEncoding(origMethod));
}