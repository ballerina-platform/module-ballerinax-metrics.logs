## Package Overview

The Metrics Logs Observability Extension is used to enable Ballerina metrics logs to be observed by OpenSearch.

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
