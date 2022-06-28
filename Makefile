.PHONY: load-submodule
load-submodule:
	git submodule update --init --recursive --depth 1

.PHONY: serve
serve:
	hugo server \
	--buildFuture \
	--disableFastRender \
	--ignoreCache \
	--watch

.PHONY: deploy-preview
deploy-preview: load-submodule postcss ## Deploy preview site via netlify
	hugo --minify --enableGitInfo --buildFuture -b $(DEPLOY_PRIME_URL)

.PHONY: production-deploy
production-deploy: load-submodule postcss ## Builds production build.
	hugo \
		--minify \
		--enableGitInfo

.PHONY: postcss
postcss:
	npm install autoprefixer postcss postcss-cli
