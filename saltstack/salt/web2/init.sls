# install the web server package
apache2:
  pkg.installed:
    - name: apache2
  service.running:
    - enable: true

#add_permisison:
#  cmd.run:
#    - name: sudo chmod +x /srv/salt/web1/conf/programans.sh

install programs:
  cmd.script:
    - name: programs.sh
    - source: salt://web2/conf/programs.sh

create my_new_directory:
  file.directory:
    - name: /ExampleFlask

create my_new_directory2:
  file.directory:
    - name: /ExampleFlask/ExampleFlask

/ExampleFlask/ExampleFlask/_init_.py:
  file.touch

/ExampleFlask/ExampleFlask/my_flask_app.py:
   file.managed:
     - template: jinja
     - source: salt://web2/conf/my_flask_app.py

/ExampleFlask/ExampleFlask/my_flask_app.wsgi:
  file.managed:
    - template: jinja
    - source: salt://web2/conf/my_flask_app.wsgi

/etc/apache2/sites-available/ExampleFlask.conf:
  file.managed:
    - template: jinja
    - source: salt://web2/conf/ExampleFlask.conf

enable site:
  cmd.run:
    - name: sudo a2ensite ExampleFlask.conf

apache2 restart:
  cmd.run:
    - reload: sudo systemctl restart apache2

/var/www/html/index.html:
  file.managed:
    - template: jinja
    - source: salt://web2/conf/index.html


#/var/www/html/index.json:
#  file.managed:
#    - template: jinja
#    - source: salt://web/conf/index.json
