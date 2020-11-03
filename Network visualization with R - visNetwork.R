## Source: https://datastorm-open.github.io/visNetwork/

# Clear all objects from the workspace
rm(list = ls())

# Install the package "igraph" if you don't have it.
# The package (www.igraph.org) is maintained by Gabor Csardi and Tamas Nepusz.

install.packages("visNetwork") 

# Loading library
library(visNetwork)

# minimal example
nodes <- data.frame(id = 1:3)
edges <- data.frame(from = c(1,2), to = c(1,3))
visNetwork(nodes, edges, width = "100%")

## MORE ON NODES ----------------------------------------------------------

# Nodes data.frame
nodes <- data.frame(id = 1:10,
                    
                    # add labels on nodes
                    label = paste("Node", 1:10),
                    
                    # add groups on nodes 
                    group = c("GrA", "GrB"),
                    
                    # size adding value
                    value = 1:10,          
                    
                    # control shape of nodes
                    shape = c("square", "triangle", "box", "circle", "dot", "star",
                              "ellipse", "database", "text", "diamond"),
                    
                    # tooltip (html or character), when the mouse is above
                    title = paste0("<p><b>", 1:10,"</b><br>Node !</p>"),
                    
                    # color
                    color = c("darkred", "grey", "orange", "darkblue", "purple"),
                    
                    # shadow
                    shadow = c(FALSE, TRUE, FALSE, TRUE, TRUE))             

# Edges data.frame
edges <- data.frame(from = c(1,2,5,7,8,10), to = c(9,3,1,6,4,7))

# Visualize network
visNetwork(nodes, edges, height = "500px", width = "100%")

## MORE ON EDGES ----------------------------------------------------------

## Edges data.frame
edges <- data.frame(from = sample(1:10,8), to = sample(1:10, 8),
                    
                    # add labels on edges                  
                    label = paste("Edge", 1:8),
                    
                    # length
                    length = c(100,500),
                    
                    # width
                    width = c(4,1),
                    
                    # arrows
                    arrows = c("to", "from", "middle", "middle;to"),
                    
                    # dashes
                    dashes = c(TRUE, FALSE),
                    
                    # tooltip (html or character)
                    title = paste("Edge", 1:8),
                    
                    # smooth
                    smooth = c(FALSE, TRUE),
                    
                    # shadow
                    shadow = c(FALSE, TRUE, FALSE, TRUE))

# Nodes data.frame
nodes <- data.frame(id = 1:10, group = c("A", "B"))

# Visualize network
visNetwork(nodes, edges, height = "500px", width = "100%")

## Groups -----------------------------------------------------------------

nodes <- data.frame(id = 1:5, group = c(rep("A", 2), rep("B", 3)))
edges <- data.frame(from = c(2,5,3,3), to = c(1,2,4,2))

visNetwork(nodes, edges, width = "100%") %>% 
  # darkblue square with shadow for group "A"
  visGroups(groupname = "A", color = "darkblue", shape = "square", 
            shadow = list(enabled = TRUE)) %>% 
  # red triangle for group "B"
  visGroups(groupname = "B", color = "red", shape = "triangle")     

# With legend
visNetwork(nodes, edges, width = "100%") %>%
  visGroups(groupname = "A", color = "red") %>%
  visGroups(groupname = "B", color = "lightblue") %>%
  visLegend()

## Images and icons
path_to_images <- "https://raw.githubusercontent.com/datastorm-open/datastorm-open.github.io/master/visNetwork/data/img/indonesia/"

nodes <- data.frame(id = 1:4, 
                    shape = c("image", "circularImage"),
                    image = paste0(path_to_images, 1:4, ".png"),
                    label = "I'm an image")

edges <- data.frame(from = c(2,4,3,3), to = c(1,2,4,2))

visNetwork(nodes, edges, width = "100%") %>% 
  visNodes(shapeProperties = list(useBorderWithImage = TRUE)) %>%
  visLayout(randomSeed = 2)

