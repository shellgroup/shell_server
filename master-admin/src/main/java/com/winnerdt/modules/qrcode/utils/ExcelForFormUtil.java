package com.winnerdt.modules.qrcode.utils;

import com.winnerdt.modules.qrcode.entity.AutofillRulesEntity;
import com.winnerdt.modules.qrcode.entity.ProfilesEntity;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Map.Entry;


public class ExcelForFormUtil {
	//xsl格式的excel不能存取太多的数据，不能超过65536,
	/*
	* 这个大小仅仅是展示记录的多少，由于会有表头等之类的存在，所以按照需求减少该数量
	* */
	private static int sheetSize=65520; //单个sheet储存的大小
	@SuppressWarnings({ "resource", "deprecation" })
	public static<T> void listToExcel(List<ProfilesEntity> data1, List<AutofillRulesEntity> data2, OutputStream out, Map<String,String> fields1, Map<String,String> fields2, String excelName1, String excelName2) throws Exception {

		//判断传入的数据源是否有数据
		if(data1==null||data1.size()==0||data2 == null || data2.size() == 0) {
			throw new Exception("传入的数据源中无数据");
		}

		HSSFWorkbook workBook=new HSSFWorkbook();
		//计算一共有多少个sheet
		int sheetNum=(data1.size()+data2.size())/sheetSize;
		if((data1.size()+data2.size())%sheetSize != 0) {
			sheetNum += 1;
		}

		//字段名（数据库中的字段名）和中文名（自定义的标题名字）分别存在两个数组中
		String [] fieldNames1 = new String[fields1.size()];
		String [] chinaNames1=new String[fields1.size()];
		int count1 = 0;
		for(Entry<String, String> entry:fields1.entrySet()) {
			String fieldName1 = entry.getKey();
			String chinaName1 = entry.getValue();
			fieldNames1[count1] = fieldName1;
			chinaNames1[count1] = chinaName1;
			count1++;
		}

		//字段名（数据库中的字段名）和中文名（自定义的标题名字）分别存在两个数组中
		String [] fieldNames2 = new String[fields2.size()];
		String [] chinaNames2=new String[fields2.size()];
		int count2 = 0;
		for(Entry<String, String> entry:fields2.entrySet()) {
			String fieldName2 = entry.getKey();
			String chinaName2 = entry.getValue();
			fieldNames2[count2] = fieldName2;
			chinaNames2[count2] = chinaName2;
			count2++;
		}

		//填充数据
		int dataSize1 = data1.size();
		int dataSize2 = data2.size();
		/*
		*为简述方便，数据源1简写为D1，数据源2简写为D2,每个sheet的容量为S
		*
		* a:true对D1进行数据处理，同时也会控制D2处理方式
		*
		* a1:true 对D1进行填入excel处理
		*
		* a2:true D2写入excel时，上面是否空几行。（D1和D2在同一个sheet时需要空行，只有第二个数据源时不需要空行）
		*
		* b:true 对D2进行填入excel处理
		*
		* b&c:true： 对D2数据进行相应的处理，判断怎么分成不同的sheet
		*
		* */
		boolean a = true;
		boolean a1 = true;
		boolean a2 = true;
		boolean b = false;
		boolean c = false;
		int endIndex1 = 0;
		int startIndex2 = 0;
		//endIndex2需要记忆数据用于赋值，所以必须放到for外边，endIndex1和startIndex2只是为了初始化，放到for里面也行
		int endIndex2 = 0;
		for(int i=0;i<sheetNum;i++) {
			int rowCount = 0;
			HSSFSheet sheet=workBook.createSheet();
			int startIndex1 = i*sheetSize;

			/*
			* 先以D1的数据为主写入到excel中
			* */
			if(a){
				//如果单个sheet能够容下D1和D2，直接都放进去
				if((i+1)*sheetSize >= (dataSize1+dataSize2)){
					endIndex1 = dataSize1;
					endIndex2 = dataSize2;
					b = true;
				}else {
					//如果D1.size 大于S，本次操作只存放D1
					if(dataSize1 >= (i+1)*sheetSize){
						endIndex1 = ((i+1)*sheetSize);
					}else {
						//D1.size小于S，说明本sheet需要存放部分D1和部分D2，开启D2的数据处理逻辑
						endIndex1 = dataSize1;
						b = true;
						c = true;
					}
				}
			}
			if(b && c){
				//针对sheet需要存放部分D1和部分D2的情况，并且D1数据剩下的一定能在本次存放完，所以执行之后关闭D1数据处理的逻辑（D1的写入excel没有关闭）
				if(a){
					endIndex2 = ((i+1)*sheetSize) - dataSize1;
					a = false;

				}else {
					/*
					* 执行到这里说明D1的数据已经填写进excel完毕，所以关闭D1的数据写入逻辑，关闭D2的上面空行操作
					* */
					a1 = false;
					a2 = false;
					startIndex2 = endIndex2;
					if(dataSize2 >= endIndex2+sheetSize){
						endIndex2 = startIndex2+sheetSize;
					}else {
						endIndex2 = dataSize2;
					}

				}
			}

		  
			HSSFRow row = sheet.createRow(rowCount);
			sheet.setColumnWidth(0, 7000);
			sheet.setColumnWidth(1, 6000);
			sheet.setColumnWidth(2, 6000);
			sheet.setColumnWidth(3, 6000);
			sheet.setColumnWidth(4, 6000);
			sheet.setColumnWidth(5, 6000);
			sheet.setColumnWidth(6, 6000);
			sheet.setColumnWidth(7, 6000);
			sheet.setColumnWidth(8, 6000);
			sheet.setColumnWidth(9, 6000);
			sheet.setColumnWidth(10, 7000);
			sheet.setColumnWidth(11, 7000);
			sheet.setColumnWidth(12, 7000);
			sheet.setColumnWidth(13, 7000);
			sheet.setColumnWidth(14, 7000);
			sheet.setColumnWidth(15, 6000);
			sheet.setColumnWidth(16, 6000);
			sheet.setColumnWidth(17, 7000);
			sheet.setColumnWidth(18, 7000);
			sheet.setColumnWidth(19, 7000);
			HSSFCellStyle cellStyle = workBook.createCellStyle();
			cellStyle.setAlignment(HorizontalAlignment.CENTER); // 居中

			HSSFFont font = workBook.createFont();
			font.setFontHeightInPoints((short) 12);//设置字体大小
			//设置单元格的行高
			row.setHeight((short) 500);


			/*
			 * --------------------------------------------------------------------------先存放### PROFILES ###的内容
			 * */

			/*
			 * 设置表格最上面的表头
			 */
			if(a1){
				for(int q = 0; q < 1; q++){
					//设置首行内容
					row = sheet.createRow(rowCount);
					HSSFCell cell=row.createCell(0);
					cell.setCellValue(excelName1);//设置单元格内容
				}
				rowCount++;

				//标题行 第一行
				row = sheet.createRow(rowCount);
				for(int j = 0;j<chinaNames1.length;j++) {
					HSSFCell cell=row.createCell(j);
					cell.setCellValue(chinaNames1[j]);//设置中文标题
				}
				rowCount++;
				for(int index = startIndex1;index<endIndex1;index++) {
					ProfilesEntity item = data1.get(index);//获取数据的实体对象
					row = sheet.createRow(rowCount);

					for(int j = 0;j<chinaNames1.length;j++) {
						//通过map中的字段名（英文名）反射获取该字段的值
						Field field = item.getClass().getDeclaredField(fieldNames1[j]);
						field.setAccessible(true);
						Object o = field.get(item);
						String value = o == null?"":o.toString();//通过反射取值
						HSSFCell cell=row.createCell(j);
						cell.setCellValue(value);//设置单元格内容
					}
					rowCount++;
				}
			}


			/*
			* -------------------------------------------------------------------------存放### AUTOFILL RULES ###的值
			* */
			/*
			 * 根据需求单独设置表格中的一行内容
			 */
				if(b){
					if(a2){
						rowCount = rowCount+4;
					}
					for(int q = 0; q < 1; q++){
						//设置首行内容
						row = sheet.createRow(rowCount);
						HSSFCell cell=row.createCell(0);
						cell.setCellValue(excelName2);//设置单元格内容
					}
					rowCount++;

					//标题行 第一行
					row = sheet.createRow(rowCount);
					for(int j = 0;j<chinaNames2.length;j++) {
						HSSFCell cell=row.createCell(j);
						cell.setCellValue(chinaNames2[j]);//设置中文标题
					}
					rowCount++;
					for(int index = startIndex2;index<endIndex2;index++) {
						AutofillRulesEntity item = data2.get(index);//获取数据的实体对象
						row = sheet.createRow(rowCount);

						for(int j = 0;j<chinaNames2.length;j++) {
							//通过map中的字段名（英文名）反射获取该字段的值
							Field field = item.getClass().getDeclaredField(fieldNames2[j]);
							field.setAccessible(true);
							Object o = field.get(item);
							String value = o == null?"":o.toString();//通过反射取值
							HSSFCell cell=row.createCell(j);
							cell.setCellValue(value);//设置单元格内容
						}
						rowCount++;
					}
				}


			}
		workBook.write(out);
		out.close();
		
	}

