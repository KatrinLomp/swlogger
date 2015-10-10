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

public class Log {
    public enum Level: Int {
        case VERBOSE = 0, DEBUG, INFO, ERROR, NONE
    }

    public static var logLevel = Level.NONE
    
    public class func info(message:String) {
        Logger.sharedInstance.info(message)
    }

    public class func debug(message:String) {
        Logger.sharedInstance.debug(message)
    }
    
    public class func error(message:String) {
        Logger.sharedInstance.error(message)
    }

    public class func verbose(message:String) {
        Logger.sharedInstance.verbose(message)
    }
    
    public class func addOutput(output:LogOutput) {
        Logger.sharedInstance.addOutput(output)
    }
}