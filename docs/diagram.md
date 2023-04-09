[<<back](../README.md)

# Diagram

```mermaid
flowchart TB

subgraph user
  CLI --> Teuton
end

subgraph "create new project"
  Teuton -- create --> Skeleton("Sekeleton\nFiles")
end

subgraph check
  Teuton -- check --> Laboratory("Laboratory\nDSL\nShow\nBuiltin!")
end

subgraph readme
  Teuton -- readme --> Readme("Readme\nDSL\nLang!")
end

subgraph result
  Laboratory --> Result
  Readme --> Result("Result\next_array\next_compare\next_filter")
end

subgraph utils
  Readme --> ConfigFileReader
end
```


```mermaid
flowchart TB

subgraph user
  CLI -- run --> Teuton
end

subgraph case_manager
  Teuton -- require --> DSL
  DSL -- use/macros/groups --> Application
  DSL -- play --> CaseManager
  CaseManager --> ExportManager
  CaseManager --> SendManager
  CaseManager --> ShowReport
  CheckCases
  ReportManager --> HallOfFame
end

subgraph case
  Result("Result\next_array\next_compare\next_filter")
end

subgraph report
  CaseManager --> Report
  Report --> Formatter
end
```
