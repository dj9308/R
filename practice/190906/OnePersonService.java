package rtest;

import org.rosuda.REngine.Rserve.RConnection;
import org.springframework.stereotype.Service;
@Service
public class OnePersonService {
	public String returnLeaflet(String path, String gu)  {
		RConnection rc = null;
		String retStr = "";
		try {
			rc = new RConnection();
			rc.assign("gu", gu);
			System.out.println(gu);
			rc.eval("gu<-iconv(gu, from='CP949', to='UTF-8')");
			rc.eval("imsi<-source('C:/jjn/R/Rstudy/map2.R', encoding = 'UTF-8'); map<-imsi$value");
			String fileName = path + "/index.html";
			rc.eval("saveWidget(map,'"+fileName+"',  selfcontained = F)");	        
			retStr = rc.eval("'index.html'").asString();
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
		} finally {
			rc.close();
		}
		return retStr;
	}
}
