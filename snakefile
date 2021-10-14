from pathlib import Path

PRIMERS = 'input/primers'
TEMPLATES = 'input/templates'

primers = [str(f.stem) for f in Path(PRIMERS).iterdir()]
templates = [str(f.stem) for f in Path(TEMPLATES).iterdir()]


include: 'rules/PCR.smk'



rule all:
    input:
        expand(
            'output/product-plots/{primer_file}+{template_file}+plot.png',
            primer_file=primers, template_file=templates
        )





