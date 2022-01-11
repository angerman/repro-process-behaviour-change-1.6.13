all:
	@echo "Building against process < 1.6.13 ..."
	@$(CABAL) new-build -w $(GHC) -fold-process -v0
	@echo "Running against process < 1.6.13; with an empty PATH, this should result in a git not found message"
	@PATH= $(CABAL) new-run -w $(GHC) -fold-process -v0
	@echo "Building against process >= 1.6.13 ..."
	@$(CABAL) new-build -w $(GHC) -f-old-process -v0
	@echo "Running against process >= 1.6.13; this now throws an exception instead."
	@PATH= $(CABAL) new-run -w $(GHC) -f-old-process -v0
