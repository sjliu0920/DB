# DB
1. init是数据库初始化函数，会删除原DB，重新建立DB和表，请小心调用
2. flush函数解决primary key auto increment到一定值后，删除之前的行，带来的primary key 跳跃的问题
