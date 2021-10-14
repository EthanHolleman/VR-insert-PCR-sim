from pydna.amplify import Anneal
from pydna.readers import read
from pydna.parsers import parse
import pandas as pd

def product_coords(anneal):
    products = []
    for each_product in anneal.products:
        start = anneal.template.seq.find(str(each_product.seq))
        end = start + len(each_product)
        products.append(
            {
                'template': anneal.template.description,
                'product_seq': str(each_product.seq),
                'product_len': len(each_product),
                'product_start': start,
                'product_end': end,
                'anneal_limit': anneal.limit,
                'template_length': len(anneal.template.seq)
            }
        )
    return products


def iter_limit_anneal(primers, template, limits=None):
    if not limits:
        short_primer_len = len(sorted(primers, key=lambda x: len(x.seq))[0])
        limits = range(int(short_primer_len / 3), short_primer_len)
    products = []
    for i in limits:
        a = Anneal(primers, template, limit=i)
        products += product_coords(a)
    
    return pd.DataFrame(products)


def main():

    primers = parse(str(snakemake.input['primers']), 'fasta')
    template = read(str(snakemake.input['template']), 'fasta')
    product_table = iter_limit_anneal(primers, template)
    product_table.to_csv(
        str(snakemake.output),
        sep='\t'
    )

if __name__ == '__main__':
    main()




