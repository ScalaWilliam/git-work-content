default: build
fedora-setup:
	sudo dnf -y install saxon parallel npm nodejs inotify-tools
	sudo npm install -g browser-sync
	echo '#!/bin/bash' | sudo tee /usr/bin/saxon
	echo 'exec java -jar /usr/share/java/saxon/saxon.jar "$$@"' | sudo tee -a /usr/bin/saxon
	sudo chmod +x /usr/bin/saxon
centos-setup:
	sudo yum -y install saxon parallel npm nodejs inotify-tools
	sudo npm install -g browser-sync
	echo '#!/bin/bash' | sudo tee /usr/bin/saxon
	echo 'exec java -jar /usr/share/java/saxon.jar "$$@"' | sudo tee -a /usr/bin/saxon
	sudo chmod +x /usr/bin/saxon
debian-setup:
	sudo apt-get -y install saxon parallel npm nodejs inotify-tools
	sudo npm install -g browser-sync
ubuntu-setop: debian-setup
mac-setup:
	brew install saxon parallel fswatch npm nodejs
	npm install -g browser-sync
build:
	ls *.xml | parallel saxon -s:{} -a:on -o:{.}.html
watch:
	if hash inotifywait 2>/dev/null; then \
		inotifywait -m -e close_write --exclude '.*\.html' --exclude '.*Makefile' .; \
	else \
  	fswatch -l 0.2 --exclude '.*\.html' --exclude '.*Makefile' .; \
	fi | xargs -n1 make build
browser-sync:
	browser-sync start --files '*.html' --files '*.css' -s .
clean:
	rm -f *.xhtml
develop: browser-sync watch
