package com.dfmy.controller.device;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dfmy.controller.common.BaseController;
import com.dfmy.entity.ResultEntity;
import com.dfmy.entity.device.AtiDevice;
import com.dfmy.entity.device.AtiDeviceDataRecordHistory;
import com.dfmy.entity.device.AtiDeviceDataRecordHistorySearchBean;
import com.dfmy.service.device.AtiDeviceDataRecordHistoryService;

import freemarker.cache.StrongCacheStorage;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.math.BigDecimal;
import java.util.*;

@RestController
@RequestMapping("/atiDeviceDataRecordHistory")
public class AtiDeviceDataRecordHistoryController extends BaseController {

    @Autowired
    private AtiDeviceDataRecordHistoryService atiDeviceDataRecordHistoryService;

    @RequestMapping("/pageList")
    @ResponseBody
    public ResultEntity pageList(@RequestParam(value = "pageCurrent", defaultValue = "1") String pageCurrent,
                                 AtiDeviceDataRecordHistory atiDeviceDataRecordHistory) {
        ResultEntity res = new ResultEntity();
        try {
            Page<AtiDeviceDataRecordHistory> pageInfo = atiDeviceDataRecordHistoryService
                    .pageList(Integer.parseInt(pageCurrent), PAGESIZE, "uploadTime", atiDeviceDataRecordHistory);
            if (pageInfo.getTotalPages() > 0) {
                res.setData(pageInfo);
                res.setMessage(GET_SUCCESS);
                res.setSuccess(SUCCESS);
            } else {
                res.setMessage(IS_NULL);
                res.setSuccess(NULL);
            }
        } catch (Exception e) {
            e.printStackTrace();
            res.setMessage(GET_ERROR + ":" + e.getMessage());
            res.setSuccess(ERROR);
        }
        return res;
    }

