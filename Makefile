.PHONY: \
	clean \
	build \
	test-bats \
	test-go \
	test \

MAIN_FILE := cmd/leetstart/main.go
BUILD_DIR := build
BATS_TESTS := $(shell find . -type f -name "*.bats")
GO        := go
BATS      := bats

# clean removes the build directory, I.e. the output of the build target
clean:
	@echo "Cleaning build directory..."
	rm -rf ${BUILD_DIR}

# build compiles the project for the local OS and architecture.
build:
	@echo "Building the project for local os and architecture..."
	${GO} build -o ${BUILD_DIR}/leetstart ${MAIN_FILE}

# test-bats runs the bats test suite if any bats test files are found.
test-bats:
	@if [ -z "${BATS_TESTS}" ]; then \
		echo "No BATS tests found."; \
	else \
		echo "Running BATS tests..."; \
		${BATS} ${BATS_TESTS}; \
	fi

# test-go runs the golang unit tests.
test-go:
	@echo "Running Go unit tests..."
	${GO} test ./...

# test runs the test suite including the golang unit tests and the bats tests.
test:
	@echo "Running tests..."
	@$(MAKE) test-bats
	@$(MAKE) test-go

# TODO: delete this target once tests are implemented
run:
	@echo "Running the application..."
	${GO} run ${MAIN_FILE}