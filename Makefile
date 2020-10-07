_all: dist build

dist:
	docker build -t actions_build_artifacts .github/actions/build_artifacts/
	docker run --rm -e GITHUB_REF="refs/heads/"`git rev-parse --abbrev-ref HEAD` -e GITHUB_SHA=`git rev-parse --verify HEAD^{commit}` -v `pwd`/quickstart:/opt/quickstart:z actions_build_artifacts

build: dist
	docker build --file oci/Dockerfile --progress plain -t kubestack/framework:local-`git rev-parse --verify HEAD^{commit}` . 
