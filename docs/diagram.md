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

subgraph case_manager
  Teuton -- run --> DSL
  DSL --> Casemanager
  CheckCases
  Result
end

subgraph report
  CaseManager --> Report
  Report --> Formatter

  ShowReports?
end
```
