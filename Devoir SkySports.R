library(rvest)
library(dplyr)
library(ggplot2)


#############
# Calculons le nombre de tableaux retrouvés dans la page SkySports

link_skysports = "https://www.skysports.com/world-cup-table"
data_skysports = rvest::read_html(link_skysports)
data_skysports
table_skysports = rvest::html_table(data_skysports)
length(table_skysports)




#############
# Fonction permettant de lire la page web skysports et de compiler les différents tableaux en un seul data frame

f_football = function(){
  link_skysports = "https://www.skysports.com/world-cup-table"
  data_skysports = rvest::read_html(link_skysports)
  table_skysports = rvest::html_table(data_skysports)
  wc2022 = do.call(rbind,list(table_skysports[[1]],table_skysports[[2]],table_skysports[[3]],table_skysports[[4]],
                               table_skysports[[5]],table_skysports[[6]],table_skysports[[7]],table_skysports[[8]]))
  
  wc2022[1] = NULL   # La première colonne a été enlevé car le classement des équipes par tableau n'est plus nécessaire puisque tous les tableaux ont été combinés en un seul data frame
  wc2022[10] = NULL  # Cette colonne a été enlevé car elle donne une information non pertinente: 'Last 6'
  return(wc2022)     # Conversion en data frame non nécessaire car les données se présentent déja sous la forme de data frame
}

df_wc2022=f_football()



###############
# Visualisation des 10 équipes ayant le nombre de points le plus élévé
str(df_wc2022)
df_wc2022%>%arrange(desc(Pts))%>%head(10)%>%
  ggplot(aes(y = Team, x = Pts))+
  geom_bar(stat = 'identity', fill = 'green') + theme_classic()