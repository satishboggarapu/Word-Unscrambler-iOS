import Foundation
import StoreKit

class StoreReviewManager {

    private let minimumDaysSinceLastReview = 90
    private let minimumUnscrambledWordsCount = 10
    private let firebaseEvents: FirebaseEvents!

    init() {
        firebaseEvents = FirebaseEvents()
    }

    private var unscrambledWords: Int {
        get {
            UserDefaults.standard.integer(forKey: UserDefaultsKeys.unscrambleWord.rawValue)
        }
    }

    private var lastDatePromptedUser: Date {
        get {
            UserDefaults.standard.object(forKey: UserDefaultsKeys.lastDateReviewPrompted.rawValue) as? Date ?? Date().daysAgo(minimumDaysSinceLastReview + 1)
        }
    }

    private var lastVersionPromptedForReview: String? {
        get {
            UserDefaults.standard.string(forKey: UserDefaultsKeys.lastVersionPromptedForReview.rawValue)
        }
    }

    func askForReview(_ navigationController: UINavigationController?) {
        guard let navigationController = navigationController else { return }

        if #available(iOS 10.3, *) {
            let oldTopViewController = navigationController.topViewController
            let currentVersion = getCurrentAppVersion()
            let count = unscrambledWords

            // Has the task/process been completed several times and the user has not already been prompted for this version?
            if count >= minimumUnscrambledWordsCount &&
                       currentVersion != lastVersionPromptedForReview &&
                       lastDatePromptedUser <= Date().daysAgo(minimumDaysSinceLastReview) {
                firebaseEvents.logRequestedForAppReview()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    if navigationController.topViewController == oldTopViewController {
                        SKStoreReviewController.requestReview()
                        UserDefaults.standard.set(currentVersion, forKey: UserDefaultsKeys.lastVersionPromptedForReview.rawValue)
                        UserDefaults.standard.set(Date(), forKey:UserDefaultsKeys.lastDateReviewPrompted.rawValue)
                    }
                }
            }
        }
    }

    private func getCurrentAppVersion() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
        let build = dictionary["CFBundleVersion"] as! String
        return "\(version).\(build)"
    }
}