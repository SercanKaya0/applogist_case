//
//  UserCacheHelper.swift
//  DataProvider
//
//  Created by Ercan Garip on 24.12.2021.
//

public struct UserCacheHelper {
    
    static let key = "userProfileCache"
    static let simpleDataKey = "userSimpleData"
    
    /*public static func save(_ value: Auth) {
         UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: key)
    }
    
    public static func saveUserSimpleData(_ value: Profile) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: simpleDataKey)
    }
    
    public static func get() -> Auth? {
        var userData: Auth?
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            userData = try? PropertyListDecoder().decode(Auth.self, from: data)
        }
        return userData
    }
    
    public static func getSimpleUserData() -> Profile? {
        var userSimpleData: Profile?
        if let data = UserDefaults.standard.value(forKey: simpleDataKey) as? Data {
            userSimpleData = try? PropertyListDecoder().decode(Profile.self, from: data)
        }
        return userSimpleData
    }*/
    
    /*public static func remove() {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.removeObject(forKey: simpleDataKey)
    }
    
    public static func has() -> Bool {
        if get() != nil {
            return true
        } else {
            return false
        }
    }*/
}
