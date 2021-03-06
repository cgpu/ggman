#' Highlight groups of points in Manhattan plot
#'
#' Highlights groups of points in the ggman Manhattan Plot and add a legend.
#'
#' @param ggmanPlot A ggman plot of class 'ggman'; see \code{\link{ggman}}
#' @param highlightDfm A data frame object; one of the columns should contain snps identifiers 
#' @param snp Name of the snp column
#' @param group Name of the grouping column; if all the snps are to be highlighted with same colour use \code{\link{ggmanHighlight}}
#' @param legend.title Title of the legend.
#' @param legend.remove If TRUE, legend will be removed.
#' @param ... other arguments passed to \code{\link[ggplot2]{geom_point}}
#' 
#'
#' @return A manhattan plot with highlighted markers
#'
#' @examples
#'
#' p1 <- ggman(toy.gwas, snp = "snp", bp = "bp", chrom = "chrom",
#' pvalue = "pvalue")
#' ggmanHighlightGroup(p1, highlightDfm = toy.highlights.group, snp = "snp", group = "group",
#'                     size = 0.5, legend.title = "Significant groups")
#' 
#'
#' @export
ggmanHighlightGroup <- function(ggmanPlot,
                           highlightDfm,
                           snp = "snp",
                           group = "group",
                           legend.title = "legend",
                           legend.remove = FALSE,
                           ...){
    ##input checks
    environment(check.input.ggmanHighlightGroup) <- environment()
    check.input.ggmanHighlightGroup()
    
    dfm <- ggmanPlot[[1]]
    highlightDfm$snp <- highlightDfm[,snp]
    highlightDfm$group <- as.factor(highlightDfm[,group])

    dfm.sub <- merge(dfm,highlightDfm, by="snp")
    
    #dfm <- dfm[dfm$snp %in% highlight,]
    if(nrow(dfm.sub) == 0){
        stop("None of the markers in highlight input is present in the Manhattan plot layer")
    }

    p1 <- ggmanPlot +
        scale_colour_grey(start = 0.5,end = 0.6) +
        geom_point(data = dfm.sub,aes(fill = as.factor(group)),shape=21,
                   colour = alpha("black",0),...) +
        scale_fill_discrete(name = legend.title)
    if(legend.remove){
        p1 + guides(fill = FALSE)
    } else {
        p1        
    }
        
}
