package org.orcid.core.utils.v3.identifiers;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.validator.routines.UrlValidator;
import org.orcid.core.manager.IdentifierTypeManager;
import org.orcid.core.utils.v3.identifiers.normalizers.Normalizer;
import org.orcid.core.utils.v3.identifiers.normalizers.NormalizerWithURLTransform;
import org.orcid.pojo.IdentifierType;
import org.springframework.core.annotation.AnnotationAwareOrderComparator;
import org.springframework.stereotype.Component;
import org.springframework.web.util.UriUtils;

@Component("PIDNormalizationService")
public class PIDNormalizationService {

    @Resource
    List<Normalizer> normalizers = new ArrayList<Normalizer>();

    @Resource
    IdentifierTypeManager idman;

    Map<String, LinkedList<Normalizer>> map = new HashMap<String, LinkedList<Normalizer>>();

    @PostConstruct
    public void init() {
        Collections.sort(normalizers, AnnotationAwareOrderComparator.INSTANCE);
        for (String type : idman.fetchIdentifierTypesByAPITypeName(Locale.ENGLISH).keySet()) {
            map.put(type, new LinkedList<Normalizer>());
        }
        for (Normalizer n : normalizers) {
            List<String> supported = n.canHandle();
            if (supported.isEmpty()) {
                for (String type : map.keySet())
                    map.get(type).add(n);
            } else {
                for (String type : supported) {
                    map.get(type).add(n);
                }
            }
        }
    }

    /**
     * Ensure this is the API type name, not the DB type name.
     * 
     * Will return empty strings for values that cannot be normalised (because they're not recognised)
     * Will return the original value for things that do not have a registered normalizer
     * 
     * @param type
     * @param value
     * @return
     */
    public String normalise(String apiTypeName, String value) {
        if (apiTypeName == null || value == null || !map.containsKey(apiTypeName))
            return value;
        String returnValue = value;
        for (Normalizer n : map.get(apiTypeName)) {
            returnValue = n.normalise(apiTypeName, returnValue);
        }
        return returnValue;
    }
    
    /** Creates a normalised URL if possible
     * Uses normalised identifier + prefix (if available)
     * If value is a URL will use that if no normalised value available.
     * 
     * Will return empty strings for valu, es that cannot be normalised or do not have a prefix
     * 
     * @param apiTypeName
     * @param value
     * @return
     */
    public String generateNormalisedURL(String apiTypeName, String value){
        if (apiTypeName == null)
            return value;
        String norm = value;
        
        //generate normalized value (some have additional transform here)
        for (Normalizer n : map.get(apiTypeName)) {
            if (n instanceof NormalizerWithURLTransform)
                norm = ((NormalizerWithURLTransform)n).normaliseURL(apiTypeName, norm);
            else
                norm = n.normalise(apiTypeName, norm);
        }
        
        //add the prefix
        if (!norm.isEmpty()){
            IdentifierType type = idman.fetchIdentifierTypesByAPITypeName(Locale.ENGLISH).get(apiTypeName);
            String prefix = type.getResolutionPrefix();
            if (!StringUtils.isEmpty(prefix)) {
                try {
                    String result = null;
                    if (norm.startsWith("http")) {
                        String compare = norm;
                        if (compare.toLowerCase().startsWith(prefix.toLowerCase())) {
                            result = norm;
                        } else {                                                                                      
                            Pattern pattern = Pattern.compile("^(http[s]?://www\\.|http[s]?://|www\\.)([^/]*)");
                            Matcher matcher = pattern.matcher(compare);
                            if (matcher.find()) {
                                if (prefix.equals(matcher.group(1) + matcher.group(2)) || prefix.contains(matcher.group(2))) {
                                    result = norm;
                                } else {
                                    if (norm.contains("=")) {
                                        norm = norm.replaceFirst("^(http[s]?://www\\.|http[s]?://|www\\.)([^=]*)","");                               
                                        norm = norm.substring(1);    
                                    } else {                                        
                                        norm = norm.substring(norm.lastIndexOf("/") + 1);
                                    }                                    
                                    result = prefix + norm;
                                }
                            } else {
                                result = prefix + norm;
                            }                                                                                   
                        }
                    } else {
                        result = prefix + norm;
                    }                                       
                    return URLDecoder.decode(result, "UTF-8");
                } catch (UnsupportedEncodingException e) {
                    throw new RuntimeException(e);
                }
            }
        }
        
        //if the value is a valid URL, just return that.
        UrlValidator urlValidator = new UrlValidator();
        if (urlValidator.isValid(norm)){
            return norm;
        }
        
        return "";
    }

}
