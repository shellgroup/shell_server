package com.winnerdt.modules.qrcode.utils;


import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.font.FontRenderContext;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;
import java.io.File;

/**
 * Created by Stormeye on 2017/8/7.
 */
public class QRCodeUtils {


//    /*
//    * 配置小程序扫码后待跳转的页面
//    * */
//    public static String PAGE_URL = "pages/index/main";
//
//    /*
//    * 根据码类型设置生成二维码像素（员工码=导购码）
//    * */
//    public static final int QR_WIDTH = 680; //员工码430，位置码680
//    public static final int QR_HIGHT = 680; //员工码430，位置码680
//    public static final int QR_FONT_SIZE  = 19;
//    public static final int QR_H_TIP = 90;
//    public static final int QR_H_TIP2 = 120;

    public static void graphicsGeneration(File oldimg,File newimg,String pressText,int QR_H_TIP,int QR_WIDTH,int QR_HIGHT,int QR_FONT_SIZE) {
        int H_tip = QR_H_TIP; // 文字的高度
        int imageWidth = QR_WIDTH; // 图片的宽度
        int imageHeight = QR_HIGHT + QR_H_TIP; // 图片的高度

        BufferedImage image = new BufferedImage(imageWidth, imageHeight, BufferedImage.TYPE_INT_RGB);
        // 设置图片的背景色
        Graphics2D main = image.createGraphics();
        main.setColor(Color.white);
        main.fillRect(0, 0, imageWidth, imageHeight);

        Graphics mainPic = image.getGraphics();
        BufferedImage bimg = null;
        try {
            bimg = ImageIO.read(oldimg);
            if (bimg != null) {
                mainPic.drawImage(bimg, 0, 0, QR_WIDTH, QR_HIGHT, null);
                mainPic.dispose();
            }

            Graphics2D tip = image.createGraphics();
            // 设置区域颜色
            tip.setColor(Color.white);
            // 填充区域并确定区域大小位置
            tip.fillRect(0, QR_HIGHT, QR_WIDTH, H_tip);

            // 设置字体颜色，先设置颜色，再填充内容
            tip.setColor(Color.black);
            // 设置字体
            Font tipFont = new Font("宋体", Font.PLAIN, QR_FONT_SIZE);
            tip.setFont(tipFont);
            FontRenderContext context = tip.getFontRenderContext();
            Rectangle2D bounds = tipFont.getStringBounds(pressText, context);
            double x = (QR_WIDTH - bounds.getWidth()) / 2;
            tip.drawString(pressText, (int)x, QR_HIGHT + 50);

            // 分割线
            tip.drawLine(0, QR_HIGHT, QR_WIDTH, QR_HIGHT);

            //FileOutputStream out = new FileOutputStream(newimg);
            ImageIO.write(image, "png", newimg);
            //JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
            //encoder.encode(image);
            //out.close();

        }catch (Exception e) {
            e.printStackTrace();
            System.out.println(e);
        }

    }

//    public static void graphicsGeneration2(File oldimg,File newimg,String pressText1, String pressText2) {
//        int H_tip = QR_H_TIP2; // 文字的高度
//        int imageWidth = QR_WIDTH; // 图片的宽度
//        int imageHeight = QR_HIGHT + QR_H_TIP2; // 图片的高度
//
//        BufferedImage image = new BufferedImage(imageWidth, imageHeight, BufferedImage.TYPE_INT_RGB);
//        // 设置图片的背景色
//        Graphics2D main = image.createGraphics();
//        main.setColor(Color.white);
//        main.fillRect(0, 0, imageWidth, imageHeight);
//
//        Graphics mainPic = image.getGraphics();
//        BufferedImage bimg = null;
//        try {
//            bimg = ImageIO.read(oldimg);
//            if (bimg != null) {
//                mainPic.drawImage(bimg, 0, 0, QR_WIDTH, QR_HIGHT, null);
//                mainPic.dispose();
//            }
//
//            Graphics2D tip = image.createGraphics();
//            // 设置区域颜色
//            tip.setColor(Color.white);
//            // 填充区域并确定区域大小位置
//            tip.fillRect(0, QR_HIGHT, QR_WIDTH, H_tip);
//            // 设置字体颜色，先设置颜色，再填充内容
//            tip.setColor(Color.black);
//
//            // 设置字体
//            Font tipFont = new Font("粗体", Font.BOLD, QR_FONT_SIZE);
//            tip.setFont(tipFont);
//            FontRenderContext context = tip.getFontRenderContext();
//            Rectangle2D bounds1 = tipFont.getStringBounds(pressText1, context);
//            double x = (QR_WIDTH - bounds1.getWidth()) / 2;
//            tip.drawString(pressText1, (int)x, QR_HIGHT + 50);
//
//            Rectangle2D bounds2 = tipFont.getStringBounds(pressText2, context);
//            x = (QR_WIDTH - bounds2.getWidth()) / 2;
//            tip.drawString(pressText2, (int)x, QR_HIGHT + 90);
//            //FileOutputStream out = new FileOutputStream(newimg);
//            ImageIO.write(image, "png", newimg);
//            //JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
//            //encoder.encode(image);
//            //out.close();
//
//        }catch (Exception e) {
//            e.printStackTrace();
//            System.out.println(e);
//        }

//    }
}
