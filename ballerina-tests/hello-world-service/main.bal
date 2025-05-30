import ballerina/http;
import ballerina/log;
import ballerinax/metrics.logs as _;

service /hello on new http:Listener(9091) {
    resource function get greeting() returns string {
        log:printInfo("Received a request for greeting");
        return "Hello, World!";
    }
}