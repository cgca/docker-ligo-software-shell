FROM ligo/software:stretch

LABEL name="LIGO Software Environment for Debian 9 'stretch' with user shell" \
      maintainer="Adam Mercer <adam.mercer@ligo.org>" \
      date="20170616" \
      support="Reference Platform"

COPY /environment/bash/ligo.sh /etc/profile.d/ligo.sh
COPY /environment/etc/fstab /etc/fstab
COPY /environment/sudoers.d/albert /etc/sudoers.d/albert
COPY /entrypoint/startup /usr/local/bin/startup

RUN apt-get update \
    && apt-get install --assume-yes \
      emacs-nox \
      sudo \
      vim \
    && rm -rf /var/lib/apt/lists/*

#      cvmfs \
#      cvmfs-x509-helper \
#      ldg-client \
#
#RUN mkdir /cvmfs/config-osg.opensciencegrid.org && \
#    mkdir /cvmfs/oasis.opensciencegrid.org && \
#    mkdir /cvmfs/singularity.opensciencegrid.org && \
#    mkdir /cvmfs/ligo.osgstorage.org && \
#
#RUN sed -i 's/#[[:space:]]*user_allow_other/user_allow_other/' /etc/fuse.conf

RUN mkdir /container \
    && useradd -m -d /container/albert -s /bin/bash albert
USER albert
WORKDIR /container/albert
ENTRYPOINT [ "/usr/local/bin/startup" ]
CMD ["/bin/bash", "-l" ]
