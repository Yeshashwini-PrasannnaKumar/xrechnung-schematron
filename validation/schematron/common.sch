<?xml version="1.0" encoding="UTF-8"?>
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="variable-pattern">
    <!-- This pattern solely serves for declaring global variables (in XSLT speak) -->
    
    <let name="XR-MAJOR-MINOR-VERSION" value="'2.3'"/>
    <let name="XR-CIUS-ID" value="concat('urn:cen.eu:en16931:2017#compliant#urn:xoev-de:kosit:standard:xrechnung_', $XR-MAJOR-MINOR-VERSION )"/>
    <let name="XR-EXTENSION-ID" value="concat($XR-CIUS-ID, '#conformant#urn:xoev-de:kosit:extension:xrechnung_' ,$XR-MAJOR-MINOR-VERSION )"/>
    <let name="XR-SKONTO-REGEX"  value="'#(SKONTO|VERZUG)#TAGE=([0-9]+#PROZENT=[0-9]+\.[0-9]{2})(#BASISBETRAG=-?[0-9]+\.[0-9]{2})?#$'" />
    <!-- 
    <let name="XR-EMAIL-REGEX"  value="'^[0-9a-zA-Z]([0-9a-zA-Z\.]*)[^\.\s@]@[^\.\s@]([0-9a-zA-Z\.]*)[0-9a-zA-Z]$'" />
     -->
    <let name="XR-EMAIL-REGEX"  value="'^[a-zA-Z0-9!#\$%&amp;&quot;*+/=?^_`{|}~-]+(\.[a-zA-Z0-9!#\$%&amp;&quot;*+/=?^_`{|}~-]+)*@([a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?$'" />
    
    <let name="XR-TELEPHONE-REGEX"  value="'.*([0-9].*){3,}.*'" />
    <let name="BT-81" value="'rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:TypeCode'"/>
    <let name="DIGA-CODES" value="' XR01 XR02 XR03 '" />
    <!-- ISO 6523 and EAS Codelists including XR01 XR02 XR03 (applicable to extension only) -->
    <let name="ISO-6523-ICD-CODES" value="' 0002 0003 0004 0005 0006 0007 0008 0009 0010 0011 0012 0013 0014 0015 0016 0017 0018 0019 0020 0021 0022 0023 0024 0025 0026 0027 0028 0029 0030 0031 0032 0033 0034 0035 0036 0037 0038 0039 0040 0041 0042 0043 0044 0045 0046 0047 0048 0049 0050 0051 0052 0053 0054 0055 0056 0057 0058 0059 0060 0061 0062 0063 0064 0065 0066 0067 0068 0069 0070 0071 0072 0073 0074 0075 0076 0077 0078 0079 0080 0081 0082 0083 0084 0085 0086 0087 0088 0089 0090 0091 0093 0094 0095 0096 0097 0098 0099 0100 0101 0102 0104 0105 0106 0107 0108 0109 0110 0111 0112 0113 0114 0115 0116 0117 0118 0119 0120 0121 0122 0123 0124 0125 0126 0127 0128 0129 0130 0131 0132 0133 0134 0135 0136 0137 0138 0139 0140 0141 0142 0143 0144 0145 0146 0147 0148 0149 0150 0151 0152 0153 0154 0155 0156 0157 0158 0159 0160 0161 0162 0163 0164 0165 0166 0167 0168 0169 0170 0171 0172 0173 0174 0175 0176 0177 0178 0179 0180 0183 0184 0185 0186 0187 0188 0189 0190 0191 0192 0193 0194 0195 0196 0197 0198 0199 0200 0201 0202 0203 0204 0205 0206 0207 0208 0209 0210 0211 0212 0213 0214 0215 0216 0217 0218 0219 0220 '" />
    <let name="ISO-6523-ICD-EXT-CODES" value="concat($DIGA-CODES, $ISO-6523-ICD-CODES)"/>

    <let name="CEF-EAS-CODES" value="' 0002 0007 0009 0037 0060 0088 0096 0097 0106 0130 0135 0142 0147 0151 0170 0183 0184 0188 0190 0191 0192 0193 0194 0195 0196 0198 0199 0200 0201 0202 0203 0204 0205 0208 0209 0210 0211 0212 0213 0215 0216 0217 0218 0219 0220 9901 9910 9913 9914 9915 9918 9919 9920 9922 9923 9924 9925 9926 9927 9928 9929 9930 9931 9932 9933 9934 9935 9936 9937 9938 9939 9940 9941 9942 9943 9944 9945 9946 9947 9948 9949 9950 9951 9952 9953 9955 9957 9959 AN AQ AS AU EM '" />
    <let name="CEF-EAS-EXT-CODES" value="concat($DIGA-CODES, $CEF-EAS-CODES)" />
    
    <rule abstract="true" id="IBAN-VALIDATION">
        <let name="IBAN-REGEX" value="'^[A-Z]{2}[0-9]{2}[a-zA-Z0-9]{0,30}$'"/>
        <assert test="not($PAYMENT-MEANS-TYPE-CODE = '58') or
            matches(normalize-space(replace($IBAN, '([ \n\r\t\s])', '')), $IBAN-REGEX) and
            xs:integer(string-join(for $cp in string-to-codepoints(concat(substring(normalize-space(replace($IBAN, '([ \n\r\t\s])', '')),5),upper-case(substring(normalize-space(replace($IBAN, '([ \n\r\t\s])', '')),1,2)),substring(normalize-space(replace($IBAN, '([ \n\r\t\s])', '')),3,2))) return  (if($cp > 64) then string($cp - 55) else string($cp - 48)),'')) mod 97 = 1"
            flag="warning"
            id="BR-DE-19"
            >[BR-DE-19] "Payment account identifier" (BT-84) soll eine korrekte IBAN enthalten, wenn in "Payment means type code" (BT-81) mit dem Code 58 SEPA als Zahlungsmittel gefordert wird.</assert>
        <assert test="$PAYEE-ACCOUNT"
            flag="fatal"
            id="BR-DE-23-a"
            >[BR-DE-23-a] Wenn BT-81 "Payment means type code" einen Schlüssel für Überweisungen enthält (30, 58), muss BG-17 "CREDIT TRANSFER" übermittelt werden.</assert>
        <assert test="not($CARD) and
            not($ACCOUNT)"
            flag="fatal"
            id="BR-DE-23-b"
            >[BR-DE-23-b] Wenn BT-81 "Payment means type code" einen Schlüssel für Überweisungen enthält (30, 58), dürfen BG-18 und BG-19 nicht übermittelt werden.</assert>
    </rule>

</pattern>
