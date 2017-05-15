ORIGINAL = vim-airline

dunder   = _
CHANGED  = $(dunder)$(ORIGINAL)
PATCH    = $(ORIGINAL)

init:
	cp -r $(ORIGINAL) $(CHANGED)

diff: $(PATCH).patch

$(PATCH).patch:
	diff -uNr $(ORIGINAL) $(CHANGED) | tee -a $(PATCH).patch
	rm -rf $(CHANGED)
	touch .ORIGINAL

original: $(PATCH).patch .CHANGED
	@( cd $(ORIGINAL); patch -p1 -R < ../$(PATCH).patch )
	@mv .CHANGED .ORIGINAL

changed: $(PATCH).patch .ORIGINAL
	@( cd $(ORIGINAL); patch -p1 < ../$(PATCH).patch )
	@mv .ORIGINAL .CHANGED

clean: original
	rm -rf $(CHANGED) $(PATCH).patch .CHANGED .ORIGINAL
