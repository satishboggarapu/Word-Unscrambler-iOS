import FirebaseCore
import FirebaseAnalytics

public class FirebaseEvents {

    init() { }

    // ADS
    public func logAdLoaded() {
        Analytics.logEvent(LogKey.AD_LOADED, parameters: nil)
    }

    public func logAdClick() {
        Analytics.logEvent(LogKey.AD_CLICK, parameters: nil)
    }

    public func logAdFailedToLoad() {
        Analytics.logEvent(LogKey.AD_FAILED_TO_LOAD, parameters: nil)
    }
    
    // Unscramble
    public func logUnscramble() {
        Analytics.logEvent(LogKey.UNSCRAMBLE, parameters: nil)
        let defaults = UserDefaults.standard
        let currentCount = defaults.integer(forKey: UserDefaultsKeys.unscrambleWord.rawValue)
        defaults.set(currentCount+1, forKey: UserDefaultsKeys.unscrambleWord.rawValue)
    }

    // Words
    public func logAddedWordToFavorite() {
        Analytics.logEvent(LogKey.STARED, parameters: nil)
    }

    public func logRemovedWordFromFavorite() {
        Analytics.logEvent(LogKey.UN_STARED, parameters: nil)
    }
    
    public func logWebDefinitionsClick() {
        Analytics.logEvent(LogKey.WEB_DEFINITIONS_BUTTON_CLICK, parameters: nil)
    }

    public func logDefinitionClick() {
        Analytics.logEvent(LogKey.DEFINITION_BUTTON_CLICK, parameters: nil)
    }

    // Firebase Fetch
    public func logSuccessfulFirebaseFetch() {
        Analytics.logEvent(LogKey.FIREBASE_FETCH_SUCCESS, parameters: nil)
    }

    public func logFailedFirebaseFetch() {
        Analytics.logEvent(LogKey.FIREBASE_FETCH_FAILED, parameters: nil)
    }

    // Reviews
    public func logRequestedForAppReview() {
        Analytics.logEvent(LogKey.REQUESTED_APP_REVIEW, parameters: nil)
    }

    // In App Purchases
    public func logCheckIfAdsDisabled() {
        Analytics.logEvent(LogKey.CHECK_IF_DISABLE_ADS_IAP_PURCHASED, parameters: nil)
    }

    public func logSavePurchasedItemToKeychain(productId: String) {
        Analytics.logEvent(LogKey.SAVE_PURCHASED_ITEM_TO_KEYCHAIN, parameters: ["productId": productId])
    }

    public func logFailedToSavePurchasedItemToKeychain(productId: String, error: Error) {
        Analytics.logEvent(LogKey.FAILED_TO_SAVE_PURCHASED_ITEM_TO_KEYCHAIN,
                parameters: ["productId": productId, "error": error.localizedDescription])
    }

    public func logStartPurchaseOfDisableAds() {
        Analytics.logEvent(LogKey.START_PURCHASE_OF_DISABLE_ADS, parameters: nil)
    }

    public func logIAPDisabledOnDevice() {
        Analytics.logEvent(LogKey.IAP_DISABLED_ON_DEVICE, parameters: nil)
    }

    public func logIAPDisableAdsProductPurchased() {
        Analytics.logEvent(LogKey.IAP_DISABLE_ADS_PRODUCT_PURCHASED, parameters: nil)
    }

    public func logIAPDisableAdsProductPurchaseFailed() {
        Analytics.logEvent(LogKey.IAP_DISABLE_ADS_PRODUCT_PURCHASE_FAILED, parameters: nil)
    }
    
    public func logHiddingAdsInApp() {
        Analytics.logEvent(LogKey.HIDDING_ADS_IN_APP, parameters: nil)
    }
}
