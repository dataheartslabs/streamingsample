# streamingsample
Datahearts平台通过API和流数据（Streaming）协议和客户端应用程序已经第三方软件交换数据。
数据格式支持Json文本格式。通过下述了解案例，你可以学习掌握Datahearts系统如下功能：
● 使用DBase。通过python API导入Json文本数据
● 使用CDR实时传输数据到Elastic
● 使用第三方 indexing工具 ElasticSearch
● 使用第三方数据分析查询工具 kibana

演示：
客户数据是交通卡口数据，以Json文本格式输入DBase（NoSQL文本数据库）。同时，数
据实时复制到ElasticSearch Cluster 做 Fulltext Indexing. 然后通过 Kibana做数据分析和数据呈现
，满足业务查询要求

./demo.sh
./driver.sh
./streaming.s

