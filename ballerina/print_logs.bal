// Copyright (c) 2025, WSO2 LLC. (https://www.wso2.com) All Rights Reserved.
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/log;

string[] DEFAULT_LOG_TAG_KEYS = ["logger", "spanId", "traceId", "icp.runtimeId", "error"];

log:Logger logger;

function init() returns error? {
    log:Config metricsLogConfig = {
        level: logLevel,
        format: logFormat
    };

    if logFilePath != "" {
        log:FileOutputDestination destination = {
            path: logFilePath
        };
        if enableLogRotation {
            destination.rotation = rotation;
        } 

        log:OutputDestination[] destinations = [];
        destinations.push(destination);
        metricsLogConfig.destinations = destinations.cloneReadOnly();
    }

    logger = check log:fromConfig(metricsLogConfig);
}

public function printMetricsLog(map<string> tags) {
    log:KeyValues logAttributes = {};
    logAttributes["logger"] = "metrics";
    
    foreach string tagKey in tags.keys() {
        if !DEFAULT_LOG_TAG_KEYS.some(key => key == tagKey) && !logAttributes.hasKey(tagKey) {
            logAttributes[tagKey] = tags[tagKey];
        }
    }
    if logLevel == "DEBUG" {
        logger.printDebug("", keyValues = logAttributes);
    } else if logLevel == "INFO" {
        logger.printInfo("", keyValues = logAttributes);
    } else if logLevel == "WARN" {
        logger.printWarn("", keyValues = logAttributes);
    } else if logLevel == "ERROR" {
        logger.printError("", keyValues = logAttributes);
    } else {
        logger.printInfo("", keyValues = logAttributes);
    }
}
