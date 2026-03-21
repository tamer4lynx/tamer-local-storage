import Foundation
import Lynx

@objcMembers
public final class NativeLocalStorageModule: NSObject, LynxModule {

    @objc public static var name: String {
        return "NativeLocalStorageModule"
    }

    @objc public static var methodLookup: [String: String] {
        return [
            "setStorageItem": NSStringFromSelector(#selector(setStorageItem(_:_:))),
            "getStorageItem": NSStringFromSelector(#selector(getStorageItem(_:callback:))),
            "clearStorage": NSStringFromSelector(#selector(clearStorage))
        ]
    }

    private static let suiteName = "com.nanofuxion.tamer.localstorage"
    private var userDefaults: UserDefaults

    @objc public init(param: Any) {
        userDefaults = UserDefaults(suiteName: Self.suiteName) ?? UserDefaults.standard
        super.init()
    }

    @objc public override init() {
        userDefaults = UserDefaults(suiteName: Self.suiteName) ?? UserDefaults.standard
        super.init()
    }

    @objc public func setStorageItem(_ key: String, _ value: String) {
        userDefaults.set(value, forKey: key)
    }

    @objc public func getStorageItem(_ key: String, callback: @escaping (String) -> Void) {
        let value = userDefaults.string(forKey: key) ?? ""
        callback(value)
    }

    @objc public func clearStorage() {
        let dictionary = userDefaults.dictionaryRepresentation()
        dictionary.keys.forEach { userDefaults.removeObject(forKey: $0) }
    }
}
