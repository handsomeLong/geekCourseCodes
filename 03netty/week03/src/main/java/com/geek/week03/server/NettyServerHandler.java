package com.geek.week03.server;

import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.ChannelInboundHandlerAdapter;
import io.netty.handler.codec.http.*;

import java.nio.charset.StandardCharsets;

import static io.netty.handler.codec.http.HttpHeaderNames.CONNECTION;
import static io.netty.handler.codec.http.HttpHeaderValues.KEEP_ALIVE;
import static io.netty.handler.codec.http.HttpResponseStatus.NO_CONTENT;
import static io.netty.handler.codec.http.HttpVersion.HTTP_1_1;

public class NettyServerHandler extends ChannelInboundHandlerAdapter {
    @Override
    public void channelRegistered(ChannelHandlerContext ctx) throws Exception {
        super.channelRegistered(ctx);
    }

    @Override
    public void channelUnregistered(ChannelHandlerContext ctx) throws Exception {
        super.channelUnregistered(ctx);
    }

    @Override
    public void channelActive(ChannelHandlerContext ctx) throws Exception {
        super.channelActive(ctx);
    }

    @Override
    public void channelInactive(ChannelHandlerContext ctx) throws Exception {
        super.channelInactive(ctx);
    }

    @Override
    public void channelRead(ChannelHandlerContext ctx, Object msg) throws Exception {
        FullHttpRequest fullRequest = (FullHttpRequest) msg;
        hander(ctx,fullRequest,"Nice to meet you!");
        System.out.println("后台服务接收到请求消息:"+ fullRequest.content().toString(StandardCharsets.UTF_8));
    }
    private void hander(ChannelHandlerContext ctx, FullHttpRequest fullRequest, String body) {
        FullHttpResponse response = null;
        try {
            ByteBuf buf = Unpooled.wrappedBuffer(body.getBytes("UTF-8"));
            response = new DefaultFullHttpResponse(HTTP_1_1,HttpResponseStatus.OK,buf);
            response.headers().set("Content-Type", "application/json");
            response.headers().setInt("Content-Length",response.content().readableBytes());
        }catch (Exception e){
            System.out.println("处理出错！"+e.getMessage());
            response = new DefaultFullHttpResponse(HTTP_1_1,NO_CONTENT);
        }finally {
            if(fullRequest!=null){
                if(!HttpUtil.isKeepAlive(fullRequest)){
                    ctx.write(response);
                }else{
                    response.headers().set(CONNECTION, KEEP_ALIVE);
                    ctx.write(response);
                }
            }
        }
    }
    @Override
    public void channelReadComplete(ChannelHandlerContext ctx) throws Exception {
        super.channelReadComplete(ctx);
        ctx.flush();
    }

    @Override
    public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) throws Exception {
        super.exceptionCaught(ctx, cause);
    }
}
