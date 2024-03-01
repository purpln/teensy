#include <stddef.h>
#include <stdlib.h>

#include "Types.h"
#include "Visibility.h"

SWIFT_RUNTIME_ABI
HeapObject *swift_retain(HeapObject *object) { return object; }

SWIFT_RUNTIME_ABI
void swift_release(HeapObject *object) {}

SWIFT_RUNTIME_ABI
void *swift_allocObject(void *type, size_t size, size_t alignMask) {}

SWIFT_RUNTIME_ABI
void swift_deallocObject(void *obj, size_t size, size_t alignMask) {}
/*
SWIFT_RUNTIME_ABI
void *swift_slowAlloc(size_t bytes, size_t alignMask) {
    void *p = malloc(bytes);
    return p;
}
*/
SWIFT_RUNTIME_ABI
void swift_slowDealloc(void *ptr, size_t bytes, size_t alignMask) {
    free(ptr);
}
