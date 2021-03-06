# start stuff

# Edit these variables if more directories are needed.
SRCDIRS		:=	$(CURDIR) src src/cpu src/testing

# end stuff

PROJ=$(shell basename $(CURDIR))

# Verilog Compiler
VC=iverilog


#BUILD=$(VC) -o $(PROJ).vvp
#BUILD=$(VC) -g2005-sv -o $(PROJ).vvp
#BUILD=$(VC) -pfileline=1 -g2009 -o $(PROJ).vvp
BUILD=$(VC) -g2009 -o $(PROJ).vvp
PREPROCESS=$(VC) -g2009 -E -o $(PROJ).E


#SRCFILES		:=	$(foreach DIR,$(SRCDIRS),$(notdir $(wildcard $(DIR)/*.v)))
#
export VPATH	:=	$(foreach DIR,$(SRCDIRS),$(CURDIR)/$(DIR))
#SRCFILES		:=	$(shell find . -type f -iname "*.sv")

#PKGFILES		:=	$(foreach DIR,$(SRCDIRS),$(shell find $(DIR) \
#	-maxdepth 1  -type f -iname "*.svpkg"))
#SRCFILES		:=	$(foreach DIR,$(SRCDIRS),$(shell find $(DIR) \
#	-maxdepth 1  -type f -iname "*.sv"))

PKGFILES:=$(foreach DIR,$(SRCDIRS),$(wildcard $(DIR)/*.svpkg))
SRCFILES:=$(foreach DIR,$(SRCDIRS),$(wildcard $(DIR)/*.sv))

all: reminder clean
	$(BUILD) $(PKGFILES) $(SRCFILES)

.PHONY : only_preprocess
only_preprocess: reminder clean
	$(PREPROCESS) $(PKGFILES) $(SRCFILES)

.PHONY : reminder
reminder:
	@echo "Reminder:  With Icarus Verilog, DON'T CAST BITS TO ENUMS!"

.PHONY : clean
clean:  
	rm -fv $(PROJ).vvp $(PROJ).E
