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

  Laboratory --> Builtin!
  Laboratory --> check/DSL
  Laboratory --> Show  
  Result --> Laboratory
end

subgraph run
  Teuton -- run --> CaseManager
end

subgraph readme
  Teuton -- readme --> Readme

  subgraph "readme use"
    Readme --> readme/DSL
    Readme --> Lang!  
  end
end

subgraph utils
  Readme --> ConfigFileReader
  Readme --> Result
end
```
