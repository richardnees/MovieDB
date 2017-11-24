//: Playground - noun: a place where people can play

import Cocoa


Array(0...1000).forEach {
    print("\($0) - \(HTTPURLResponse.localizedString(forStatusCode: $0))")
}

