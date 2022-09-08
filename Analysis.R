library(rvest)
library(dplyr)

# 爬取存放图片的网页中各文件对应的名字和链接
node.content <- 
  # 获取网页信息
  read_html("https://github.com/kangjf1943/SharePic/tree/main/RawData") %>% 
  # 找到对应节点并且获取内容
  html_nodes("div.js-details-container span a.js-navigation-open")
# 提取标题和链接
tibble(name = html_attr(x= node.content, name = "title"), 
       link = html_attr(x= node.content, name = "href")) %>% 
  # 去掉图片格式后缀
  mutate(name = gsub(".jpg", "", name)) %>% 
  mutate(name = gsub(".jpeg", "", name)) %>% 
  mutate(name = gsub(".png", "", name)) %>% 
  # 给链接加上必要的前后缀
  mutate(link = paste0("https://github.com", link, "?raw=true")) %>% 
  # 导出表格
  openxlsx::write.xlsx("ProcData/Second_hand_pics.xlsx")
