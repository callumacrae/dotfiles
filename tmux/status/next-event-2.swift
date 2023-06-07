#!/usr/bin/env swift

import Darwin
import EventKit

let store = EKEventStore()
store.requestAccess(to: .event, completion: { granted, error in
  if (!granted) {
    print("Next event script unable to access calendar")
    print(error!)
    exit(1)
  }
})

let calendars = store.calendars(for: .event)

let from = Date.init()
let until = Date(timeIntervalSinceNow: 8 * 3600)
let predicate = store.predicateForEvents(withStart: from, end: until, calendars: calendars)
let events = store.events(matching: predicate)

var nextEvent: EKEvent? = nil
for event in events {
  if event.isAllDay {
    continue
  }

  if nextEvent == nil || event.compareStartDate(with: nextEvent!) == ComparisonResult.orderedAscending {
    let email = event.calendar!.title
    if event.attendees != nil, let selfAttendee = event.attendees!.first(where: { $0.name == email }) {
      if selfAttendee.participantStatus != .declined {
        nextEvent = event
      }
    }
  }
}

if nextEvent != nil, let title = nextEvent!.title, let startDate = nextEvent!.startDate {
  let hour = Calendar.current.component(.hour, from: startDate)
  if hour >= 18 {
    exit(0)
  }

  let minsUntil = startDate.timeIntervalSinceNow / 60

  let dateFormat = DateFormatter()
  dateFormat.dateFormat = "HH:mm"
  let time = dateFormat.string(from: startDate)

  let icon = " "
  let truncateTo = 21

  if minsUntil < 60 {
    var color = ""
    if minsUntil <= 0 {
      color = "#[fg=red] "
    } else if minsUntil <= 10 {
      color = "#[fg=yellow] "
    }

    var truncatedTitle = title
    if title.count > truncateTo {
      let index = title.index(title.startIndex, offsetBy: truncateTo - 2)
      truncatedTitle = String(title[...index]) + "…"
    }

    print(color + icon + time + " " + truncatedTitle)
  } else {
    print(icon + "#[fg=brightblack]" + time)
  }
}
