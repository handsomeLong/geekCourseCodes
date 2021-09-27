package com.geek.week03.client;

import io.netty.bootstrap.Bootstrap;
import io.netty.buffer.Unpooled;
import io.netty.channel.*;
import io.netty.channel.nio.NioEventLoopGroup;
import io.netty.channel.socket.SocketChannel;
import io.netty.channel.socket.nio.NioSocketChannel;
import io.netty.handler.codec.http.*;

import java.net.URI;
import java.nio.charset.StandardCharsets;

import static io.netty.handler.codec.http.HttpHeaderNames.CONNECTION;
import static io.netty.handler.codec.http.HttpHeaderNames.CONTENT_LENGTH;
import static io.netty.handler.codec.http.HttpHeaderNames.CONTENT_TYPE;
import static io.netty.handler.codec.http.HttpHeaderValues.KEEP_ALIVE;
import static io.netty.handler.codec.http.HttpVersion.HTTP_1_1;

public class NettyClient {
    private Channel channel;
    EventLoopGroup group = new NioEventLoopGroup(2);
    public  EventLoopGroup getGroup(){
        return  group;
    }
    public  Channel getChannel(){
        return  channel;
    }

    public void connect(String host,int port) throws Exception {
        try {
            Bootstrap b = new io.netty.bootstrap.Bootstrap();
            b.group(group)
                    .channel(NioSocketChannel.class)
                    .handler(new ChannelInitializer<SocketChannel>() {
                        @Override
                        protected void initChannel(SocketChannel socketChannel) throws Exception {
                            System.out.println("正在连接中...");
                            ChannelPipeline pipeline = socketChannel.pipeline();
                            pipeline.addLast(new HttpClientCodec());
                            pipeline.addLast(new HttpObjectAggregator(1024 * 1024));
                            pipeline.addLast(new NettyClientHander());
                        }
                    });
            ChannelFuture f = b.connect(host, port).sync();
            f.addListener((ChannelFutureListener) future -> {
                //如果连接成功
                if (future.isSuccess()) {
                    System.out.println("客户端[" + f.channel().localAddress().toString() + "]已连接...");
                    this.channel = f.channel();
                }
                //如果连接失败，尝试重新连接
                else {
                    System.out.println("客户端[" + f.channel().localAddress().toString() + "]连接失败，重新连接中...");
                    future.channel().close();
                    b.connect(host, port);
                }
            });
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public static void main(String[] args) throws Exception {
        NettyClient client = new NettyClient();
        client.connect("127.0.0.1",8080);
        String body ="Hello  Word ";
        FullHttpRequest request = client.createRequest(body, new URI("/"), HttpMethod.GET);
        // 发送get请求消息
        client.getChannel().writeAndFlush(request);
        Thread.sleep(1000);
//        client.getGroup().shutdownGracefully();
    }
    public FullHttpRequest createRequest(String body, URI uri, HttpMethod method){
        DefaultFullHttpRequest request = new DefaultFullHttpRequest(HTTP_1_1, method,
                uri.toASCIIString(), Unpooled.wrappedBuffer(body.getBytes(StandardCharsets.UTF_8)));
        request.headers().set(CONNECTION, KEEP_ALIVE);
        request.headers().set("accept-type", StandardCharsets.UTF_8);
        request.headers().set(CONTENT_TYPE, "application/json; charset=UTF-8");
        request.headers().set(CONTENT_LENGTH, request.content().readableBytes());
        return request;
    }
}
