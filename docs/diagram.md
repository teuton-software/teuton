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

  Laboratory --> check/DSL
  Laboratory --> Builtin!
  Laboratory --> Show
end

subgraph readme
  Teuton -- readme --> Readme

  readme/DSL
  Lang!  
end

subgraph utils
  Laboratory --> Result
  Readme --> Result
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
