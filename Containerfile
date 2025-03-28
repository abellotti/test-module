FROM registry.access.redhat.com/ubi9-minimal:9.5-1739420147 as base

ENV TEST_MODULE="test-module"
ENV TEST_MODULE_NAME="Test Module"
ENV TEST_MODULE_VERSION="1.0.0"
ENV TEST_MODULE_SERVICE_PORT=9443
ENV APP_ROOT=/opt/app-root
ENV APP_HOME=${APP_ROOT}
ENV APP_LICENSES=/licenses

RUN mkdir -p ${APP_HOME}/
RUN mkdir -p ${APP_LICENSES}/test_module/

COPY app/entrypoint.sh ${APP_ROOT}/.
COPY LICENSE ${APP_LICENSES}/test_module/

LABEL maintainer="Alberto Bellotti" \
      vendor="Bellotti"
LABEL name=${TEST_MODULE} \
      version=${TEST_MODULE_VERSION} \
      description="The Module for testing Container wirings and builds." \
      distribution-scope="public"

# Exposing the test module service port
EXPOSE ${TEST_MODULE_SERVICE_PORT}

CMD ["/bin/bash", "/opt/app-root/entrypoint.sh"]
