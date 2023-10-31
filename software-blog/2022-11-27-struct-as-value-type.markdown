---
layout: post
title: "Swift: structs as value types"
date: 2022-11-27 12:00:00 -0600
category: software 
---

~or~ what happens when you mutate a Swift struct?

Of course Swift has classes and OOP. However the humble `struct` should be your go-to type when you want to group some values and methods together in Swift.

A struct is a *value* type. Not a *reference* type. Let's dig into what it means when a `struct` get mutated or assigned. It might not be what you expect if you're coming from a language where most types are *reference* types.

An important concept I will use is pointers. Under the hood a variable will "point" to a memory address. We can reveal the value of a variable's starting memory address with the `&` operator, which dates all the way back to the language C.

As I manipulate structs in the following code, I want to see what's happening in memory.

- Is existing memory being overwritten? => the pointer value stays constant.
- Or are values being copied to a new place in memory => the variable's pointer changed.

# Struct mutability deep-dive

The following demonstrates what it really means to be a *value* type.

We have a `Coordinate` type with mutable variables. As a side-effect, we can mutate these variables in specific ways using two `mutating` methods: `moveNorth()` and `assignCopy()`. (Heads up `assignCopy()` is useless, but I wrote it because I was curious how it would behave at the memory level).

Swift's `mutating` keyword is interesting. Unlike methods of a class, you must opt-in to self-mutating methods of a Swift struct.

And a consumer of the struct can choose to restrict these methods if they declare the struct as a `let` constant. This feels very differnt to a class / *reference* type where as long as you don't *reassign* the class variable, you can mutate the internals of the class to your heart's content.

```
struct Coordinate {
	var x: Float
	var y: Float

    mutating func moveNorth() {
        y -= 1
        print(y)
    }

    mutating func assignCopy() {
        self = Coordinate(x: x, y:y)
    }
}

var coord = Coordinate(x: 1, y: 1)
var coordCopy = coord
```

We've declared `coord` and `coordCopy`. If these were *reference* types, we'd expect the variables to have the same pointer. Is that the case for a struct?

```
print(UnsafeRawPointer(&coord)) // Take note of this address
print(UnsafeRawPointer(&coordCopy)) // Different address
```
No, `coordCopy` is truly a discrete copy.

What happens if we mutate `coord`? Does the address change?

```
coord.moveNorth()
print(UnsafeRawPointer(&coord)) // Same address

coord.assignCopy()
print(UnsafeRawPointer(&coord)) // Same address
```
No. We are mutating the existing block of memory. The address is fixed.

I wrote `assignCopy()` to test the hypothesis that calling an initializer would write to different memory and change the variable's pointer. Not so. The Swift compiler is clever enough to overwrite the existing memory directly.

## Swift arrays are structs

It's also interesting to look at the mutable behavior of an array...

```
var arr = Array(repeating: 0, count: 10)
var arrCopy = arr
print(UnsafeRawPointer(&arr))
print(UnsafeRawPointer(&arrCopy)) // different address
```
Like with any struct, we don't share references to arrays. Attempting to reassign an array results in a fresh copy of the memory at a new address. (Copying arrays therefore takes linear time and requires linear memory complexity. However this is often balanced out by the relative speed of stack allocation vs heap allocation. But that's a topic for another article)

If you're familiar with arrays under the hood, you know they are contiguous blocks of fixed-width memory and they aren't dynamic (as in can't be easily resized in memory).

So what happens when you exceed the allocated capacity of an array? In most languages, Swift included, a new array of memory is allocated with double the capacity and the existing values are copied over. This operation happens in linear time, O(N).

You can see the array double in size below:

```
var arr = Array(repeating: 0, count: 10)
print(arr.capacity) // 10
arr.append(0) // there's no allocated space for this additional value
print(UnsafeRawPointer(&arr)) // new address !!
print(arr.capacity) // 20. The append was possible because the items were copied to a newly allocated block of memory
```
Whereas a normal struct will overwrite memory whenever possible (usually because the Automatic Reference Counter has a value of 1 reference to the struct, so a mutation won't cause any suprises), resizing an array requires that we allocate a new block of memory elsewhere. So this is an example where not only the memory was mutated with `append()`, the pointer value changed as well.

## In conclusion

The big takeaway is that mutability of structs, or a *value* types in general, involves more than just the variable's pointer aka reference.

Whenever possible, Swift will overwrite existing memory when mutating a struct, and will make a new copy if you try to assign a *value* type to an additional variable.

Only if absolutely necesarray will the Swift compiler reassign the pointer value of a struct variable.
