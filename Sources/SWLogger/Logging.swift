/*
* Copyright 2015 Coodly LLC
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

import Foundation

public class Logging: @unchecked Sendable {
    private let name: String
    public init(name: String) {
        self.name = name
    }
    
    public func info<T: Sendable>(_ object: T, file: String = #file, function: String = #function, line: Int = #line, extra: (@Sendable (Logging) -> Void)? = nil) {
        sendMessage(object, file: file, function: function, line: line, at: .info, extra: extra)
    }

    public func debug<T: Sendable>(_ object: T, file: String = #file, function: String = #function, line: Int = #line, extra: (@Sendable (Logging) -> Void)? = nil) {
        sendMessage(object, file: file, function: function, line: line, at: .debug, extra: extra)
    }
    
    public func error<T: Sendable>(_ object: T, file: String = #file, function: String = #function, line: Int = #line, extra: (@Sendable (Logging) -> Void)? = nil) {
        sendMessage(object, file: file, function: function, line: line, at: .error, extra: extra)
    }

    public func verbose<T: Sendable>(_ object: T, file: String = #file, function: String = #function, line: Int = #line, extra: (@Sendable (Logging) -> Void)? = nil) {
        sendMessage(object, file: file, function: function, line: line, at: .verbose, extra: extra)
    }

    private func sendMessage<T: Sendable>(_ object: T, file: String = #file, function: String = #function, line: Int = #line, at level: Log.Level, extra: (@Sendable (Logging) -> Void)? = nil) {
        Task {
            
            let message = Message(object: object, logger: name, file: file, function: function, line: line, time: Date(), level: level)
            await Logger.sharedInstance.log(message: message)
            let globalLevel = await Logger.sharedInstance.getLevel()
            guard level.rawValue >= globalLevel.rawValue, let extra = extra else {
                return
            }
            
            extra(self)
        }
    }
}
