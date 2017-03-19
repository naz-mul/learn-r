# Draw Venn Diagram
install.packages('VennDiagram')
library(VennDiagram)

draw.pairwise.venn(22, 20, 11, category = c("Dog People", "Cat People"), lty = rep("blank", 
                                                                                   2), fill = c("light blue", "pink"), alpha = rep(0.5, 2), cat.pos = c(0, 
                                                                                                                                                        0), cat.dist = rep(0.025, 2))

# https://rstudio-pubs-static.s3.amazonaws.com/13301_6641d73cfac741a59c0a851feb99e98b.html