library(ggplot2)
library(ggpubr)
library(viridis)

product.plot <- function(df){

    df$ymin <- seq(from = 0.5, to = nrow(df)*2, length.out = nrow(df))
    df$ymax <- df$ymin + 0.75

    x_max = unique(df$template_length)
    template_name = unique(df$template)

    ggplot(df, 
        aes(
            ymin=ymin,
            ymax=ymax,
            xmin=product_start,
            xmax=product_end,
            fill=anneal_limit)
        ) + geom_rect(color='black') + xlim(0, x_max) + theme_pubr() +
            theme(
                axis.text.y = element_blank(),
                axis.ticks = element_blank()
            ) +
        scale_fill_viridis() + 
        labs(
            x='Template', 
            y='PCR products', 
            title=template_name, 
            fill='Min primer anneal length') +
        theme(text = element_text(size=20, face='bold'))

}

main <- function(){

    product.df <- read.table(
        file = as.character(snakemake@input), sep = '\t', header = TRUE)
    plot <- product.plot(product.df)
    ggsave(as.character(snakemake@output), plot, dpi=500)


}

if (! interactive()){

    main()

}