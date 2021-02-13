FROM cr.shanhu.io/bos-debian

COPY build/sshd_config.append.tpl /etc/ssh/
COPY build/lsb-release /etc/

RUN rm -rf /var/lib/apt/lists/* \
    && rm -rf /etc/ssh/*key* \
    && echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen \
    && locale-gen \
    && find /usr/share/i18n/charmaps -not -path /usr/share/i18n/charmaps/UTF-8.gz -name '*.gz' -exec rm -rf {} \; \
    && find /usr/share/i18n/locales -not -path /usr/share/i18n/locales/en_US -name '*_*' -exec rm -rf {} \; \
    && addgroup --gid 1100 rancher \
    && addgroup --gid 1101 docker \
    && useradd -u 1100 -g rancher -G docker,sudo -m -s /bin/bash rancher \
    && useradd -u 1101 -g docker -G docker,sudo -m -s /bin/bash docker \
    && echo '## allow password less for rancher user' >> /etc/sudoers \
    && echo 'rancher ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \
    && echo '## allow password less for docker user' >> /etc/sudoers \
    && echo 'docker ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \
    && ln -s /bin/ps /usr/bin/ps \
    && cat /etc/ssh/sshd_config > /etc/ssh/sshd_config.tpl \
    && cat /etc/ssh/sshd_config.append.tpl >> /etc/ssh/sshd_config.tpl \
    && rm -f /etc/ssh/sshd_config.append.tpl /etc/ssh/sshd_config \
    && echo > /etc/motd

COPY build/iscsid.conf /etc/iscsi/

ENTRYPOINT ["/usr/bin/ros", "entrypoint"]
