[<<back](../README.md)

# Diagram

```mermaid
flowchart TB

subgraph user
  CLI --> Teuton
end

subgraph "create\nnew\nproject"
  Teuton -- create --> Skeleton("Sekeleton\nFiles")
end

subgraph "check\nproject\nfiles"
  Teuton -- check --> Laboratory("Laboratory\nDSL\nShow\nBuiltin!")
end

subgraph "create readme\nfrom project"
  Teuton -- readme --> Readme("Readme\nDSL\nLang!")
end

subgraph utils
  Readme --> ConfigFileReader
  Laboratory --> ConfigFileReader
  Verbose
end

subgraph case_manager
  Teuton -- require --> DSL
  DSL -- use/macros/groups --> Application("Application\nNameFileFinder")
  DSL -- play --> CaseManager("CaseManager\ncheck_cases\nExportManager\nSendManager\nShowReport")
  CaseManager --> ConfigFileReader
  ReportManager --> HallOfFame
end

subgraph "case folder"
  CaseManager --> Case("Case\nDSL\nConfig")
end

subgraph "result class"
  Laboratory --> Result
  Readme --> Result("Result\next_array\next_compare\next_filter")
  Case --> Result
end

subgraph report
  CaseManager --> Report
  Report --> Formatter
end
```
