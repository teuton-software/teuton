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

subgraph "Check\nproject files"
  Teuton -- check --> Laboratory("Laboratory\nDSL\nShow\nBuiltin!")
end

subgraph "Create readme\nfrom project"
  Teuton -- readme --> Readme("Readme\nDSL\nLang!")
end

subgraph manager
  Teuton -- run --> manager/DSL
  manager/DSL -- play --> CaseManager("CaseManager\ncheck_cases\nExportManager\nSendManager\nShowReport")
  ReportManager --> HallOfFame
end

subgraph "case folder"
  CaseManager --> Case("Case\nConfig\nClose\nPlay\nRunner\ncase/DSL")
end

subgraph utils
  Verbose

  Readme --> ConfigFileReader
  Laboratory --> ConfigFileReader
  CaseManager --> ConfigFileReader

  Laboratory --> Result
  Readme --> Result("Result\next_array\next_compare\next_filter")
  Case --> Result

  Laboratory --> Application
  Readme --> Application
  manager/DSL -- use/macros/groups --> Application("Application\nNameFileFinder")
  Case --> Application
end

subgraph report
  CaseManager --> Report("Report\nFormatter\nfiles/template")
  Case --> Report
end
```
