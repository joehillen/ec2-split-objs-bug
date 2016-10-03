define docker-gc =
	docker ps -a -l -q -f status=exited -f name=chow|xargs -I {} docker rm {}
endef

all:
	@docker build --pull -t ec2-split-objs-bug .
	@mkdir dist/
	@docker run -d -v .:/usr/local/src/ec2-split-objs-bug --name ec2-split-objs-bug ec2-split-objs-bug sleep 5

clean:
	@$(docker-gc)
	@rm -rf dist/

.PHONY: clean
