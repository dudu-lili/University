//package com.test.tools;
//
//import org.springframework.context.annotation.ComponentScan;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RestController;
//import org.apache.hadoop.hbase.client.Connection;
//
//import java.io.IOException;
//import java.util.List;
//
//@RestController
//@RequestMapping("/api")
//public class DataController {
//
//    private final ConnectionUtil connectionUtil;
//    private final DataUtil dataUtil;
//
//    public DataController(ConnectionUtil connectionUtil, DataUtil dataUtil) {
//        this.connectionUtil = connectionUtil;
//        this.dataUtil = dataUtil;
//    }
//
//    @GetMapping("/scan-all")
//    public List<String> scanAllData() {
//        Connection conn = null;
//        try {
//            conn = connectionUtil.getConn();
//            List<String> results = dataUtil.scanAll(conn, "student", null);  // 假设表名为"student"，没有命名空间
//            return results;
//        } catch (IOException e) {
//            e.printStackTrace();
//            return null;
//        } finally {
//            if (conn != null) {
//                try {
//                    connectionUtil.close(conn);
//                } catch (IOException e) {
//                    e.printStackTrace();
//                }
//            }
//        }
//    }
//}
//2
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RestController;
//import org.apache.hadoop.hbase.client.Connection;
//
//import java.io.IOException;
//import java.util.List;
//
//@RestController
//@RequestMapping("/api")
//public class DataController {
//
//    private final ConnectionUtil connectionUtil;
//    private final DataUtil dataUtil;
//
//    public DataController(ConnectionUtil connectionUtil, DataUtil dataUtil) {
//        this.connectionUtil = connectionUtil;
//        this.dataUtil = dataUtil;
//    }
//
//    @GetMapping("/scan-all")
//    public String scanAllData() {
//        Connection conn = null;
//        try {
//            conn = connectionUtil.getConn();
//            List<String> results = dataUtil.scanAll(conn, "student", null);  // 假设表名为"student"，没有命名空间
//
//            StringBuilder csvBuilder = new StringBuilder();
//            // 添加 CSV 标题行
//            csvBuilder.append("排名,中文名,英文名,标签,地址,行业,分数,办学层次,Logo\n");
//
//            for (String result : results) {
//                // 假设 result 已经是 CSV 格式的一行数据
//                csvBuilder.append(result).append("\n");
//            }
//
//            return csvBuilder.toString();
//        } catch (IOException e) {
//            e.printStackTrace();
//            return "Error: " + e.getMessage();
//        } finally {
//            if (conn != null) {
//                try {
//                    connectionUtil.close(conn);
//                } catch (IOException e) {
//                    e.printStackTrace();
//                }
//            }
//        }
//    }
//}
//package com.test.tools;
//
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RestController;
//import org.apache.hadoop.hbase.client.Connection;
//
//import java.io.IOException;
//import java.util.ArrayList;
//import java.util.List;
//import java.util.regex.Matcher;
//import java.util.regex.Pattern;
//
//@RestController
//@RequestMapping("/api")
//public class DataController {
//
//    private final ConnectionUtil connectionUtil;
//    private final DataUtil dataUtil;
//
//    public DataController(ConnectionUtil connectionUtil, DataUtil dataUtil) {
//        this.connectionUtil = connectionUtil;
//        this.dataUtil = dataUtil;
//    }
//
//    @GetMapping("/scan-all")
//    public List<String> scanAllData() {
//        Connection conn = null;
//        try {
//            conn = connectionUtil.getConn();
//            List<String> results = dataUtil.scanAll(conn, "student", null);  // 假设表名为"student"，没有命名空间
//            return extractDataToCSV(results);
//        } catch (IOException e) {
//            e.printStackTrace();
//            return null;
//        } finally {
//            if (conn != null) {
//                try {
//                    connectionUtil.close(conn);
//                } catch (IOException e) {
//                    e.printStackTrace();
//                }
//            }
//        }
//    }
//
//    // 修改方法来提取列限定符和值，并生成 CSV 格式的输出
//    private List<String> extractDataToCSV(List<String> results) {
//        List<String> csvData = new ArrayList<>();
//        Pattern pattern = Pattern.compile("列限定符：(.*?) 值：(.*)");
//        for (String line : results) {
//            Matcher matcher = pattern.matcher(line);
//            if (matcher.find()) {
//                String columnName = matcher.group(1); // 列名
//                String columnValue = matcher.group(2); // 列值
//                csvData.add(columnName + "," + columnValue);
//            }
//        }
//        return csvData;
//    }
//}
package com.test.tools;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.apache.hadoop.hbase.client.Connection;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
@CrossOrigin
@RestController
@RequestMapping("/api")
public class DataController {

