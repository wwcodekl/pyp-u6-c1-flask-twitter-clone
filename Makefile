.PHONY: test test-cov

TAG="\n\n\033[0;32m\#\#\# "
END=" \#\#\# \033[0m\n"

test:
	@echo $(TAG)Running tests$(END)
	PYTHONPATH=. py.test -v --tb=short tests
