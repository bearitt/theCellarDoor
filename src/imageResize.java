import javax.imageio.ImageIO;
import java.io.*;
import java.awt.image.BufferedImage;

public class imageResize {

	public static void main(String[] args) {
		try {
			File img = new File("C:\\Users\\barre_000\\Desktop\\20191124_144342.jpg");
			BufferedImage imm = ImageIO.read(img);
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			ImageIO.write(imm, "jpg", baos);
			baos.flush();
			byte[] imgAsBytes = baos.toByteArray();
			baos.close();
			for(int i=0;i<imgAsBytes.length;++i)
				System.out.println(imgAsBytes[i]);
			System.out.println("All done!");
		}catch(IOException e) {
			e.printStackTrace();
		}

	}

}
