//
//  DateFormats.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import Foundation

/// Date format list
enum DateFormats: String {
    case dateTimeServer = "yyyy-MM-dd HH:mm:ss"
    case dateTimeServerSSS = "yyyy-MM-dd HH:mm:ss.SSS"
    case dateTimeServerSSSSSS = "yyyy-MM-dd HH:mm:ss.SSSSSS"
    case dateTimeServerFull = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    case dateTimeServerUTCZero = "yyyy-MM-dd'T'HH:mm:ss.'000Z'"
    case fullDate = "dd MMM,EE"
    case date = "yyyy/MM/dd"
    case shortDate = "dd MMM"
    case middleMonthDate = "MMM d"
    case veryShortMonthYear = "M yyyy"
    case shortSingleDate = "d MMM"
    case weekDate = "EEEE, dd MMM"
    case shortWeekDate = "E, dd MMM"
    case time = "hh:mm a"
    case shortTime = "h:mm a"
    case short24hTime = "HH:mm"
    case full24Time = "HH:mm:ss"
    case monthYear = "MMM yyyy"
    case dayInWeek = "LLLL"
    case dateServer = "yyyy-MM-dd"
    case year = "yyyy"
    case day = "d"
    case dateMonthYear = "dd MMM yyyy"
    case dateMonthYearSlash = "dd/MM/yyyy"
    case versionDate = "'.'yyyyMMddHHmmss"
    case latestSyncDateTime = "MM/dd/yyyy, HH:mm"
    case dateTimeSendMail = "yyyyMMddHHmmss"
    case dateMonthYearTime = "dd MMM yyyy h:mm a"
}
