package com.dfmy.tool.other;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

/**
 * 四则运算工具类
 * 
 * @author wang
 *
 */
public class FormulaCalculatorUtil {

	private static boolean isRightFormat = true;

	public static double getResult(String formula) {
		double returnValue = 0;
		try {
			returnValue = doAnalysis(formula);
		} catch (NumberFormatException nfe) {
			System.out.println("公式格式有误，请检查:" + formula);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (!isRightFormat) {
			System.out.println("公式格式有误，请检查:" + formula);
		}
		return returnValue;
	}

	private static double doAnalysis(String formula) {
		double returnValue = 0;
		LinkedList<Integer> stack = new LinkedList<Integer>();
		int curPos = 0;
		String beforePart = "";
		String afterPart = "";
		String calculator = "";
		isRightFormat = true;
		while (isRightFormat
				&& (formula.indexOf('(') >= 0 || formula.indexOf(')') >= 0)) {
			curPos = 0;
			for (char s : formula.toCharArray()) {
				if (s == '(') {
					stack.add(curPos);
				} else if (s == ')') {
					if (stack.size() > 0) {
						beforePart = formula.substring(0, stack.getLast());
						afterPart = formula.substring(curPos + 1);
						calculator = formula.substring(stack.getLast() + 1,
								curPos);
						formula = beforePart + doCalculation(calculator)
								+ afterPart;
						stack.clear();
						break;
					} else {
						System.out.println("有未关闭的右括号！");
						isRightFormat = false;
					}
				}
				curPos++;
			}
			if (stack.size() > 0) {
				System.out.println("有未关闭的左括号！");
				break;
			}
		}
		if (isRightFormat) {
			returnValue = doCalculation(formula);
		}
		return returnValue;
	}

	private static double doCalculation(String formula) {
		ArrayList<Double> values = new ArrayList<Double>();
		ArrayList<String> operators = new ArrayList<String>();
		int curPos = 0;
		int prePos = 0;
		int minus = 0;
		for (char s : formula.toCharArray()) {
			if ((s == '+' || s == '-' || s == '*' || s == '/') && minus != 0
					&& minus != 2) {
				values.add(Double.parseDouble(formula.substring(prePos, curPos)
						.trim()));
				operators.add("" + s);
				prePos = curPos + 1;
				minus = minus + 1;
			} else {
				minus = 1;
			}
			curPos++;
		}
		values.add(Double.parseDouble(formula.substring(prePos).trim()));
		char op;
		for (curPos = 0; curPos <= operators.size() - 1; curPos++) {
			op = operators.get(curPos).charAt(0);
			switch (op) {
			case '*':
				values.add(curPos, values.get(curPos) * values.get(curPos + 1));
				values.remove(curPos + 1);
				values.remove(curPos + 1);
				operators.remove(curPos);
				curPos = -1;
				break;
			case '/':
				values.add(curPos, values.get(curPos) / values.get(curPos + 1));
				values.remove(curPos + 1);
				values.remove(curPos + 1);
				operators.remove(curPos);
				curPos = -1;
				break;
			}
		}
		for (curPos = 0; curPos <= operators.size() - 1; curPos++) {
			op = operators.get(curPos).charAt(0);
			switch (op) {
			case '+':
				values.add(curPos, values.get(curPos) + values.get(curPos + 1));
				values.remove(curPos + 1);
				values.remove(curPos + 1);
				operators.remove(curPos);
				curPos = -1;
				break;
			case '-':
				values.add(curPos, values.get(curPos) - values.get(curPos + 1));
				values.remove(curPos + 1);
				values.remove(curPos + 1);
				operators.remove(curPos);
				curPos = -1;
				break;
			}
		}
		return values.get(0).doubleValue();
	}
	/** 
	     * 提取中括号中内容，忽略中括号中的中括号 
	    * @param msg 
	     * @return 
	     */  
	   public static List<String> extractMessage(String msg) {  
	
	       List<String> list = new ArrayList<String>();  
	       int start = 0;  
	       int startFlag = 0;  
	        int endFlag = 0;  
	       for (int i = 0; i < msg.length(); i++) {  
	            if (msg.charAt(i) == '[') {  
	                startFlag++;  
	              if (startFlag == endFlag + 1) {  
	                 start = i;  
	               }  
	          } else if (msg.charAt(i) == ']') {  
	               endFlag++;  
	                if (endFlag == startFlag) {  
	                    list.add(msg.substring(start + 1, i));  
	                }  
	           }  
	       }  
	      return list;  
	   }  

	public static void main(String[] args) {
		
		String formula="(#04003011#+#04003010#)";//(String)objectMetaInfo.get("FORMULA");
	 List vars=	FormulaCalculatorUtil.extractMessage(formula);
		for (int i = 0; i < vars.size(); i++) {
			//System.out.println(vars.get(i));
		}
		
	/*	System.out.println(FormulaCalculatorUtil.getResult("3-(4*5)+5"));
		System.out.println(FormulaCalculatorUtil.getResult("(100+200)/100"));
		System.out.println(FormulaCalculatorUtil.getResult("1287763200000-1276272000000") / (3600 * 24 * 1000));
*/	
		}

}
