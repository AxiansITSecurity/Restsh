# Changelog

***

## v3.0.2 - 2025-03-10

- Fix: max_json_policy_size is in KB
- Fix: `restsh.util.declare.var` use declare
- Fix: `restsh.util.parseoutput` use argument
- Fix: `f5.asm.entity.whitelist-ips.remove` use correct argument
- Fix: `f5.ltm.datagroup.internal.delete` assign FULLPATH

***

## v3.0.1 - 2025-02-14

- Fix: `f5.ltm.datagroup.internal.delete`
- Fix: Do not overwrite global FILENAME variable in `f5.file-transfer` functions

## v3.0.0 - 2025-01-20

- Feat: Support of AES256 encrypted `RESTSH_TOKEN_VALUE`
- Feat: Add `f5.asm.signatureset.get`
- Feat: Add `restsh.util.eval_stage_var`
- Feat: Add `f5.sys.db.get`, `f5.sys.db.list` and `f5.sys.db.modify`
- Feat: Add `f5.sys.service.get`, `f5.sys.service.list` and `f5.sys.service.restart`
- Feat: Add `f5.asm.advanced-settings.getid`
- Feat: Add `-f <filter>` argument to HTTP methods to filter output with jq
- Feat: Add `gitlab.group.projects`
- Feat: Add `gitlab.group.variable.copy` and `gitlab.project.variable.copy`
- Feat: Add `gitlab.group.variable.delete.all`
- Feat: Add `restsh.pwgen`
- Feat: Add module for Axians Automation Framework: `aafw`
    - Groups: `aafw.group.clone`, `aafw.group.new`
    - Projects: `aafw.project.init.as3`, `aafw.project.init.cert`, `aafw.project.init.tasks`, `aafw.project.init.waf`, `aafw.project.new`
- Feat: Add `restsh.util.uc` and `restsh.util.lc` helper
- Feat: Manage GitLab Runners: `gitlab.runner.create`, `gitlab.runner.list`
- Upd: Improve autocompletion
- Fix: Install pandoc in Docker Image
- Fix: Add feature detection for curl option "--retry-all-errors" supported since curl version 7.71.0
- Fix: `cert.key.create` for encrypted ec private keys
- Fix: Return codes for some scripts
- Fix: `f5.asm.policy.audit` support scientific notation for timestamps
- Fix: `f5.sslreport.generate` use correct options for column and pandoc
- Fix: `restsh.util.setvar` declare empty arrays

***

## 24.10.21

- Note: Not setting `RESTSH_MODULES` is now deprecated.
- Feat: Support of AES256 encrypted `RESTSH_PASS` and `SCM_SECRET`
- Feat: Add `restsh.util.encrypt`, `restsh.util.decrypt`
- Feat: Management for GitLab Project CI/CD Variables
- Feat: Resolve variables in `gitlab.group.variable.batch` for value
- Feat: Support "-h" help option for all functions
- Feat: Add `f5.cluster.standby`
- Feat: Add `f5.asm.policy.unused`
- Feat: Add `restsh.util.check.isnumber`
- Feat: Add `gitlab.group.delete`
- Feat: Add `gitlab.project.delete`
- Feat: Add JQE - jq exits with 1 on null or false
- Upd: Add retry to get task status from F5
- Fix: `entity.urls-allowed.json`
- Fix: Migrate `f5.cluster.setactive` to lib
- Fix: Use correct API endpoint for `f5.as3.app.remove`

***

## 24.09.11

- Feat: Add `f5.asm.advanced-settings` functions
- Feat: Sectigo Cert Manager Integration
- Feat: More complete F5 REST API autocompletion
- Feat: Overhaul private key management
- Feat: Overhaul CSR management
- Feat: Add `f5.cert.expire`

***

## 24.08.01

- Feat: Add certificate csr and key functions
- Feat: Add F5 cluster functions
- Feat: Add option to enable only specific modules
- Upd: Add more REST API endpoints for F5
- Upd: Improve http error reporting
- Upd: `restsh.util.setvar` exports arrays now with ARRAY_ prefix
- Fix: Return only last value in MO_CSV_GET_LAST
