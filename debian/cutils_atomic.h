#ifndef DEBIAN_ANDROID_CUTILS_ATOMIC_H
#define DEBIAN_ANDROID_CUTILS_ATOMIC_H

#include <stdint.h>

int32_t android_atomic_inc(volatile int32_t* addr);
int32_t android_atomic_dec(volatile int32_t* addr);
int32_t android_atomic_add(int32_t value, volatile int32_t* addr);
int32_t android_atomic_and(int32_t value, volatile int32_t* addr);
int32_t android_atomic_or(int32_t value, volatile int32_t* addr);
int32_t android_atomic_acquire_load(volatile const int32_t* addr);
int32_t android_atomic_release_load(volatile const int32_t* addr);
void android_atomic_acquire_store(int32_t value, volatile int32_t* addr);
void android_atomic_release_store(int32_t value, volatile int32_t* addr);
int android_atomic_acquire_cas(int32_t oldvalue, int32_t newvalue,
                               volatile int32_t* addr);
int android_atomic_release_cas(int32_t oldvalue, int32_t newvalue,
                               volatile int32_t* addr);
void android_compiler_barrier(void);
void android_memory_barrier(void);

#define android_atomic_write android_atomic_release_store
#define android_atomic_cmpxchg android_atomic_release_cas

#endif //DEBIAN_ANDROID_CUTILS_ATOMIC_H