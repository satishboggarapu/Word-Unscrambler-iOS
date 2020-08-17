import UIKit

public class Constraints {

    init() { }

    public static func getInstance() -> Constraints {
        switch Device.type {
        case .iPhoneSE:
            return iPhoneSEConstraints()
        case .iPhoneXR:
            return iPhoneXRConstraints()
        case .iPhoneXSMax:
            return iPhoneXSMaxConstraints()
//        case .iPadPro9_2048:
//        <#code#>
//        case .iPadPro10_2388:
//        <#code#>
//        case .iPadPro12_2732:
//        <#code#>
        default:
            return Constraints()
        }
    }

    // MARK: General

    /// Font size for TitleLabel in NavigationBar
    internal var navigationBarTitleFontSize: CGFloat {
        return 32
    }

    /// Space width between Favorite button and Info button in MainViewController
    internal var navigationBarSpaceWidth: CGFloat {
        return 16
    }

    /// Height of banner ads throughout the app
    internal var bannerAdHeight: CGFloat {
        return 64
    }

    // MARK: MainViewController

    /// Font size for TextField in MainViewController
    internal var mainVCSearchTextFieldFontSize: CGFloat {
        return 24
    }

    /// Font size for results label in MainViewController
    internal var mainVCResultsLabelFontSize: CGFloat {
        return 20
    }

    /// Font size for title label in CollapsibleTableViewHeader
    internal var mainVCTableViewHeaderTitleLabelFontSize: CGFloat {
        return 20
    }

    // MARK: DefinitionViewController

    /// Font size for Title label in DefinitionViewController
    internal var definitionVCTitleLabelFontSize: CGFloat {
        return 28
    }

    /// Font size for Phonetic label in DefinitionViewController
    internal var definitionVCPhoneticLabelFontSize: CGFloat {
        return 20
    }

    // MARK: WebDefinitionsViewController

    /// Font size for Title label in WebDefinitionsViewController
    internal var webDefinitionsVCTitleLabelFontSize: CGFloat {
        return 22
    }

    // MARK: InfoViewController

    /// Margin between version label and share button in InfoViewController
    internal var infoVCShareButtonTopMargin: CGFloat {
        return 72
    }

    /// Margin between buttons in InfoViewController
    internal var infoVCButtonMargin: CGFloat {
        return 36
    }

    // MARK: FeedbackViewController

    /// Font size for text in FeedbackViewController
    internal var feedbackVCTextFontSize: CGFloat {
        return 24
    }
}