	/*
	* 参数说明：
	* file：excel文件
	* isExistTitle:是否存在表头
	* titleZHToUSMap:表头如果是中文，对应的英文名称(按照文件的实际表头顺序）
	*
	*
	* */

	public static List<Map> getExcelData(MultipartFile file, boolean isExistTitle, LinkedHashMap<String,String> titleZHToUSMap) throws Exception {
		checkFile(file);
		//获得Workbook工作薄对象
		Workbook workbook = getWorkBook(file);
		//创建返回对象，把每行中的值作为一个数组，所有行作为一个集合返回
		List<Map> list = new ArrayList<>();
		if(workbook != null){
			for(int sheetNum = 0;sheetNum < workbook.getNumberOfSheets();sheetNum++){
				//获得当前sheet工作表
				Sheet sheet = workbook.getSheetAt(sheetNum);
				if(sheet == null){
					continue;
				}
				//获得当前sheet的开始行
				int firstRowNum  = sheet.getFirstRowNum();
				//获得当前sheet的结束行
				int lastRowNum = sheet.getLastRowNum();

				LinkedList<String> titleZHList = new LinkedList();
				//判断是否存在表头
				if(isExistTitle){
					firstRowNum = firstRowNum+1;
					for(Entry<String,String> vo:titleZHToUSMap.entrySet()){
						titleZHList.add(vo.getValue());
					}
				}

				//循环读取所有记录

				for(int rowNum = firstRowNum;rowNum <= lastRowNum;rowNum++){
					//获得当前行
					Row row = sheet.getRow(rowNum);
					if(row == null){
						continue;
					}
					//获得当前行的开始列
					int firstCellNum = row.getFirstCellNum();
					//获得当前行的列数
					int lastCellNum = row.getLastCellNum();
					//判断标题的数量和每行的列数是否一致
					if(lastCellNum > titleZHList.size()){

					}
					//循环当前行
					Map<String,String> rowMap = new HashMap();
					for(int cellNum = firstCellNum; cellNum < lastCellNum;cellNum++){
						Cell cell = row.getCell(cellNum);
						rowMap.put(titleZHList.get(cellNum-1),getCellValue(cell));
					}
					list.add(rowMap);
				}
			}
		}
		return list;
	}

