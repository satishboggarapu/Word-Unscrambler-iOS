import Foundation
import UIKit

public enum Device {
    case iPhoneSE
    case iPhoneNormal
    case iPhonePlus
    case iPhoneX
    case iPhoneXR
    case iPhoneXSMax

    case iPadPro9_2048
    case iPadPro10_2388
    case iPadPro12_2732

    static var type: Device {
        switch UIScreen.main.nativeBounds.height {
        case 1136:
            return .iPhoneSE
        case 1334:
            return .iPhoneNormal
        case 1792:
            return .iPhoneXR
        case 2208:
            return .iPhonePlus
        case 1920:
            return .iPhonePlus
        case 2436:
            return .iPhoneX
        case 2688:
            return .iPhoneXSMax
        case 2048:
            return .iPadPro9_2048
        case 2388:
            return .iPadPro10_2388
        case 2732:
            return .iPadPro12_2732
        default:
            return .iPhoneNormal
        }
    }

    static var isDeviceIPad: Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    }

    static var hasNotch: Bool {
        switch type {
        case .iPhoneX, .iPhoneXR, iPhoneXSMax:
            return true
        default:
            return false
        }
    }

}