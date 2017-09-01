remove-ejabberd:
  cmd.run:
    - name: apt-get purge --remove ejabberd -y

ejabberd:
  pkg:
    - installed
    - require:
      - cmd: remove-ejabberd

/etc/ejabberd/ejabberd.yml:
  file.managed:
    - source: salt://ejabberd/config/ejabberd.yml
    - template: jinja
    - makedirs: True
    - force: True
    - mode: 644
    - require:
      - pkg: ejabberd

restart-ejabberd:
  cmd.run:
    - name: service ejabberd restart
    - require:
      - file: /etc/ejabberd/ejabberd.yml

register:
  schedule.present:
    - function: cmd.run
    - job_args:
      - ejabberdctl register admin localhost 123
    - seconds: 10
