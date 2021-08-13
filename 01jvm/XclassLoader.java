package time.geek.jvm;

import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Method;
import java.net.URL;

public class XclassLoader extends  ClassLoader {
    public static void main(String[] args) throws Exception {
        final String className = "Hello";
        final String methodName = "hello";
        ClassLoader classLoader = new XclassLoader();
        Class<?> clazz = classLoader.loadClass(className);
        //查询class 所有方法
        for (Method method:clazz.getDeclaredMethods()) {
            System.out.println(clazz.getSimpleName()+": method:"+method.getName());
        }
        Object instance = clazz.getDeclaredConstructor().newInstance();
        Method method = clazz.getMethod(methodName);
        method.invoke(instance);
    }
    @Override
    protected Class<?> findClass(String name) throws ClassNotFoundException {
        String resources = name.replace(".","/");
        String suffix =".xlass";
        InputStream in = this.getClass().getClassLoader().getResourceAsStream(resources + suffix);
        try {
            byte[] bytes = new byte[in.available()];
            in.read(bytes);
            byte[] resultBytes = decode(bytes);
            return defineClass(name,resultBytes,0,resultBytes.length);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return  null;
    }

    /**
     * byte - 255
     * @param bytes
     * @return
     */
    private byte[] decode(byte[] bytes) {
        byte[] targetArray = new byte[bytes.length];
        for (int i= 0;i<bytes.length;i++) {
            targetArray[i] = (byte) (255 - bytes[i]);
        }
        return targetArray;
    }

}
