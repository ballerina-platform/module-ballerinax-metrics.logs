## Overview

The Metrics Logs Observability Extension enables metrics logs to be observed by OpenSearch.

### Key Features

- Publish metrics logs to OpenSearch for observability
- Simple configuration via import and Config.toml
- Lightweight extension for metrics log collection

## Enabling Metrics Logs Extension

To package the metrics logs extension into the Jar, follow the following steps.
1. Add the following import to your program.
```ballerina
import ballerinax/metrics.logs as _;
```

2. Add the following to the `Ballerina.toml` when building your program.
```toml
[package]
org = "my_org"
name = "my_package"
version = "1.0.0"

[build-options]
observabilityIncluded=true
```

To enable the extension and publish metrics logs to OpenSearch, add the following to the `Config.toml` when running your program.
```toml
[ballerina.observe]
metricsLogsEnabled=true
```

You can configure log file location, log format and log rotation in the `Config.toml`.

```toml
[ballerinax.metrics.logs]
logFilePath = "<PATH_TO_LOG_FILE>"      # Optional configuration
logLevel = "INFO"                       # Optional configuration. Possible values: "DEBUG", "INFO", "WARN", "ERROR"
logFormat = "logfmt"                    # Optional configuration. Possible values: "logfmt", "json"
enableLogRotation = false               # Optional configuration. Possible values: true, false

[ballerinax.metrics.logs.rotation]      # Optional configuration. Applies only when logFilePath is set
policy = "BOTH"                         # SIZE_BASED, TIME_BASED, or BOTH
maxFileSize = 10485760                  # 10MB in bytes
maxAge = 86400                          # 24 hours in seconds
maxBackupFiles = 7                      # Keep 7 backup files
```
