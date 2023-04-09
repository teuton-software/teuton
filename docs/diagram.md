[<<back](../README.md)

# Diagram

```mermaid
flowchart TB

subgraph user
  CLI --> Teuton
end

subgraph "create new project"
  Teuton -- create --> Skeleton
  Skeleton --> Files([Files])
end

subgraph check
  Teuton -- check --> Laboratory

  check/DSL
  check/Builtin!
  check/Show
end

subgraph readme
  Teuton -- readme --> Readme

  readme/DSL
  readme/Lang!  
end

subgraph case/result
  Laboratory --> Result
  Readme --> Result
end

subgraph utils
  Readme --> ConfigFileReader
end
```


```mermaid
flowchart TB

subgraph user
  CLI --> Teuton
end

subgraph run
  Teuton -- run --> CaseManager
  Result
end
```
