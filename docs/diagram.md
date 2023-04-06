[<<back](../README.md)

# Diagram

```mermaid
flowchart TB

subgraph user
  CLI --> Teuton
  Teuton --> Application
end

subgraph create
  Teuton -- create --> Skeleton
end

subgraph check
  Teuton -- check --> Laboratory
end

subgraph run
  Teuton -- run --> CaseManager
end

subgraph readme
  Teuton -- readme --> Readme
end
```
