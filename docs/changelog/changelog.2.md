
## [2.3.9]

- FIX: Remove warnings from linter
- FIX: Remove warning about thor gem version. Upgrade gem to 1.2

## [2.3.11]

- Issue #18

## [2.4.0]

New features:
- Hide feedback from reports: `export feedback: false`
- Add new DSL keyword: expect_last, expect_fisrt
- Remove os gem.
- Change test output colors to green as use others test tools.
- Change show DSL params. Accepts one param "verbose: NUMBER" to adjust verbosity output level on screen.

New doc and example:
- 14-alias
- 16-exit_codes

Bug fixed:
- All "expect*" keywords must require 2 arguments. The second is optional.

Revise
- Remove colors to log text
- teuton readme: macros, getvars, expect_last, expect_first

## [2.4.2]

- Fix bug with result.grep_v(Array)

## [2.4.3]

- Fix: "expect_none" without params works as "expect result.count.eq 0"
- Add: "expect_nothing" that works as "expect result.count.eq 0".

## [2.4.4]

-- Modify: teuton check output colors and exit codes.
   exit code 0 = check OK
   exit code 1 = check error
-- Fix teuton check docs.

## [2.4.5]

-- FIX: "expect_nothing" was always TRUE when SSH/Telnet connections fails!
   Now when SSH/Telnet connections fails result contains "SSH: NO CONNECTION!"
   So "expect_nothing" will fail.

## [2.5.0]

- ADD: "tt_moodle_max_score" global configuration param. Teuton grades (0-100) are divided by this value when exporting data into "moodle.csv" output file.
- UPDATE: Revise documentation. Doc learn 10,11, 12,13 y 14. 10 result and moodle_id, 12 alias, 13 include, 14 macro, Doc tt_include
- UPDATE: Internal changes. Remove Colorize gem and replace with Rainbow.

## [2.6.0]

- [ADD] When running local or SSH commands, stdout and stderr are captured and readed by "expect" sentence.

## [2.7.0]

New features:
- [ADD] "teuton config PROJECTPATH" will suggest suitable configuration for the project.
- [ADD] Every one line command output is registered into reports.
- [ADD] "expect_exit 1", check last command exit code is equal to 1.

Internal changes:
* Application class splited into Settings and Project classes
* Create SendManager similar to ExportManager

## [2.7.1]

- [FIX] Fixed an issue that appeared when executing test and fail connection to remote computer.

## [2.7.2] 20230607

- [FIX] Fixed an issue that appeared when exporting reports without feedback after failing to connect to remote computer.

## [2.7.3] 20230607

- [FIX] Hall of fame now use Project class instead of Application.

## [2.8.0] 20230630

DSL expect:
- [ADD] "expect_ok" as "expect_exit 0 ".
- [ADD] "expect_fail" as "expect_exit NUMBER" where NUMBER > 0.
- [FIX] expect evaluation fail when there is no remote connection.

DSL send:
- [UPDATE] Rename "remote_dir" send param to "dir".
- [UPDATE] send output messages

## [2.9.0] 20230726

- [ADD] "expect_sequence" that check if sequence is present
- [ADD] New DSL "run_script". Example: `run_script script, on: :host1`, upload script to host1 and then execute it on remote.
- [ADD] New DSL "upload". Upload local file to remote host. Example `upload "localfile", to: :host1`
- [ADD] `teuton check` works with `expect_sequence`, `run_script` and `upload`.
- [FIX] `teuton check` works fine with `macros`.
- [ADD] `teuton readme` works with `expect_sequence`, `run_script` and `upload`.
- [FIX] `teuton readme` works fine with `macros`.

## [2.9.1] 20231117

- [FIX] Config option `tt_include` doubled readed data on Windows platforms.

## [2.9.2] 20231201

- [FIX] Change error message when running a non-existent challenge
```
❯ teuton run example/foo
[ERROR] Cannot find main file!
         /home/username/example/foo/start.rb
         or /home/username/example/foo.rb
```

## [2.9.3] 20250402

- [FIX] Error with telnet connections.

## [2.9.4] 20250410

- [FIX] Improve the markdown output of the readme.
- [FIX] Telnet exitcode

## [2.9.5] 20250514

- [FIX] `require "json_pure"`is deprecated. Use `json` gem instead of `json_pure`.

## [2.9.6] 20251106

- [FIX] Problem with `export preserve: true`. It was using old class Application. Now use Project class.

## []

- [FIX] `net-ssh` gem can't use `ssh-ed25519` security keys. Required gems added to gemspec: 
  * ed25519 --version ~> "1.2"
  * bcrypt_pbkdf --version "~> 1.0"
