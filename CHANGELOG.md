# Changelog

***

## v4.0.0 - not yet released

- Feat: Add support for Declarative Onboarding pipeline
- Feat: Add `f5.asm.policy.signatureset.attach`, `f5.asm.policy.signatureset.list`
- Feat: Add KV utility to display key/value pairs
- Feat: Add `f5.asm.policy.new` to create a new policy from a template
- Feat: `f5.cluster.config-sync` add force overwrite option
- Feat: Add `f5.cluster.getstandby` and `f5.cluster.setstandby`
- Feat: Add initial test suite
- Feat: Add Mustache functions `MO_BASE64URL`, `MO_INCLUDE_BASE64URL`, `MO_IP_RANGE()`
- Feat: Add `restsh.util.base64url`
- Feat: Add `restsh.util.check.varnotempty`
- Feat: Add `aafw.pipeline.start.task.backup`, `aafw.pipeline.start.task.pkg`, `aafw.pipeline.start.task.signaturestaging`, `aafw.pipeline.start.task.asmsettings`
- Feat: Add `RESTSH_INIT_CMD` and defaults for F5, Next, GitLab and SCM
- Feat: Add `f5.version`, `f5.status`, `gitlab.version`
- Feat: Add `gitlab.mr.close`, `gitlab.mr.create`, `gitlab.mr.list`, `gitlab.mr.automerge`, `gitlab.mr.merge`
- Feat: Add `restsh.check.http-header`
- Feat: Add `gitlab.branch.new`, `gitlab.branch.list`
- Feat: Add branch protection options to `aafw.project.new`
- Feat: Add `gitlab.branch.protect.list`, `gitlab.branch.protect.set`, `gitlab.branch.protect.delete`
- Feat: Add skeleton variables for `aafw.project.new`
- Feat: Add `restsh.util.askpass`
- Feat: Add `restsh.util.isencrypted`
- Feat: Add `restsh.util.trim`
- Feat: Add `f5.ltm.vs.lb-detail` to show loadbalancing details of a virtual server
- Feat: Support path as alternative for id for GitLab groups and projects
- Feat: Add `gitlab.project.pipeline.list`, `gitlab.project.pipeline.start`
- Feat: Add `gitlab.project.variable.delete.all`
- Feat: Add `aafw.pipeline.start.as3`, `aafw.pipeline.start.cert`, `aafw.pipeline.start.waf`
- Feat: Add support for OpenAPI-File to `f5.asm.policy.import`
- Feat: Add support for Declarative Onboarding: `f5.do.declare` and `f5.do.status`
- Feat: Add option to enforce signatures to `f5.asm.policy.declare` and `f5.asm.policy.import`
- Feat: Add option to not apply policy to: `f5.asm.policy.declare`, `f5.asm.policy.import`, `f5.asm.signaturestaging.disable`, `f5.asm.signaturestaging.enforce`, `f5.asm.openapi.import`
- **Breaking:** Rename `f5.as3.install` to `f5.pkg.install` and add support for DO and TS
- **Breaking:** `f5.asm.policy.import` overwrites the policy with same name

***

## v3.0.2 - not yet released

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
