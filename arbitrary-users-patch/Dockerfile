ARG FROM_IMAGE
FROM ${FROM_IMAGE}
USER 0
# Set permissions on /etc/passwd and /home to allow arbitrary users to write
COPY --chown=0:0 entrypoint.sh /
RUN mkdir -p /home/user && chgrp -R 0 /home && chmod -R g=u /etc/passwd /etc/group /home && chmod +x /entrypoint.sh

# Install common terminal editors in container to aid development process
COPY install-editor-tooling.sh /tmp
RUN /tmp/install-editor-tooling.sh && rm -f /tmp/install-editor-tooling.sh

# User home directory
ENV USER_HOME /home/${USER_NAME:-user}
RUN mkdir -p ${USER_HOME}

# Ensure valid account
RUN echo "${USER_NAME:-user}:x:$(id -u):0:${USER_NAME:-user}:${USER_HOME}:/bin/bash" >> /etc/passwd
RUN echo "${USER_NAME:-user}:x:$(id -u):" >> /etc/group
RUN echo "${USER_NAME:-user}:*:18374:0:99999:7:::" >> /etc/shadow

# Make sure we can sudo
RUN echo "${USER_NAME:-user} ALL = (ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers && echo "/etc/sudoers" && cat /etc/sudoers

# Swap users & home dir
USER 10001
ENV HOME=/home/user
WORKDIR /projects

# Call endless tail
ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["tail", "-f", "/dev/null"]

LABEL "che.base.image" ${FROM_IMAGE}
