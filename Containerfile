ARG PARENT_IMAGE=registry.access.redhat.com/ubi9/nodejs-22
FROM $PARENT_IMAGE

# this has to be specified again after "FROM"
ARG PARENT_IMAGE

LABEL io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="Deno $DENO_VERSION" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,deno" \
      com.redhat.deployments-dir="/opt/app-root/src" \
      com.redhat.dev-mode="DEV_MODE:false" \
      com.redhat.dev-mode.port="DEBUG_PORT:5858" \
      maintainer="Tobias Florek <tob@butter.sh>" \
      summary="$SUMMARY" \
      description="$DESCRIPTION" \
      version="$DENO_VERSION" \
      name="quay.io/ibotty/s2i-deno" \
      usage="s2i build . quay.io/ibotty/s2i-yarn myapp" \
      parent_image=$PARENT_IMAGE

USER 1001
WORKDIR /opt/app-root/src

RUN npm install -g corepack

COPY ./s2i/ $STI_SCRIPTS_PATH

# Set the default CMD to print the usage
CMD ${STI_SCRIPTS_PATH}/usage
