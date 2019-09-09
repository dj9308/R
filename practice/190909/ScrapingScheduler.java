package service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.OutputStreamWriter;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.rosuda.REngine.REXP;
import org.rosuda.REngine.RList;
import org.rosuda.REngine.Rserve.RConnection;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

@Service
public class ScrapingScheduler {
	@Scheduled(fixedRate=1000*60*10)
	public void newRun() {
		RConnection rc = null;
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		boolean flag = false;
        try{
            
			rc = new RConnection();
			REXP x = rc.eval("imsi<-source('C:/jjn/R/Rstudy/scrapingscheduler.R', encoding = 'UTF-8'); imsi$value");
			RList list = x.asList();
			String[] titles = list.at("newstitle").asStrings();
			String[] names = list.at("newspapername").asStrings();
			Charset.forName("UTF-8");
			File file = new File("C:/jjn/R/Rstudy/daumnews_schedule.csv");
			if(!file.isFile()) flag = true;
			FileWriter fw = new FileWriter(file, true);
			if(flag) {
            	fw.write("newstitle,newspapername,datetime\r\n");
            }
			for(int i = 0; i<titles.length; i++)
				fw.write(titles[i]+","+names[i]+","+dateFormat.format(calendar.getTime()));
			fw.write("\r\n");
			fw.close();
		}catch(Exception e) {
			System.out.println(e);
		} finally {
			rc.close();
		}
	}
}
