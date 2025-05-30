import ballerina/log;

function init() returns error? {
    if logFilePath != "" {
        var result = check log:setOutputFile(logFilePath);
    }
}

public function printMetricsLog(map<string> tags) {
    log:KeyValues logAttributes = {};
    logAttributes["logger"] = "metrics";
    
    
    foreach string tagKey in tags.keys() {
        logAttributes[tagKey] = tags[tagKey];
    }
    if logLevel == "DEBUG" {
        log:printDebug("", keyValues = logAttributes);
    } else if logLevel == "INFO" {
        log:printInfo("", keyValues = logAttributes);
    } else if logLevel == "WARN" {
        log:printWarn("", keyValues = logAttributes);
    } else if logLevel == "ERROR" {
        log:printError("", keyValues = logAttributes);
    } else {
        log:printInfo("", keyValues = logAttributes);
    }
}
