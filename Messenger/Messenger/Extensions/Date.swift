//
//  Date.swift
//  Messenger
//
//  Created by 정정욱 on 3/18/24.
//


import Foundation

/*
 메시지가 같은날 전송된거라면 전송된 시간을 표시하고 싶을 것임
 그러나 메시가 모두 다른날에 전송된 것이라면 실제 날짜를 표시하고 싶을 것임
 */
extension Date {
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateFormat = "HH:mm"
        return formatter
    }

    private var dayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateFormat = "MM/dd/yy"
        return formatter
    }

    private func timeString() -> String {
        return timeFormatter.string(from: self)
    }

    private func dateString() -> String {
        return dayFormatter.string(from: self)
    }

    func timestampString() -> String {
        if Calendar.current.isDateInToday(self) {
            return timeString() // 하루 이내라면 시간을 반환
        } else if Calendar.current.isDateInYesterday(self) {
            return "Yesterday" // 어제라면 해당 문자열을 반환
        } else {
            return dateString() // 어제 이상이라면 날짜 문자열을 반환 
        }
    }
}
