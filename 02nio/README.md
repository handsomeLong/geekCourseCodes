Week02 作业题目：

1.（选做）使用 GCLogAnalysis.java 自己演练一遍串行 / 并行 /CMS/G1 的案例。
		
		串行
		-XX:+PrintGCDetails
		-XX:+PrintGCDateStamps
		-XX:+UseSerialGC
		创建对象三千多,几乎没有fullGC
		
		增加-Xms1g -Xmx1g 后没有FullGC,YoungGC若干次,创建对象近5000
		
		并行
		-XX:+PrintGCDetails
		-XX:+PrintGCDateStamps
		-XX:+UseParallelGC
		
		FullGC 两次 Ergonomics
		YoungGC 若干次 
		创建 对象 三千多
		
		-XX:-UseAdaptiveSizePolicy
		并行GC关闭自适应参数,FullGC 次数占大部分,创建的对象少了一半,只有一千多
		
		增加-Xms1g -Xmx1g 后没有FullGC,YoungGC若干次,创建对象近5000
		
		CMS
		-XX:+PrintGCDetails
		-XX:+PrintGCDateStamps
		-XX:+UseParallelGC
		
		FullGC 一次,创建对象不到4000
		
		增加-Xms1g -Xmx1g 后没有FullGC,YoungGC若干次,创建对象不到4500
		
		-XX:+UseG1GC -XX:MaxGCPauseMillis=50
		
		创建对象三千多
		
2.（选做）使用压测工具（wrk 或 sb），演练 gateway-server-0.0.1-SNAPSHOT.jar 示例。

		压测接口:http://localhost:8088/api/hello
		
		压测命令:sb -u "http://localhost:8088/api/hello" -c 40 -N 30
		
		串行 
			启动命令:java -XX:+UseSerialGC -jar   -XX:+PrintGCDetails  -Xloggc:serialGC.log gateway-server-0.0.1-SNAPSHOT.jar
			
			结果: 55903
					RPS: 1793 (requests/second)
					Max: 745ms
					Min: 0ms
					Avg: 11ms
			 
		并行　
			启动命令:java -jar -XX:+UseParallelGC  -XX:+PrintGCDetails -Xloggc:parallelGC.log gateway-server-0.0.1-SNAPSHOT.jar 
		
			结果: 59566
				 RPS: 1911.4 (requests/second)
				 Max: 762ms
				 Min: 0ms
				 Avg: 11.1ms
			 
		CMS
			启动命令:java -jar -XX:+UseConcMarkSweepGC  -XX:+PrintGCDetails -Xloggc:cmsGC.log gateway-server-0.0.1-SNAPSHOT.jar
			
			结果: 52439
				RPS: 1688.4 (requests/second)
				Max: 742ms
				Min: 0ms
				Avg: 13.4ms

		G1 
			启动命令:java -jar -XX:+UseG1GC  -XX:+PrintGCDetails -Xloggc:G1GC.log gateway-server-0.0.1-SNAPSHOT.jar
			
			结果:  62493
					RPS: 2004.1 (requests/second)
					Max: 729ms
					Min: 0ms
					Avg: 11.7ms
			
3.（选做）如果自己本地有可以运行的项目，可以按照 2 的方式进行演练。


4.（必做）根据上述自己对于 1 和 2 的演示，写一段对于不同 GC 和堆内存的总结，提交到 GitHub。

		1.内存越大,G1回收的效率越高,吞吐量和gc时间都优于其他回收器
		
		2.不管什么GC回收器,内存越小,young gc 和 full gc 都越频繁
		
		3.就回收效率而言,ParNewGC 最好,如果考虑stw,CMS 略胜于 G1
		
		4.内存分配率高引起的GC 为 Allocation Fail,年轻代提升过早,造成老年代没有足够的内存用于年轻代提升 为 Ergonomics  

5.（选做）运行课上的例子，以及 Netty 的例子，分析相关现象。

6.（必做）写一段代码，使用 HttpClient 或 OkHttp 访问  http://localhost:8801 ，代码提交到 GitHub

	

以上作业，要求 2 道必做题目提交到自己 GitHub 上面，然后把自己的作业链接填写到下方的表单里面：
 https://jinshuju.net/f/ihAQ4e

示例代码参考：
 https://github.com/JavaCourse00/JavaCourseCodes