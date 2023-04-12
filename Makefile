# Define the name of the archive to create
ARCHIVE_NAME := terraform-aws-sc-dummy-item.tar.gz

# Define the list of file extensions to include in the archive
INCLUDE_EXTS := .tf .hcl

# Check whether to include .tfvars file
ifeq ($(EXCLUDE_TFVARS),true)
	EXCLUDE_OPTION := -not -name '*.tfvars'
else
	EXCLUDE_OPTION :=
endif

# Define the default target
default: validate-package

# Define the fmt target to format all .tf and .tfvars files
.PHONY: fmt
fmt:
	@echo "Formatting Terraform files..."
	@find . -type f -name '*.tf' -o -name '*.tfvars' -exec terraform fmt {} \;
	@echo "Terraform files formatted."

# Define the validate target to check that the contents of the module are valid
.PHONY: validate
validate: fmt
	@echo "Validating module..."
	@find . -type d -name '*.tf' -execdir terraform fmt {} \; -execdir terraform validate -json {} \; | tee validate.json
	@if [ -s validate.json ]; then echo "Error: terraform validate failed"; jq '.[] | .diagnostics[].summary' validate.json; exit 1; fi
	@echo "Module is valid."

# Define the package target to create the archive
.PHONY: package
package: validate
	@echo "Creating archive..."
	@mkdir -p dist
ifeq ($(EXCLUDE_TFVARS), true)
	@tar -czf dist/$(ARCHIVE_NAME) $(shell find . -type f \( -name '*$(word 1,$(INCLUDE_EXTS))' -o -name '*$(word 2,$(INCLUDE_EXTS))' \) ! -name '*.tfvars') 2>/dev/null || { echo "Error creating archive"; exit 1; }
	@echo "Archive created (excluding .tfvars files): dist/$(ARCHIVE_NAME)"
else
	@tar -czf dist/$(ARCHIVE_NAME) $(shell find . -type f \( -name '*$(word 1,$(INCLUDE_EXTS))' -o -name '*$(word 2,$(INCLUDE_EXTS))' -o -name '*$(word 3,$(INCLUDE_EXTS))' \)) 2>/dev/null || { echo "Error creating archive"; exit 1; }
	@echo "Archive created: dist/$(ARCHIVE_NAME)"
endif

# Define the validate-package target to check that the archive contains the expected files and structure
.PHONY: validate-package
validate-package: package
	@echo "Validating archive..."
	@mkdir -p validate-archive
	@tar -xzf dist/$(ARCHIVE_NAME) -C validate-archive
	@diff -r --exclude=README.md modules validate-archive/modules
	@rm -rf validate-archive
	@echo "Archive contents and structure are valid."

# Define the clean target to remove the archive
.PHONY: clean
clean:
	@echo "Cleaning up..."
	@rm -rf dist/$(ARCHIVE_NAME)
