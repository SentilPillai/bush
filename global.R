# Common global variables initialized and used by ui.r and server.r 

suppressPackageStartupMessages(library(UsingR))
suppressPackageStartupMessages(library(shiny))
suppressPackageStartupMessages(library(ggplot2))

data(BushApproval)

BushApproval$date   <- strptime(BushApproval$date,"%m/%d/%y")

names(BushApproval) <- c("date","approval","Pollster")

bushStartDate     <- range(BushApproval$date)[1]
bushEndDate       <- range(BushApproval$date)[2]

nullDataFrame     <- data.frame(date=as.POSIXlt(bushStartDate, "EST" )
                                ,approval=numeric(1)
                                ,Pollster=character(1)
                                ,stringsAsFactors=FALSE ) 

customGGplot <- ggplot() + 
    coord_cartesian() +
    scale_y_continuous() +  
    labs(x="Poll date",
         y="Approval rating (in percent)",
         title="Approval as reported by pollsters") +
    theme(axis.text.x = element_text( angle = 30, hjust = 1),
          text = element_text(family = "Trebuchet MS", face = "plain", colour = "black", size = 12),
          panel.background = element_rect(fill = "white", colour = NA),
          panel.grid.major = element_line(colour = "grey",size=0.5),
          panel.grid.minor = element_line(colour = "grey", size = 0.25),
          panel.margin = unit(0.25, "lines"),
          axis.line = element_line(),       
          axis.text = element_text(size = rel(0.8), colour = "black"),
          legend.background = element_rect(colour = "black",size=0.25) )  