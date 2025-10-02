package com.redtourism.util;

import com.github.houbb.sensitive.word.bs.SensitiveWordBs;
import org.springframework.stereotype.Component;
import java.util.List;

@Component
public class SensitiveWordFilter {
    private final SensitiveWordBs sensitiveWordBs;

    public SensitiveWordFilter() {
        this.sensitiveWordBs = SensitiveWordBs.newInstance()
                .ignoreCase(true)
                .ignoreWidth(true)
                .ignoreNumStyle(true)
                .ignoreChineseStyle(true)
                .ignoreEnglishStyle(true)
                .enableWordCheck(true)
                .ignoreRepeat(false)
                .enableNumCheck(true)
                .enableEmailCheck(true)
                .enableUrlCheck(true)
                .init();
    }

    public boolean contains(String text) {
        return sensitiveWordBs.contains(text);
    }

    public List<String> findAll(String text) {
        return sensitiveWordBs.findAll(text);
    }

    public String replace(String text) {
        return sensitiveWordBs.replace(text);
    }

}