# Changelog

***

## v4.3.0 - not yet released

This version removes support for F5 Next and adds initial support for F5OS-A.

- General
    - Feat: Add `restsh.setup`
    - Feat: Add support for HTTP HEAD
    - Feat: Support for HashiCorp Vault
    - Feat: `cert.key.verify`, `cert.x509.check`
    - Feat: `restsh.util.array.string`
    - Feat: `restsh.util.check.isvarname`
    - Feat: `echo_verbose`
    - Upd: `cert.bundle.split` - add silent option and do not create empty files
    - Upd: Enable certificate checking in distributed configuration files as default.
- Axians Automation Framework
    - Feat: `aafw.art.new`
    - Feat: `aafw.cert.new`
- F5 TMOS Module
    - Feat: Allow setting explicit certificate name <> CN
        - `f5.cert.csr.create`, `f5.csr.create-from-key`
    - Feat: SNMPv3 user management
        - `f5.sys.snmp.user.create`, `f5.sys.snmp.user.delete`, `f5.sys.snmp.user.list`
    - Feat: `f5.cert.get`, `f5.cert.export`, `f5.cert.key.export`
    - Feat: `f5.asm.signatureset.attacktypes`, `f5.asm.signatureset.filter.create`
    - Feat: `f5.net.vlan.create`
    - Feat: `f5.net.selfip.list`
    - Feat: APM package management
        - `f5.apm.client.delete`, `f5.apm.client.list`
        - `f5.apm.epsec.delete`, `f5.apm.epsec.delete.all`, `f5.apm.epsec.list`
    - Fix: `f5.auth.token.extend` - Define timeout
- F5OS-A support - Login and token management, backup and file management.
    - Login: `f5osa.auth.token.get`, `f5osa.auth.token.renew`
    - General: `f5osa.version`, `f5osa.tenant.list`
    - Backup: `f5osa.backup.create`, `f5osa.file.download`, `f5osa.file.delete`, `f5osa.file.list`
- GitLab Module
    - Feat: Support archived projects
        - `gitlab.project.archive`
    - Feat: `gitlab.runner.jobs`
    - Feat: `gitlab.project.history`
    - Feat: `gitlab.project.pipeline.path`
    - Feat: Support marked for deletion for projects: `gitlab.project.restore`, `gitlab.project.delete`
    - Feat: `gitlab.project.move`, `gitlab.project.rename`, `gitlab.project.fork`
    - Feat: User management functions
        - For groups: `gitlab.group.member.add`, `gitlab.group.member.list`, `gitlab.group.member.modify`, `gitlab.group.member.remove`
        - For projects: `gitlab.project.member.add`, `gitlab.project.member.list`, `gitlab.project.member.modify`, `gitlab.project.member.remove`
    - Upd: `gitlab.branch.new` renamed to `gitlab.branch.create`

***

## v4.2.1 - 2025-08-04

- Feat: Manage job token scopes for projects: `gitlab.project.job_token_scope.allowlist.add`, `gitlab.project.job_token_scope.allowlist.list`, `gitlab.project.job_token_scope.allowlist.remove`
- Feat: Support live-update schedules: `f5.asm.live-update.schedule.list`, `f5.asm.live-update.schedule.set`
- Feat: Support masked_and_hidden and protected CI/CD-Variables
- Upd: `f5.asm.signatureset.list` lists all signature sets as default
- Upd: Support groups marked for deletion: `gitlab.group.delete`, `gitlab.group.restore`
- Fix: Export RESTSH_SECRET after reading it from file
- Fix: `f5.file.size` return 1 if file does not exist

***

## v4.2.0 - 2025-07-14

- Feat: Add `f5.asm.event.get`, `f5.asm.event.list`, `f5.asm.event.report`
- Feat: Add `f5.asm.live-update.check`, `f5.asm.live-update.file.list`, `f5.asm.live-update.file.remove`, `f5.asm.live-update.file.upload`, `f5.asm.live-update.install`, `f5.asm.live-update.list`, `f5.asm.live-update.status`
- Feat: Add `f5.botdefense.profile.create`, `f5.botdefense.profile.get`, `f5.botdefense.profile.list`, `f5.botdefense.profile.update`
- Feat: Add `f5.botdefense.whitelist.add`, `f5.botdefense.whitelist.batch`, `f5.botdefense.whitelist.list`, `f5.botdefense.whitelist.remove`, `f5.botdefense.whitelist.update`
- Feat: Add `f5.botdefense.override.add`, `f5.botdefense.override.batch`, `f5.botdefense.override.list`, `f5.botdefense.override.remove`, `f5.botdefense.override.update`
- Feat: Add `f5.asm.policy.signature.list`
- Feat: Pressing `Ctrl`+`h` shows the help of current command
- Feat: More options for `restsh.check.http-header`
- Feat: Support folders with configuration files
- Upd: `f5.cert.bundle.import` - Add option to set name
- Upd: Improved autocompletion for REST commands

