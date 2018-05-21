#!/bin/bash

BRANCH=develop
IMAGE=cicd-poc1

#oc new-app https://github.com/natehudsonpublic/cicd-poc1.git#${BRANCH}
#oc new-app --name "${IMAGE}-${BRANCH}" --param=GIT_SHA=${GIT_SHA} https://github.com/natehudsonpublic/cicd-poc1.git#${BRANCH}
oc new-app --name "${IMAGE}-${BRANCH}" https://github.com/natehudsonpublic/cicd-poc1.git#${BRANCH}

#oc logs -f bc/cicd-poc1

oc expose svc/${IMAGE}-${BRANCH}

oc set probe dc/${IMAGE}-${BRANCH} --readiness --get-url=http://:8080/healthCheck

#oc status
#oc status -v
oc get all

