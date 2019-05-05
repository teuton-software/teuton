
# case_manager (Singleton class)

include: Singleton, Utils

require singleton

require_relative
* 'application'
* 'configfile_reader'
* 'case'
* 'utils'
* 'report'
* 'case_manager/check_cases'
* 'case_manager/export'
* 'case_manager/hall_of_fame'
* 'case_manager/report'
* 'case_manager/show'

Invoke -> report
          array of case's
