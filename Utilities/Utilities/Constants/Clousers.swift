//
//  Clousers.swift
//  Utilities
//
//  Created by Sercan Kaya on 25.11.2021.
//
/**
 Define global closures
 */
public typealias VoidClosure = (() -> Void)
public typealias StringClosure = ((String) -> Void)
public typealias OptionalStringClosure = ((String?) -> Void)
public typealias IndexPathClosure = ((IndexPath) -> Void)
public typealias IntClosure = ((Int) -> Void)
public typealias DoubleClosure = ((Double) -> Void)
public typealias DateClosure = ((Date) -> Void)
public typealias AnyClosure<T: Any> = ((T) -> Void)
public typealias NullableAnyClosure<T: Any> = ((T?) -> Void)
public typealias ArrayClosure<T: Any> = (([T]) -> Void)
public typealias BoolClosure = ((Bool) -> Void)
