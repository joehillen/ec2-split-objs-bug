all:
	@docker build --pull -t ec2-split-objs-bug .
	@docker run --rm -v $(shell pwd):/usr/local/src/ec2-split-objs-bug -i --name ec2-split-objs-bug ec2-split-objs-bug stack --allow-different-user --jobs $(shell grep -c processor /proc/cpuinfo) install
