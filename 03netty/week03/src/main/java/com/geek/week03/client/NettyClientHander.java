package com.geek.week03.client;

import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.ChannelInboundHandlerAdapter;
import io.netty.handler.codec.http.FullHttpResponse;
import io.netty.util.ReferenceCountUtil;

import java.nio.charset.StandardCharsets;

public class NettyClientHander extends ChannelInboundHandlerAdapter {

    @Override
    public void channelActive(ChannelHandlerContext ctx) throws Exception {
        super.channelActive(ctx);

    }
    @Override
    public void channelRead(ChannelHandlerContext ctx, Object msg) throws Exception {
        try {
            FullHttpResponse response = (FullHttpResponse) msg;
            System.out.println("客户端收到响应消息:"+ response.content().toString(StandardCharsets.UTF_8));
        } catch (Exception ex){
            ex.printStackTrace();
        } finally {
            ReferenceCountUtil.release(msg);
        }
    }

    @Override
    public void channelReadComplete(ChannelHandlerContext ctx) throws Exception {
        super.channelReadComplete(ctx);
        System.out.println("客户端  channelReadComplete 。。。。。。。。。。");
    }

}
