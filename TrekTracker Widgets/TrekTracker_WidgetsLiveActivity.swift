//
//  TrekTracker_WidgetsLiveActivity.swift
//  TrekTracker Widgets
//
//  Created by Neel P on 6/24/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct TrekTracker_WidgetsAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct TrekTracker_WidgetsLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TrekTracker_WidgetsAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension TrekTracker_WidgetsAttributes {
    fileprivate static var preview: TrekTracker_WidgetsAttributes {
        TrekTracker_WidgetsAttributes(name: "World")
    }
}

extension TrekTracker_WidgetsAttributes.ContentState {
    fileprivate static var smiley: TrekTracker_WidgetsAttributes.ContentState {
        TrekTracker_WidgetsAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: TrekTracker_WidgetsAttributes.ContentState {
         TrekTracker_WidgetsAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: TrekTracker_WidgetsAttributes.preview) {
   TrekTracker_WidgetsLiveActivity()
} contentStates: {
    TrekTracker_WidgetsAttributes.ContentState.smiley
    TrekTracker_WidgetsAttributes.ContentState.starEyes
}
