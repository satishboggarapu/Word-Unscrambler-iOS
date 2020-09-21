import Foundation

public class LogKey {

    // Ads
    public static let AD_LOADED = "my_ad_loaded"
    public static let AD_CLICK = "my_ad_click"
    public static let AD_FAILED_TO_LOAD = "ad_failed_to_load"

    // Words
    public static let UNSCRAMBLE = "unscramble"
    public static let STARED = "stared_word"
    public static let UN_STARED = "un_stared_word"
    public static let WEB_DEFINITIONS_BUTTON_CLICK = "web_definitions_click"
    public static let DEFINITION_BUTTON_CLICK = "definition_click"

    // Firebase fetch definitions
    public static let FIREBASE_FETCH_SUCCESS = "definition_fetch_success"
    public static let FIREBASE_FETCH_FAILED = "definition_fetch_failed"

    // In app reviews
    public static let REQUESTED_APP_REVIEW = "requested_app_review"

    // In App Purchases
    public static let CHECK_IF_DISABLE_ADS_IAP_PURCHASED = "is_disable_ads"
    public static let SAVE_PURCHASED_ITEM_TO_KEYCHAIN = "purchased_item_saved_to_keychain"
    public static let FAILED_TO_SAVE_PURCHASED_ITEM_TO_KEYCHAIN = "purchased_item_failed_to_save_to_keychain"
    public static let START_PURCHASE_OF_DISABLE_ADS = "start_purchase_of_disable_ads"
    public static let IAP_DISABLED_ON_DEVICE = "iap_disabled_on_device"
    public static let IAP_DISABLE_ADS_PRODUCT_PURCHASED = "iap_disable_ads_product_purchased"
    public static let IAP_DISABLE_ADS_PRODUCT_PURCHASE_FAILED = "iap_disable_ads_product_purchase_failed"
    public static let HIDDING_ADS_IN_APP = "hidding_ads_in_app"
}
