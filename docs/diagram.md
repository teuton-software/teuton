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
  Laboratory --> Builtin[[Builtin!]]
  Laboratory --> check/DSL
  Laboratory --> Show  
  Laboratory --> Result
end

subgraph run
  Teuton -- run --> CaseManager
end

subgraph readme
  Teuton -- readme --> Readme
  Readme --> readme/DSL
  Readme --> Lang!  
  Readme --> Result
end
```