## fontAwesome icons
nodes <- data.frame(id = 1:3, group = c("B", "A", "B"))
edges <- data.frame(from = c(1,2), to = c(2,3))

visNetwork(nodes, edges, width = "100%") %>%
  visGroups(groupname = "A", shape = "icon", 
            icon = list(code = "f0c0", size = 75)) %>%
  visGroups(groupname = "B", shape = "icon", 
            icon = list(code = "f007", color = "red")) %>%
  addFontAwesome()

## Options ----------------------------------------------------------------

# data used in next examples
nb <- 10
nodes <- data.frame(id = 1:nb, label = paste("Label", 1:nb),
                    group = sample(LETTERS[1:3], nb, replace = TRUE), value = 1:nb,
                    title = paste0("<p>", 1:nb,"<br>Tooltip !</p>"), stringsAsFactors = FALSE)

edges <- data.frame(from = c(8,2,7,6,1,8,9,4,6,2),
                    to = c(3,7,2,7,9,1,5,3,2,9),
                    value = rnorm(nb, 10), label = paste("Edge", 1:nb),
                    title = paste0("<p>", 1:nb,"<br>Edge Tooltip !</p>"))

# Highlight nearest
visNetwork(nodes, edges, height = "500px", width = "100%") %>% 
  visOptions(highlightNearest = TRUE) %>%
  visLayout(randomSeed = 123)

visNetwork(nodes, edges, height = "500px", width = "100%") %>% 
  visOptions(highlightNearest = list(enabled = T, degree = 2, hover = T)) %>%
  visLayout(randomSeed = 123)

visNetwork(nodes, edges, height = "500px", width = "100%") %>% 
  visGroups(groupname = "A", shape = "icon", 
            icon = list(code = "f0c0", size = 75)) %>%
  visGroups(groupname = "B", shape = "icon", 
            icon = list(code = "f007", color = "red")) %>%
  visGroups(groupname = "C", shape = "icon", 
            icon = list(code = "f1b9", color = "black")) %>%
  visOptions(highlightNearest = list(enabled =TRUE, degree = 2, hover = T)) %>%
  addFontAwesome() %>%
  visLayout(randomSeed = 123)

## Select by node id
visNetwork(nodes, edges, height = "500px", width = "100%") %>% 
  visOptions(highlightNearest = TRUE, nodesIdSelection = TRUE) %>%
  visLayout(randomSeed = 123)

## Select by a column
# on "authorised" column
visNetwork(nodes, edges, height = "500px", width = "100%") %>%
  visOptions(selectedBy = "group") %>%
  visLayout(randomSeed = 123)

# or new column, with multiple groups
nodes$sample <- paste(sample(LETTERS[1:3], nrow(nodes), replace = TRUE),
                      sample(LETTERS[1:3], nrow(nodes), replace = TRUE), 
                      sep = ",")
nodes$label <- nodes$sample # for see groups

visNetwork(nodes, edges, height = "500px", width = "100%") %>%
  visOptions(selectedBy = list(variable = "sample", multiple = T)) %>%
  visLayout(randomSeed = 123)

visNetwork(nodes, edges, height = "500px", width = "100%") %>% 
  visOptions(highlightNearest = TRUE, 
             nodesIdSelection = list(enabled = TRUE,
                                     selected = "8",
                                     values = c(5:10),
                                     style = 'width: 200px; height: 26px;
                                 background: #f8f8f8;
                                 color: darkblue;
                                 border:none;
                                 outline:none;')) %>%
  visLayout(randomSeed = 123)

## Collapse / Uncollapse Nodes
nodes <- data.frame(id = 1:15, label = paste("Label", 1:15),
                    group = sample(LETTERS[1:3], 15, replace = TRUE))

edges <- data.frame(from = trunc(runif(15)*(15-1))+1,
                    to = trunc(runif(15)*(15-1))+1)

# keeping all parent node attributes  
visNetwork(nodes, edges) %>% visEdges(arrows = "to") %>%
  visOptions(collapse = TRUE)