	/**
	 * 检查文件
	 * @param file
	 * @throws IOException
	 */
	public static  void checkFile(MultipartFile file) throws Exception {
		//判断文件是否存在
		if(null == file){
			throw new Exception("文件不存在！");
		}
		//获得文件名
		String fileName = file.getOriginalFilename();
		//判断文件是否是excel文件
		if(!fileName.endsWith("xls") && !fileName.endsWith("xlsx")){
			throw new Exception(fileName + "不是excel文件");
		}
	}
	public static  Workbook getWorkBook(MultipartFile file) throws Exception {
		//获得文件名
		String fileName = file.getOriginalFilename();
		//创建Workbook工作薄对象，表示整个excel
		Workbook workbook = null;
		try {
			//获取excel文件的io流
			InputStream is = file.getInputStream();
			//根据文件后缀名不同(xls和xlsx)获得不同的Workbook实现类对象
			if(fileName.endsWith("xls")){
				//2003
				workbook = new HSSFWorkbook(is);
			}else if(fileName.endsWith("xlsx")){
				//2007 及2007以上
				workbook = new XSSFWorkbook(is);
			}
		} catch (IOException e) {
			e.printStackTrace();
			throw new Exception("读取excel文件异常");

		}
		return workbook;
	}

	public static String getCellValue(Cell cell){
		String cellValue = "";
		if(cell == null){
			return cellValue;
		}
		//判断数据的类型
		switch (cell.getCellType()){
			//数字
			case NUMERIC:
				cellValue = stringDateProcess(cell);
				break;
			//字符串
			case STRING:
				cellValue = String.valueOf(cell.getStringCellValue());
				break;
			//Boolean
			case BOOLEAN:
				cellValue = String.valueOf(cell.getBooleanCellValue());
				break;
			//公式
			case FORMULA:
				cellValue = String.valueOf(cell.getCellFormula());
				break;
			//空值
			case BLANK:
				cellValue = "";
				break;
			//故障
			case ERROR:
				cellValue = "非法字符";
				break;
			default:
				cellValue = "未知类型";
				break;
		}
		return cellValue;
	}

	/**
	 * 时间格式处理
	 */
	public static String stringDateProcess(Cell cell){
		String result = new String();
		if (HSSFDateUtil.isCellDateFormatted(cell)) {// 处理日期格式、时间格式
			SimpleDateFormat sdf = null;
			if (cell.getCellStyle().getDataFormat() == HSSFDataFormat.getBuiltinFormat("h:mm")) {
				sdf = new SimpleDateFormat("HH:mm");
			} else {// 日期
				sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			}
			Date date = cell.getDateCellValue();
			result = sdf.format(date);
		} else if (cell.getCellStyle().getDataFormat() == 58) {
			// 处理自定义日期格式：m月d日(通过判断单元格的格式id解决，id的值是58)
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			double value = cell.getNumericCellValue();
			Date date = org.apache.poi.ss.usermodel.DateUtil
					.getJavaDate(value);
			result = sdf.format(date);
		} else {
			double value = cell.getNumericCellValue();
			CellStyle style = cell.getCellStyle();
			DecimalFormat format = new DecimalFormat();
			String temp = style.getDataFormatString();
			// 单元格设置成常规
			if (temp.equals("General")) {
				format.applyPattern("#");
			}
			result = format.format(value);
		}

		return result;
	}


}