    private final ConnectionUtil connectionUtil;
    private final DataUtil dataUtil;

    public DataController(ConnectionUtil connectionUtil, DataUtil dataUtil) {
        this.connectionUtil = connectionUtil;
        this.dataUtil = dataUtil;
    }
    @GetMapping("/scan-all-json")
    public String scanAllDataAsJson() {
        List<University> universities = scanAllData();
        if (universities == null) {
            return "Error: Unable to fetch data";
        }
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            return objectMapper.writeValueAsString(universities);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return "Error: " + e.getMessage();
        }
    }
    @GetMapping("/scan-all")
    public List<University> scanAllData() {
        Connection conn = null;
        try {
            conn = connectionUtil.getConn();
            List<String> results = dataUtil.scanAll(conn, "student", null);  // 假设表名为"student"，没有命名空间
            return extractDataToJson(results);
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        } finally {
            if (conn != null) {
                try {
                    connectionUtil.close(conn);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    // 修改方法来提取列限定符和值，并生成 JSON 格式的输出
    private List<University> extractDataToJson(List<String> results) {
        List<University> universities = new ArrayList<>();
        Map<String, University> universityMap = new HashMap<>();
        Pattern pattern = Pattern.compile("行：(\\d+)\\s+列族：.*?\\s+列限定符：([^\\s]+)\\s+值：(.*)");
        for (String line : results) {
            Matcher matcher = pattern.matcher(line);
            if (matcher.find()) {
                String rank = matcher.group(1);
                String columnName = matcher.group(2);
                String columnValue = matcher.group(3).trim(); // 去除可能的前后空格
                University university = universityMap.get(rank);
                if (university == null) {
                    university = new University();
                    university.setRank(rank);
                    universityMap.put(rank, university);
                    universities.add(university);
                }

                try {
                    switch (columnName) {
                        case "分数":
                            university.setScore(Double.parseDouble(columnValue));
                            break;
                        case "办学层次":
                            university.setEducationLevel(Double.parseDouble(columnValue));
                            break;
                        case "名称":
                            university.setName(columnValue);
                            break;
                        case "英文名":
                            university.setEnglishName(columnValue);
                            break;
                        case "标签":
                            university.setTags(columnValue);
                            break;
                        case "地址":
                            university.setAddress(columnValue);
                            break;
                        case "行业":
                            university.setIndustry(columnValue);
                            break;
                        case "标志":
                            university.setLogo(columnValue);
                            break;
                        // 添加缺失的逻辑
                        case "name":
                            university.setName(columnValue);
                            break;
                        case "logo":
                            university.setLogo(columnValue);
                            break;
                        // ... 其他字段处理
                        default:
                            System.out.println("Unknown column name: " + columnName);
                    }
                } catch (NumberFormatException e) {
                    System.out.println("Number format exception for rank " + rank + ", column " + columnName + ": " + e.getMessage());
                } catch (Exception e) {
                    System.out.println("Exception for rank " + rank + ", column " + columnName + ": " + e.getMessage());
                }
            } else {
                System.out.println("Line did not match pattern: " + line);
            }
        }
        return universities;
    }
}

class University {
    private String rank;
    private String name;
    private String englishName;
    private String tags;
    private String address;
    private String industry;
    private Double score;
    private Double educationLevel;
    private String logo;

    public String getRank() {
        return rank;
    }

    public void setRank(String rank) {
        this.rank = rank;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEnglishName() {
        return englishName;
    }

    public void setEnglishName(String englishName) {
        this.englishName = englishName;
    }

    public String getTags() {
        return tags;
    }

    public void setTags(String tags) {
        this.tags = tags;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getIndustry() {
        return industry;
    }

    public void setIndustry(String industry) {
        this.industry = industry;
    }

    public Double getScore() {
        return score;
    }

    public void setScore(Double score) {
        this.score = score;
    }

    public Double getEducationLevel() {
        return educationLevel;
    }

    public void setEducationLevel(Double educationLevel) {
        this.educationLevel = educationLevel;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }
}