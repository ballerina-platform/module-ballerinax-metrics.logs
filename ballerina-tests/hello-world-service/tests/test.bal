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

import ballerina/http;
import ballerina/test;
import ballerina/lang.runtime;
import ballerina/io;
import ballerina/log;

http:Client cl = check new (string `http://localhost:9091/hello`);
http:Response res = new();

@test:BeforeSuite
function sendRequest() returns error? {
    res = check cl->get("/greeting");

    runtime:sleep(10);
}

@test:Config
function testResponse() returns error? {
    test:assertEquals(res.statusCode, http:STATUS_OK, "Status code mismatched");
    test:assertEquals(res.getTextPayload(), "Hello, World!", "Payload mismatched");
}

@test:Config
function testResourceLog() returns error? {
    string|error content = io:fileReadString("./metrics.log");
    if content is error {
        log:printError("Failed to read metrics log file", err = content.message());
    } else {
        test:assertTrue(isContain("level=INFO module=nipunal/hello_world_service message=\"Received a request for greeting\"", content), 
                        "Log message for request not found");
    }
}


@test:Config
function testMetricLogLogger() returns error? {
    string|error content = io:fileReadString("./metrics.log");
    if content is error {
        log:printError("Failed to read metrics log file", err = content.message());
    } else {
        test:assertTrue(isContain("logger=\"metrics\"", content), 
                        "Log message for request not found");
    }
}

@test:Config
function testMetricLogTags() returns error? {
    string|error content = io:fileReadString("./metrics.log");
    if content is error {
        log:printError("Failed to read metrics log file", err = content.message());
    } else {
        test:assertTrue(isContain("protocol=\"http\"", content), 
                        "Log message for request not found");
        test:assertTrue(isContain("listener.name=\"http\"", content), 
                        "Log message for request not found");
        test:assertTrue(isContain("src.position=\"main.bal:6:5\"", content), 
                        "Log message for request not found");
        test:assertTrue(isContain("http.status_code_group=\"2xx\"", content), 
                        "Log message for request not found");
        test:assertTrue(isContain("src.resource.path=\"/greeting\"", content), 
                        "Log message for request not found");
        test:assertTrue(isContain("src.object.name=\"/hello\"", content), 
                        "Log message for request not found");
        test:assertTrue(isContain("entrypoint.function.module=\"nipunal/hello_world_service:0.1.0\"", content), 
                        "Log message for request not found");
        test:assertTrue(isContain("entrypoint.resource.accessor=\"get\"", content), 
                        "Log message for request not found");
        test:assertTrue(isContain("http.method=\"GET\"", content), 
                        "Log message for request not found");
    }
}

function isContain(string logValue, string logString) returns boolean {
    if logString.includes(logValue) {
        return true;
    } else {
        return false;
    }
}