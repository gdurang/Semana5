# Carga de paquetes
if (!require("readr")){install.packages("readr"); library(readr)}
if (!require("datamodelr")){install.packages("datamodelr"); library(datamodelr)}
if (!require("DiagrammeR")){install.packages("DiagrammeR", dependencies = TRUE); library(DiagrammeR)}

# Carga de conjunto de datos

# Tabla de Probeedores
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
