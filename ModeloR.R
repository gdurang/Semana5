# Carga de paquetes
if (!require("readr")){install.packages("readr"); library(readr)}
if (!require("datamodelr")){install.packages("datamodelr"); library(datamodelr)}
if (!require("DiagrammeR")){install.packages("DiagrammeR", dependencies = TRUE); library(DiagrammeR)}


# Carga de conjunto de datos

# Tabla de Productos
p <- read.table(file = "https://raw.githubusercontent.com/ssantanar/datasets/master/retail/products.csv",
                           sep=',',
                           header = TRUE,
                           stringsAsFactors = FALSE)
# Tabla de Ordenes
o <- read.table(file = "https://raw.githubusercontent.com/ssantanar/datasets/master/retail/orders.csv",
                        sep=',',
                        header = TRUE,
                        stringsAsFactors = FALSE)
#Tabla de Ítems 
i <- read.table(file = "https://raw.githubusercontent.com/ssantanar/datasets/master/retail/order_items.csv",
                      sep=',',
                      header = TRUE,
                      stringsAsFactors = FALSE)
#Tabla de Clientes
c <- read.table(file = "https://raw.githubusercontent.com/ssantanar/datasets/master/retail/customers.csv",
                    sep=',',
                    header = TRUE,
                    stringsAsFactors = FALSE)

#Tabla de Cátegorias
k <- read.table(file = "https://raw.githubusercontent.com/ssantanar/datasets/master/retail/categories.csv",
                       sep=',',
                       header = TRUE,
                       stringsAsFactors = FALSE)
#Tabla de Departamentos
#dd<-read.table(file = "https://raw.githubusercontent.com/ssantanar/datasets/master/retail/departments.csv",
#           sep=',',
#           header = TRUE,
#           stringsAsFactors = FALSE)

d <- (read_csv("https://raw.githubusercontent.com/ssantanar/datasets/master/retail/departments.csv"))
d<-as.data.frame.table(d)

#Modelo de Datos
dm_f <- dm_from_data_frames(p, o, i, c, k, d)
graph <- dm_create_graph(dm_f, rankdir = "BT", col_attr = c("column", "type"))
dm_render_graph(graph)
dm_f <- dm_add_references(
  dm_f,
  c$customer_id == o$order_customer_id,
  o$order_id == i$order_item_order_id,
  i$order_item_product_id == p$product_id,
  p$product_category_id == k$category_id,
  k$category_departament_id == d$Freq.department_id
)
graph <- dm_create_graph(dm_f, rankdir = "BT", col_attr = c("column", "type"))
dm_render_graph(graph)

#left join

lj_pi <- p %>% left_join(i,by =c("product_id"="order_item_product_id")) 
ncol(lj_pi)
nrow(lj_pi)
dim(lj_pi)
length(lj_pi)
count(lj_pi)
colnames(lj_pi) 
head(lj_pi) 
View(lj_pi) 

#right join
 
rj_pi <- p %>% right_join(i,by =c("product_id"="order_item_product_id")) 
ncol(rj_pi)
nrow(rj_pi)
dim(rj_pi)
length(rj_pi)
count(rj_pi)
colnames(rj_pi) 
head(rj_pi) 
View(rj_pi) 

#inner join

ij_pi <- p %>% inner_join(i,by =c("product_id"="order_item_product_id")) 
ncol(ij_pi)
nrow(ij_pi)
dim(ij_pi)
length(ij_pi)
count(ij_pi)
colnames(ij_pi) 
head(ij_pi) 
View(ij_pi) 