***

## v4.1.0 - 2025-04-25

- Feat: Optional integration of [Atuin](https://atuin.sh/)
- Feat: Add `f5.net.dns-resolver.add`, `f5.net.dns-resolver.delete`, `f5.net.dns-resolver.get`, `f5.net.dns-resolver.list`, `f5.net.dns-resolver.modify`
- Feat: Use `RESTSH_CUSTOM_ENV` environment variable to source a custom file from `restsh.init`
- Feat: Add `gitlab.project.schedules.create`, `gitlab.project.schedules.delete`, `gitlab.project.schedules.get`, `gitlab.project.schedules.list`, `gitlab.project.schedules.start`
- Feat: Add `gitlab.group.id`, `gitlab.project.id`, `gitlab.group.subgroups`
- Feat: Support pagination for GitLab list functions
- Feat: Add `f5.ltm.pool.list`
- Feat: Add `f5.net.vlan.list`, `f5.net.trunk.list`
- Feat: Add `f5.cluster.traffic-group.ha-group.set`
- Feat: Add `f5.sys.ha-group.create`, `f5.sys.ha-group.delete`, `f5.sys.ha-group.get`, `f5.sys.ha-group.list`
- Feat: Add recursive option to `restsh.util.setvars`
- Feat: Add `f5.device.disable-setup`, `f5.device.dns.set`
- Feat: Add `f5.pkg.list`, `f5.pkg.uninstall`
- Feat: Add `f5.password.change.admin`, `f5.password.change.root`
- Feat: Add `f5.do.get`, `f5.do.get.id`, `f5.do.reset`
- Feat: Add `f5.device.cert.check`, `f5.device.cert.csr.create`, `f5.device.cert.install`
- Feat: Add `f5.sys.snmp.disable`
- Feat: Add `aafw.pipeline.start.task.axscripts`
- Feat: Allow encrypted variables in `restsh.util.setvar` for simple variables
- Feat: Add `gitlab.project.clone`
- Feat: Add `gitlab.project.pipeline.jobs`, `gitlab.project.pipeline.variables`, `gitlab.project.pipeline.latest`, `gitlab.project.pipeline.latest.jobs`
- Feat: Add wait options for `gitlab.project.pipeline.start`
- Feat: Add `gitlab.project.job.log`, `gitlab.project.job.artifact`, `gitlab.project.job.cancel`, `gitlab.project.job.erase`, `gitlab.project.job.retry`, `gitlab.project.job.start`
- Upd: Support subPath for `f5.sys.ifile.create`, `f5.sys.ifile.delete`, `f5.sys.ifile.download`, `f5.sys.ifile.update`
- Upd: `f5.cert.bundle.import` add option to not add suffix
- Upd: Add branch option to `gitlab.project.pipeline.list`
- Upd: Add `Accept` Header to HTTP-Requests.
- Upd: `aafw.group.clone` supports pull for existing repositories and is renamed to `gitlab.group.clone`
- Upd: Add automerge option to `gitlab.mr.create`

***

## v4.0.2 - 2025-04-17

- Fix: MO_F5_AS3_INCLUDE_DECLARATION - support empty arrays
- Fix: MO_F5_AS3_INCLUDE_DECLARATION - Array values with spaces are incorrectly splited
- Fix: MO_INCLUDE_JSON_ENCODE
- Fix: MO_INCLUDE_* - handle undefined second argument
- Fix: MO_CSV_GET_ENTRY_OR_DEFAULT - print default

***

## v4.0.1 - 2025-04-03

- Fix: `restsh.util.json_validate` mark correct line
- Fix: `scm.csr.sign` enforce required arguments
- Fix: Do not add default CERT_CI_STAGE

***

## v4.0.0 - 2025-03-10

- Feat: Add `f5.as3.info`, `f5.do.info`, `f5.ts.info`
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
- Feat: Add `RESTSH_INIT_CMD` add defaults for F5, Next, GitLab and SCM
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

## v3.0.3 - 2025-04-03

- Fix: Option parsing in `gitlab.group.variable.update` and `gitlab.project.variable.update`

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
