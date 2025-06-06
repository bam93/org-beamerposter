# INCLUDE COMMON SETTINGS
include config/env

.PHONY: info

info:
	clear
	@printf "\ninfo:: Beamer poster from org-mode generation\n"
	@printf "info:: common targets: clean, distclean, gen, logo, style, v\n"
	@/bin/ls -GF
	@printf "\n"
	@git status .

gen: $(OUTSTYLE)
	$(info )
	$(info info:: generating summary index)
	-( cd tex ; latexmk -pdflatex='lualatex -shell-escape -interaction batchmode' -pdf -bibtex -f $(POSTER).tex )

style: $(OUTSTYLE)

$(CONFIG_JSON): $(CONFIG_YAML)
	$(info )
	$(info info:: Converting style from YAML to JSON)
	yq -o=json '.' $(CONFIG_YAML) > $(CONFIG_JSON)

$(OUTSTYLE): $(TEMPLATE) $(CONFIG_JSON)
	$(info )
	$(info info:: ✔ Theme generated as $(OUTSTYLE))
	@ mustache $(CONFIG_JSON) $(TEMPLATE) > $(OUTSTYLE)
	@ rm $(CONFIG_JSON)

v:
	$(info )
	$(info info:: view the resulting pdf)
	open tex/$(POSTER).pdf

logo:
	$(info )
	$(info info:: generating tiled logos)
	$(LOGOTILESCR)

clean:
	$(info )
	$(info info:: cleaning up files)
	@(cd tex ; rm -f *.log *.toc *.out *.aux *.bcf *.nav \
	      *.snm *.fls *.log *.fdb *.bbl *.blg \
	      *.fdb_latexmk *.run.xml *.1.vrb \
	      ../$(CONFIG_JSON) )

distclean:
	$(info )
	$(info info:: cleaning up files)
	@( cd tex ; rm -f *.log *.tex *.toc *.out *.aux *.bcf *.nav \
	      *.snm *.fls *.pdf *.log *.fdb *.bbl *.blg \
	      *.fdb_latexmk *.run.xml *.1.vrb \
	      ../$(CONFIG_JSON) $(OUTSTYLE) )

