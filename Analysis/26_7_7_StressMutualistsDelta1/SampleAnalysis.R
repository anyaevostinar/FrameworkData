require(ggplot2)
install.packages("viridis")
library(viridis)

#Set your working directory to the Analysis folder for your project

#Read in the data
initial_data <- read.table("munged_basic_tasks.dat", h=T)
final_update <- subset(initial_data, update == "500000")



#Plot the host and symbiont task counts
ggplot(data=final_update, aes(x=treatment, y=task_count, color=partner)) + geom_boxplot(alpha=0.5, outlier.size=0) + ylab("Final Task Counts") + xlab("Task") + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + guides(fill=FALSE) + scale_color_manual(name="Partner", values=viridis(2)) + facet_wrap(~task)

# Over time
ggplot(data=subset(initial_data, partner=="Host"), aes(x=update, y=task_count, group=treatment, colour=treatment)) + ylab("Mean task count for hosts") + xlab("Evolutionary time (in updates)") + stat_summary(aes(color=treatment, fill=treatment),fun.data="mean_cl_boot", geom=c("smooth")) + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + guides(fill=FALSE) + facet_wrap(~task) + scale_color_manual(values=viridis(2))

ggplot(data=subset(initial_data, partner=="Sym"), aes(x=update, y=task_count, group=treatment, colour=treatment)) + ylab("Mean task count for symbionts") + xlab("Evolutionary time (in updates)") + stat_summary(aes(color=treatment, fill=treatment),fun.data="mean_cl_boot", geom=c("smooth")) + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + guides(fill=FALSE) + facet_wrap(~task) + scale_color_manual(values=viridis(2))

ggplot(data=subset(initial_data, treatment=="MutualistsDiff"), aes(x=update, y=task_count, group=partner, colour=partner)) + ylab("Task count") + xlab("Updates") + stat_summary(aes(color=partner, fill=partner),fun.data="mean_cl_boot", geom=c("smooth"), se=TRUE) + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + guides(fill=FALSE) +scale_colour_manual(name = "Parasites", values=viridis(3)) + scale_fill_manual(values=viridis(3)) + facet_grid(task ~ ., scales='free')