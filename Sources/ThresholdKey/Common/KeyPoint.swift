//
//  Point.swift
//  tkey_ios
//
//  Created by David Main on 2022/11/01.
//

import Foundation
#if canImport(lib)
    import lib
#endif

public final class KeyPoint {
    public var pointer: OpaquePointer?
    
    public init(pointer: OpaquePointer) {
        self.pointer = pointer
    }
    
    public func getX() throws -> String {
        var errorCode: Int32 = -1
        let result = withUnsafeMutablePointer(to: &errorCode, { error in
            key_point_get_x(pointer, error)
                })
        guard errorCode == 0 else {
            throw RuntimeError("Error in KeyPoint, field X")
            }
        let x = String.init(cString: result!)
        string_free(result)
        return x
    }
    
    public func getY() throws -> String {
        var errorCode: Int32 = -1
        let result = withUnsafeMutablePointer(to: &errorCode, { error in
            key_point_get_x(pointer, error)
                })
        guard errorCode == 0 else {
            throw RuntimeError("Error in KeyPoint, field X")
            }
        let y = String.init(cString: result!)
        string_free(result)
        return y
    }
    
    public func getAsCompressedPublicKey(format: String) throws -> String {
        var errorCode: Int32 = -1
        
        let encoder_format = UnsafeMutablePointer<Int8>(mutating: ("elliptic-compressed" as NSString).utf8String)
        let result = withUnsafeMutablePointer(to: &errorCode, { error in
            key_point_encode(pointer, encoder_format, error)
        })
        guard errorCode == 0 else {
            throw RuntimeError("Error in KeyPoint, field Y")
            }
        let compressed = String.init(cString: result!)
        string_free(result)
        return compressed
    }
    
    deinit {
        key_point_free(pointer)
    }
}
