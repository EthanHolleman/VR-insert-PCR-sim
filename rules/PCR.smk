rule make_product_tables:
    conda:
        '../envs/pyGibson.yml'
    input:
        primers='input/primers/{primer_file}.fa',
        template='input/templates/{template_file}.fa'
    output:
        'output/product-tables/{primer_file}+{template_file}+products.tsv'
    script:'../scripts/PCR_sim.py'


rule make_product_plots:
    conda:
        '../envs/R.yml'
    input:
        'output/product-tables/{primer_file}+{template_file}+products.tsv'
    output:
        'output/product-plots/{primer_file}+{template_file}+plot.png'
    script:'../scripts/productPlot.R'