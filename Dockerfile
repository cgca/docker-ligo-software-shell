FROM ligo/software:el7

LABEL name="LIGO Software Environment for Enterprise Linux 7 with user shell" \
      maintainer="Adam Mercer <adam.mercer@ligo.org>" \
      date="20170608" \
      support="Reference Platform"

RUN yum -y install \
      cvmfs \
      cvmfs-x509-helper \
      ldg-client \
      sudo \
      vim && \
    yum clean all

COPY /environment/bash/ligo.sh /etc/profile.d/ligo.sh
COPY /environment/etc/fstab /etc/fstab
COPY /environment/cvmfs/default.local /etc/cvmfs/default.local
COPY /environment/sudoers.d/albert /etc/sudoers.d/albert
COPY /entrypoint/startup /usr/local/bin/startup

RUN mkdir -p /cvmfs/config-osg.opensciencegrid.org && \
    mkdir /cvmfs/oasis.opensciencegrid.org && \
    mkdir /cvmfs/singularity.opensciencegrid.org && \
    mkdir /cvmfs/ligo.osgstorage.org

RUN useradd -ms /bin/bash albert
USER albert
WORKDIR /home/albert
ENTRYPOINT [ "/usr/local/bin/startup" ]
CMD ["/bin/bash", "-l" ]
