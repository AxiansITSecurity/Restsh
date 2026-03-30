#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# (c) Axians IT Security GmbH
# Jürgen Mang <juergen.mang@sec.axians.de>
# https://www.axians.de/security
# https://github.com/AxiansITSecurity/Restsh

# Shortdesc: Starts a Declarative Onboarding pipeline and prints the created manual jobs.
# Desc:
# Starts a Declarative Onboarding pipeline and prints the created manual jobs.

# Strict error handling
set -eEu -o pipefail

# Debug mode
[ -n "${RESTSH_DEBUG+x}" ] && set -x

if [ -z "${RESTSH_PATH+x}" ]
then
    echo "Script must be run in the restsh environment."
    exit 1
fi

# Get options
TASK_HOST=""
while getopts ':t:' OPTION
do
    case "$OPTION" in
        t) restsh.util.check.string "Task host" "$OPTARG"; TASK_HOST=$OPTARG ;;
        *) OPTION="invalid"; break ;;
    esac
done
shift "$((OPTIND -1))"

if [ $# -ne 2 ] || [ "$OPTION" = "invalid " ]
then
    exec 1>&2
    _restsh.help.shortdesc.get "$0"
    echo "Usage: $(basename "$0") [options...] <project path> <branch>"
    echo "Options:"
    echo "    -t <f5 management ip> or \"active\", \"standby\","
    echo "       default is to create one manual job for each management ip."
    exit 2
fi

restsh.util.check.string "project" "$1"; PROJECT=$1
restsh.util.check.string "branch" "$2"; BRANCH=$(restsh.util.lc "$2")

if [ -n "$TASK_HOST" ]
then
    NUM_JOBS=1
else
    NUM_JOBS=2
fi

# Special case for draft branch
if [ "$BRANCH" = "draft" ]
then
    if gitlab.project.pipeline.start -s "CI_COMMIT_BRANCH=$BRANCH" \
        -s "CI_PIPELINE_SOURCE=push" -s "TASK_HOST=$TASK_HOST" \
        "${PIPELINE_OPTS[@]}" \
        "$PROJECT" "$BRANCH"
    then
        exit 0
    fi
    exit 1
fi

# Start pipeline to create manual jobs
gitlab.project.pipeline.start -w -s "CI_PIPELINE_SOURCE=trigger" \
    -s "TASK_HOST=$TASK_HOST" \
    "$PROJECT" "$BRANCH"

restsh.util.check.isnumber "$PROJECT" || PROJECT=$(restsh.util.urlencode "$PROJECT")

echo "Created manual jobs for Declarative Onboarding."
echo "You can use \"gitlab.project.job.start\" to start it."
while read -r ID
do
    TASK_HOST=$(GET -r -f ".[] | select(.key == \"TASK_HOST\") | .value" "$GITLAB_API_PREFIX/projects/$PROJECT/pipelines/$ID/variables")
    JOB_ID=$(GET -r -f ".[] | select(.pipeline.id == $ID) | .id" "$GITLAB_API_PREFIX/projects/$PROJECT/jobs?scope=manual")
    echo "Job $JOB_ID: $TASK_HOST"
done < <(GET -r -f ".[].id" "$GITLAB_API_PREFIX/projects/$PROJECT/pipelines/?ref=$BRANCH&status=manual&per_page=$NUM_JOBS")