    @RequestMapping("getCompareData")
    public ResultEntity getCompareData(AtiDeviceDataRecordHistorySearchBean atiDeviceDataRecordHistorySearchBean) {
        ResultEntity res = new ResultEntity();
        try {
            Integer searchType = atiDeviceDataRecordHistorySearchBean.getSearchType();
            if (searchType == null) {
                searchType = 1;
            }
            List<Map<String, String>> lineOne = new ArrayList<>();
            List<Map<String, String>> lineTwo = new ArrayList<>();
            if (searchType == 1) {
                // 说明是同一时间段 不同监测点查询
                lineOne = atiDeviceDataRecordHistoryService.findCompareDataByUploadDate(
                        atiDeviceDataRecordHistorySearchBean.getMonitorSitesOne(),
                        atiDeviceDataRecordHistorySearchBean.getSearchBeginTimeOne(),
                        atiDeviceDataRecordHistorySearchBean.getSearchEndTimeOne());
                lineTwo = atiDeviceDataRecordHistoryService.findCompareDataByUploadDate(
                        atiDeviceDataRecordHistorySearchBean.getMonitorSitesTwo(),
                        atiDeviceDataRecordHistorySearchBean.getSearchBeginTimeOne(),
                        atiDeviceDataRecordHistorySearchBean.getSearchEndTimeOne());

            } else if (searchType == 2) {
                // 说明是不同时间段 同一监测点查询
                lineOne = atiDeviceDataRecordHistoryService.findCompareDataByUploadDate(
                        atiDeviceDataRecordHistorySearchBean.getMonitorSitesOne(),
                        atiDeviceDataRecordHistorySearchBean.getSearchBeginTimeOne(),
                        atiDeviceDataRecordHistorySearchBean.getSearchEndTimeOne());
                lineTwo = atiDeviceDataRecordHistoryService.findCompareDataByUploadDate(
                        atiDeviceDataRecordHistorySearchBean.getMonitorSitesOne(),
                        atiDeviceDataRecordHistorySearchBean.getSearchBeginTimeTwo(),
                        atiDeviceDataRecordHistorySearchBean.getSearchEndTimeTwo());
            } else {
                // 说明是同一时间段 同意监测点查询
                // lineOne =
                // atiDeviceDataRecordHistoryService.findCompareDataByUploadDate(atiDeviceDataRecordHistorySearchBean.getMonitorSitesOne(),
                // atiDeviceDataRecordHistorySearchBean.getSearchBeginTimeOne(),
                // atiDeviceDataRecordHistorySearchBean.getSearchEndTimeOne());
                lineOne = atiDeviceDataRecordHistoryService.findCompareData(
                        atiDeviceDataRecordHistorySearchBean.getMonitorSitesOne(),
                        atiDeviceDataRecordHistorySearchBean.getSearchBeginTimeOne(),
                        atiDeviceDataRecordHistorySearchBean.getSearchEndTimeOne());
            }

            // 渲染数据
            Map<String, Object> result = new HashMap<>();
            Map<String, String> lineOneData = new TreeMap<>();
            Map<String, String> lineTwoData = new TreeMap<>();

            // 取数据的并集的data 防止数据断层影响渲染
            Set<String> category = new TreeSet<>();
            String slDataString = "";
            if (CollectionUtils.isNotEmpty(lineOne)) {
                for (Map<String, String> map : lineOne) {
                    /*
                     * if (map.get("groupData")!=null &&
                     * !map.get("groupData").toString().endsWith("]")) {
                     * System.out.println(map.get("groupData")); }
                     */
                    if (map.get("groupData") != null || map.get("deviceUploadData") != "") {
                        category.add(map.get("uploadTime"));
                    }
                    if (map.get("groupData") != null && map.get("isGroup").equals("1")) {
                        slDataString = map.get("groupData");
                        JSONArray jsonObject = JSONObject.parseArray(slDataString);
                        for (String str : jsonObject.toJavaList(String.class)) {
                            lineOneData.put(map.get("uploadTime"), str);
                        }
                    }
                    if (map.get("deviceUploadData") != "") {
                        lineOneData.put(map.get("uploadTime"), map.get("deviceUploadData"));
                    }
                }
            }
            if (CollectionUtils.isNotEmpty(lineTwo)) {
                for (Map<String, String> map : lineTwo) {
                    category.add(map.get("uploadTime"));
                    lineTwoData.put(map.get("uploadTime"), map.get("deviceUploadData"));
                }
            }
            result.put("category", category);
            List<Double> lineOneDataDoubleArray = new ArrayList<Double>();
            List<String> lineOneDataArray = new ArrayList<>();
            List<String> lineTwoDataArray = new ArrayList<>();
            for (String categoryItem : category) {
                if (StringUtils.isBlank(lineOneData.get(categoryItem))) {
                    lineOneDataArray.add("0");
                } else {
                    lineOneDataArray.add(lineOneData.get(categoryItem));
                }
                if (StringUtils.isBlank(lineTwoData.get(categoryItem))) {
                    lineTwoDataArray.add("0");
                } else {
                    lineTwoDataArray.add(lineTwoData.get(categoryItem));
                }
            }
            for (String string : lineOneDataArray) {
                lineOneDataDoubleArray.add(Double.parseDouble(string));
            }
            double index = 0;
            for (Double db : lineOneDataDoubleArray) {
                index += db;
            }

            // 渲染标题
            result.put("lineOneData", lineOneDataArray);
            result.put("lineTwoData", lineTwoDataArray);
            try {
                result.put("max", lineOneDataDoubleArray.size() == 0 ? "" : Collections.max(lineOneDataDoubleArray));
                result.put("min", lineOneDataDoubleArray.size() == 0 ? "" : Collections.min(lineOneDataDoubleArray));
                result.put("ava", index == 0 ? "" : index / lineOneDataDoubleArray.size());
            } catch (Exception e) {
                res.setSuccess(ERROR);
            }
            res.setData(result);
            res.setMessage(GET_SUCCESS);
            res.setSuccess(SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            res.setMessage(GET_ERROR + ":" + e.getMessage());
            res.setSuccess(ERROR);
        }
        return res;
    }

    @RequestMapping("getCompareDataNew")
    public ResultEntity getCompareDataNew(AtiDeviceDataRecordHistorySearchBean atiDeviceDataRecordHistorySearchBean) {
        ResultEntity res = new ResultEntity();
        try {
            Integer searchType = atiDeviceDataRecordHistorySearchBean.getSearchType();
            if (searchType == null) {
                searchType = 1;
            }
            List<Map<String, String>> lineOne = new ArrayList<>();
            List<Map<String, String>> lineTwo = new ArrayList<>();
            if (searchType == 1) {
                // 说明是同一时间段 不同监测点查询
                lineOne = atiDeviceDataRecordHistoryService.findCompareDataByUploadDate(
                        atiDeviceDataRecordHistorySearchBean.getMonitorSitesOne(),
                        atiDeviceDataRecordHistorySearchBean.getSearchBeginTimeOne(),
                        atiDeviceDataRecordHistorySearchBean.getSearchEndTimeOne());
                lineTwo = atiDeviceDataRecordHistoryService.findCompareDataByUploadDate(
                        atiDeviceDataRecordHistorySearchBean.getMonitorSitesTwo(),
                        atiDeviceDataRecordHistorySearchBean.getSearchBeginTimeOne(),
                        atiDeviceDataRecordHistorySearchBean.getSearchEndTimeOne());

            } else if (searchType == 2) {
                // 说明是不同时间段 同一监测点查询
                lineOne = atiDeviceDataRecordHistoryService.findCompareDataByUploadDate(
                        atiDeviceDataRecordHistorySearchBean.getMonitorSitesOne(),
                        atiDeviceDataRecordHistorySearchBean.getSearchBeginTimeOne(),
                        atiDeviceDataRecordHistorySearchBean.getSearchEndTimeOne());
                lineTwo = atiDeviceDataRecordHistoryService.findCompareDataByUploadDate(
                        atiDeviceDataRecordHistorySearchBean.getMonitorSitesOne(),
                        atiDeviceDataRecordHistorySearchBean.getSearchBeginTimeTwo(),
                        atiDeviceDataRecordHistorySearchBean.getSearchEndTimeTwo());
            } else {
                // 说明是同一时间段 同意监测点查询
                // lineOne =
                // atiDeviceDataRecordHistoryService.findCompareDataByUploadDate(atiDeviceDataRecordHistorySearchBean.getMonitorSitesOne(),
                // atiDeviceDataRecordHistorySearchBean.getSearchBeginTimeOne(),
                // atiDeviceDataRecordHistorySearchBean.getSearchEndTimeOne());
                String beginTimeNode = atiDeviceDataRecordHistorySearchBean.getSearchBeginTimeNode();
                String endTimeNode = atiDeviceDataRecordHistorySearchBean.getSearchEndTimeNode();
                String beginTimeOne = atiDeviceDataRecordHistorySearchBean.getSearchBeginTimeOne();
                String endTimeOne = atiDeviceDataRecordHistorySearchBean.getSearchEndTimeOne();

                if (StringUtils.isNotBlank(beginTimeNode)) {
                    beginTimeOne = beginTimeOne + " " + beginTimeNode;
                }
                if (StringUtils.isNotBlank(endTimeNode)) {
                    endTimeOne = endTimeOne + " " + endTimeNode;
                }
                lineOne = atiDeviceDataRecordHistoryService.findCompareData(
                        atiDeviceDataRecordHistorySearchBean.getMonitorSitesOne(), beginTimeOne, endTimeOne);
            }

            // 渲染数据
            Map<String, Object> result = new HashMap<>();
            List<String> lineOneData = new ArrayList<>();
            List<String> lineTwoData = new ArrayList<>();
            
            List<String> lineOneDataSpare = new ArrayList<>();
            List<String> lineTwoDataSpare = new ArrayList<>();


            // 取数据的并集的data 防止数据断层影响渲染
            List<String> category = new ArrayList<>();
            String slDataString = "";
            if (CollectionUtils.isNotEmpty(lineOne)) {
                for (Map<String, String> map : lineOne) {
                    /*
                     * if (map.get("groupData")!=null &&
                     * !map.get("groupData").toString().endsWith("]")) {
                     * System.out.println(map.get("groupData")); }
                     */
                    if (map.get("groupData") != null || map.get("deviceUploadData") != "") {

                    }
                    if (map.get("groupData") != null && map.get("isGroup").equals("1")) {
                        slDataString = map.get("groupData");
                        JSONArray jsonObject = JSONObject.parseArray(slDataString);
                        for (String str : jsonObject.toJavaList(String.class)) {
                            lineOneData.add(str);
                            category.add(map.get("uploadTime"));
                            if (StringUtils.isNotBlank(map.get("deviceUploadDataSpare"))) {
                            	lineOneDataSpare.add(map.get("deviceUploadDataSpare"));
                            }else{
                            	lineOneDataSpare.add("0");
                            }
                        }
                    }
                    if (map.get("deviceUploadData") != "") {
                        category.add(map.get("uploadTime"));
                        lineOneData.add(map.get("deviceUploadData"));
                        if (StringUtils.isNotBlank(map.get("deviceUploadDataSpare"))) {
                        	lineOneDataSpare.add(map.get("deviceUploadDataSpare"));
                        }else{
                        	lineOneDataSpare.add("0");
                        }
                    }
                }
            }
            if (CollectionUtils.isNotEmpty(lineTwo)) {
                for (Map<String, String> map : lineTwo) {
                    category.add(map.get("uploadTime"));
                    lineTwoData.add(map.get("deviceUploadData"));
                    if (StringUtils.isNotBlank(map.get("deviceUploadDataSpare"))) {
                    	lineTwoDataSpare.add(map.get("deviceUploadDataSpare"));
                    }else{
                    	lineTwoDataSpare.add("0");
                    }
                }
            }
            result.put("category", category);
            List<Double> lineOneDataDoubleArray = new ArrayList<Double>();
            List<String> lineOneDataArray = new ArrayList<>();
            List<String> lineTwoDataArray = new ArrayList<>();
            double index = 0;
            for (String string : lineOneData) {
                if (StringUtils.isNoneBlank(string)) {
                    lineOneDataDoubleArray.add(Double.parseDouble(string));
                    index += Double.parseDouble(string);
                }

            }


            // 渲染标题
            result.put("lineOneData", lineOneData);
            result.put("lineTwoData", lineTwoData);
            result.put("lineOneDataSpare", lineOneDataSpare);
            result.put("lineTwoDataSpare", lineTwoDataSpare);
            try {
                result.put("max", lineOneDataDoubleArray.size() == 0 ? "" : Collections.max(lineOneDataDoubleArray));
                result.put("min", lineOneDataDoubleArray.size() == 0 ? "" : Collections.min(lineOneDataDoubleArray));
                result.put("ava", index == 0 ? "" : index / lineOneDataDoubleArray.size());
            } catch (Exception e) {
                res.setSuccess(ERROR);
            }
            res.setData(result);
            res.setMessage(GET_SUCCESS);
            res.setSuccess(SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            res.setMessage(GET_ERROR + ":" + e.getMessage());
            res.setSuccess(ERROR);
        }
        return res;
    }

    @RequestMapping("getCompareFFTData")
    public ResultEntity getCompareFFTData(AtiDeviceDataRecordHistorySearchBean atiDeviceDataRecordHistorySearchBean)
            throws NullPointerException {
        ResultEntity res = new ResultEntity();
        try {
            Integer searchType = atiDeviceDataRecordHistorySearchBean.getSearchType();
            if (searchType == null) {
                searchType = 1;
            }
            List<Map<String, String>> lineOne = new ArrayList<>();
            List<Map<String, String>> lineTwo = new ArrayList<>();
            if (searchType == 1) {
                // 说明是同一时间段 不同监测点查询
                lineOne = atiDeviceDataRecordHistoryService.findCompareDataByUploadDate(
                        atiDeviceDataRecordHistorySearchBean.getMonitorSitesOne(),
                        atiDeviceDataRecordHistorySearchBean.getSearchBeginTimeOne(),
                        atiDeviceDataRecordHistorySearchBean.getSearchEndTimeOne());
                lineTwo = atiDeviceDataRecordHistoryService.findCompareDataByUploadDate(
                        atiDeviceDataRecordHistorySearchBean.getMonitorSitesTwo(),
                        atiDeviceDataRecordHistorySearchBean.getSearchBeginTimeOne(),
                        atiDeviceDataRecordHistorySearchBean.getSearchEndTimeOne());

            } else if (searchType == 2) {
                // 说明是不同时间段 同一监测点查询
                lineOne = atiDeviceDataRecordHistoryService.findCompareDataByUploadDate(
                        atiDeviceDataRecordHistorySearchBean.getMonitorSitesOne(),
                        atiDeviceDataRecordHistorySearchBean.getSearchBeginTimeOne(),
                        atiDeviceDataRecordHistorySearchBean.getSearchEndTimeOne());
                lineTwo = atiDeviceDataRecordHistoryService.findCompareDataByUploadDate(
                        atiDeviceDataRecordHistorySearchBean.getMonitorSitesOne(),
                        atiDeviceDataRecordHistorySearchBean.getSearchBeginTimeTwo(),
                        atiDeviceDataRecordHistorySearchBean.getSearchEndTimeTwo());
            } else {
                // 说明是同一时间段 同意监测点查询
                // lineOne =
                // atiDeviceDataRecordHistoryService.findCompareDataByUploadDate(atiDeviceDataRecordHistorySearchBean.getMonitorSitesOne(),
                // atiDeviceDataRecordHistorySearchBean.getSearchBeginTimeOne(),
                // atiDeviceDataRecordHistorySearchBean.getSearchEndTimeOne());
                String beginTimeNode = atiDeviceDataRecordHistorySearchBean.getSearchBeginTimeNode();
                String endTimeNode = atiDeviceDataRecordHistorySearchBean.getSearchEndTimeNode();
                String beginTimeOne = atiDeviceDataRecordHistorySearchBean.getSearchBeginTimeOne();
                String endTimeOne = atiDeviceDataRecordHistorySearchBean.getSearchEndTimeOne();

                if (StringUtils.isNotBlank(beginTimeNode)) {
                    beginTimeOne = beginTimeOne + " " + beginTimeNode;
                }
                if (StringUtils.isNotBlank(endTimeNode)) {
                    endTimeOne = endTimeOne + " " + endTimeNode;
                }
                lineOne = atiDeviceDataRecordHistoryService.findCompareData(
                        atiDeviceDataRecordHistorySearchBean.getMonitorSitesOne(), beginTimeOne, endTimeOne);
            }

            // 渲染数据
            Map<String, Object> result = new HashMap<>();
            List<String> lineOneDataShow = new ArrayList<String>();
            Map<String, String> lineTwoData = new TreeMap<>();
            // 取数据的并集的data 防止数据断层影响渲染
            List<String> category = new ArrayList<String>();
            String slDataString = "";
            if (CollectionUtils.isNotEmpty(lineOne)) {
                double initSize = 0;
                for (Map<String, String> map : lineOne) {
                    /*
                     * if (map.get("isGroup").equals("1") &&
                     * (map.get("fftSize")!=null||map.get("deviceUploadData")!=
                     * "")) { double categorySize=
                     * Double.parseDouble(map.get("sampleRate"))/Double.
                     * parseDouble(map.get("fftSize")); initSize +=
                     * categorySize; category.add(initSize+""); }
                     */
                    if (map.get("fft") != null && map.get("isGroup").equals("1")) {
                        slDataString = map.get("fft");
                        JSONArray jsonObject = JSONObject.parseArray(slDataString);
                        List<String> lineOneData = new ArrayList<String>();
                        List<String> strings = jsonObject.toJavaList(String.class);
                        for (String str : strings) {
                            if (lineOneData.size() <= 150) {
                                lineOneData.add(str);
                                if (map.get("isGroup").equals("1")
                                        && (map.get("fftSize") != null || map.get("deviceUploadData") != "")) {
                                    double categorySize = Double.parseDouble(map.get("sampleRate"))
                                            / Double.parseDouble(map.get("fftSize"));
                                    initSize += categorySize;
                                    category.add(initSize + "");
                                }
                            } else {
                                break;
                            }
                            lineOneDataShow.add(str);
                        }
                    } else if (map.get("deviceUploadData") != null
                            && StringUtils.isNoneBlank(map.get("deviceUploadData").toString())) {
                        lineOneDataShow.add(map.get("deviceUploadData"));
                    }
                }
            }
            if (CollectionUtils.isNotEmpty(lineTwo)) {
                for (Map<String, String> map : lineTwo) {
                    category.add(map.get("fftSize"));
                    lineTwoData.put(map.get("fftSize"), map.get("deviceUploadData"));
                }
            }
            result.put("category", category);
            // 渲染标题
            result.put("lineOneData", lineOneDataShow);
            result.put("lineTwoData", lineTwoData);
            res.setData(result);
            res.setMessage(GET_SUCCESS);
            res.setSuccess(SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            res.setMessage(GET_ERROR + ":" + e.getMessage());
            res.setSuccess(ERROR);
        }
        return res;
    }

    /**
     * 右侧统计-数据处理
     *
     * @return
     */
    @RequestMapping("/getHistoryStatistics")
    public ResultEntity getHistoryStatistics(String monitorSitesOne, String searchBeginTimeOne, String searchEndTimeOne,
                                             String searchTimeNode) {
        ResultEntity res = new ResultEntity();
        try {
            List<Map<String, String>> statisticsData = atiDeviceDataRecordHistoryService
                    .getHistoryStatistics(monitorSitesOne, searchBeginTimeOne, searchEndTimeOne, searchTimeNode);
            List<String> sumData = new ArrayList<>();
            List<String> rateData = new ArrayList<>();
            BigDecimal rateUploadData = BigDecimal.ZERO;
            BigDecimal sumUploadData = BigDecimal.ZERO;
            Set<String> lengthData = new TreeSet<>();
            List<Double> doublesData = new ArrayList<>();
            Double sum = 0D;
            String data = "";
            for (Map<String, String> item : statisticsData) {
                lengthData.add(item.get("uploadTime"));
                if (StringUtils.isNoneBlank(item.get("groupData"))) {
                    JSONArray jsonObject = JSONObject.parseArray(item.get("groupData"));
                    Float max = Collections.max(jsonObject.toJavaList(Float.class));
                    data = max.toString();
                } else {
                    data = item.get("uploadData");
                }

                BigDecimal itemUploadData = StringUtils.isBlank(data) ? BigDecimal.ZERO : new BigDecimal(data);
                rateUploadData = itemUploadData.subtract(sumUploadData).divide(BigDecimal.ONE);

                sumUploadData = itemUploadData;

                sumData.add(itemUploadData.toString().equals("0E-8") ? "0" : itemUploadData.toString());
                rateData.add(rateUploadData.toString().equals("0E-8") ? "0" : itemUploadData.toString());
                doublesData.add(itemUploadData.doubleValue());
                sum += itemUploadData.doubleValue();
            }
            Map<String, Object> result = new HashMap<>();
            result.put("sum", sumData);
            result.put("rate", rateData);
            result.put("max", doublesData.size() == 0 ? "" : Collections.max(doublesData));
            result.put("min", doublesData.size() == 0 ? "" : Collections.min(doublesData));
            result.put("avg", sum == 0 ? "" : sum / doublesData.size());

            result.put("legendData", lengthData);
            res.setData(result);
            res.setMessage(GET_SUCCESS);
            res.setSuccess(SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            res.setMessage(GET_ERROR + ":" + e.getMessage());
            res.setSuccess(ERROR);
        }
        return res;
    }

    @RequestMapping("getCompareDateHistory")
    public ResultEntity getCompareDateHistory(AtiDeviceDataRecordHistorySearchBean atiDeviceDataRecordHistorySearchBean) {
        ResultEntity res = new ResultEntity();
        try {

            Integer searchType = atiDeviceDataRecordHistorySearchBean.getSearchType();
            if (searchType == null) {
                searchType = 1;
            }

            List<Map<String, String>> searchResult = new ArrayList<>();
            String[] monitorSiteArray = atiDeviceDataRecordHistorySearchBean.getMonitorSites().split(",");


            if (searchType == 2) {
                //说明是不同时间段 同一监测点查询
                List<Map<String, String>> lineOne = atiDeviceDataRecordHistoryService.findCompareDataByUploadDate(atiDeviceDataRecordHistorySearchBean.getMonitorSites(), atiDeviceDataRecordHistorySearchBean.getSearchBeginTimeOne(), atiDeviceDataRecordHistorySearchBean.getSearchEndTimeOne());
                List<Map<String, String>> lineTwo = atiDeviceDataRecordHistoryService.findCompareDataByUploadDate(atiDeviceDataRecordHistorySearchBean.getMonitorSites(), atiDeviceDataRecordHistorySearchBean.getSearchBeginTimeTwo(), atiDeviceDataRecordHistorySearchBean.getSearchEndTimeTwo());

                if (CollectionUtils.isNotEmpty(lineOne)) {
                    TreeMap lineItem = new TreeMap();
                    for (Map<String, String> item : lineOne) {
                        lineItem.put(item.get("uploadTime"), item.get("deviceUploadData"));
                        lineItem.put("name", atiDeviceDataRecordHistorySearchBean.getSearchBeginTimeOne() + "-" + atiDeviceDataRecordHistorySearchBean.getSearchEndTimeOne());
                        if (StringUtils.isNotBlank(item.get("deviceUploadDataSpare"))) {
                            lineItem.put("deviceUploadDataSpare", item.get("deviceUploadDataSpare"));
                        }
                    }
                    searchResult.add(lineItem);
                }
                if (CollectionUtils.isNotEmpty(lineTwo)) {
                    TreeMap lineItem = new TreeMap();
                    for (Map<String, String> item : lineTwo) {
                        lineItem.put(item.get("uploadTime"), item.get("deviceUploadData"));
                        lineItem.put("name", atiDeviceDataRecordHistorySearchBean.getSearchBeginTimeTwo() + "-" + atiDeviceDataRecordHistorySearchBean.getSearchEndTimeTwo());
                        if (StringUtils.isNotBlank(item.get("deviceUploadDataSpare"))) {
                            lineItem.put("deviceUploadDataSpare", item.get("deviceUploadDataSpare"));
                        }
                    }
                    searchResult.add(lineItem);
                }
            } else {
                for (String site : monitorSiteArray) {
                    List<Map<String, String>> lineData = atiDeviceDataRecordHistoryService.findCompareDataByUploadDate(site, atiDeviceDataRecordHistorySearchBean.getSearchBeginTimeOne(), atiDeviceDataRecordHistorySearchBean.getSearchEndTimeOne());
                    TreeMap lineItem = new TreeMap();
                    for (Map<String, String> item : lineData) {
                        lineItem.put(item.get("uploadTime"), item.get("deviceUploadData"));
                        lineItem.put("name", item.get("monitorSitesName"));
                        if (StringUtils.isNotBlank(item.get("deviceUploadDataSpare"))) {
                            lineItem.put(item.get("uploadTime") + "spare", item.get("deviceUploadDataSpare"));
                        }
                    }
                    searchResult.add(lineItem);
                }
            }

            //渲染数据
            Map<String, Object> result = new HashMap<>();

            //取数据的并集的data 防止数据断层影响渲染
            Set<String> category = new TreeSet<>();
            Set<String> excultCategory = new TreeSet<>();
            if (CollectionUtils.isNotEmpty(searchResult)) {
                for (Map<String, String> item : searchResult) {
                    category.addAll(item.keySet());
                }
                category.remove("name");
                for(String c : category){
                   if(c.contains("spare")){
                      excultCategory.add(c);
                   }
                }
            }

            result.put("category", category);

            //重新拼装数据
            List<Object> services = new ArrayList<>();
            List<String> legendString = new ArrayList<>();
            //按日期重新补齐空缺 防止数据断层而发生异常
            if (searchResult.size() > 0) {
                for (Map<String, String> itemData : searchResult) {
                    Map<String, Object> serviceData = new HashMap<>();
                    String name = "";
                    for (String date : category) {

                        if (StringUtils.isNotBlank(itemData.get("name")) && StringUtils.isBlank(name)) {
                            name = itemData.get("name");
                            legendString.add(name + "-1/x");
                            legendString.add(name + "-2/y");
                        }
                        if (StringUtils.isBlank(itemData.get(date))) {
                            itemData.put(date, "0");//数据补齐
                        }
                        if (StringUtils.isBlank(itemData.get(date+"spare"))) {
                            itemData.put(date+"spare", "0");//数据补齐
                        }

                    }
                    category.removeAll(excultCategory);
                    List<Object> dataValues = new ArrayList<>();
                    List<Object> spareValues = new ArrayList<>();
                    for (Map.Entry<String, String> entry : itemData.entrySet()) {
                        if (entry.getKey().contains("spare")) {
                            //说明这是y轴的数据
                            spareValues.add(entry.getValue());
                        } else {
                            //原始数据
                            dataValues.add(entry.getValue());
                        }
                    }

                    itemData.remove("name");
                    if (dataValues.size() > 0) {
                        serviceData.put("data", dataValues);
                        serviceData.put("name", name + "-1/x");
                        services.add(serviceData);
                    }
                    if (spareValues.size() > 0) {
                        Map<String, Object> serviceDataSpare = new HashMap<>();
                        serviceDataSpare.put("data", spareValues);
                        serviceDataSpare.put("name", name + "-2/y");
                        services.add(serviceDataSpare);
                    }
                }
            }
            result.put("legendData", legendString);
            result.put("services", services);
            res.setData(result);
            res.setMessage(GET_SUCCESS);
            res.setSuccess(SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            res.setMessage(GET_ERROR + ":" + e.getMessage());
            res.setSuccess(ERROR);
        }
        return res;
    }
}
