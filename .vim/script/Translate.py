#! /usr/bin/python 
# -*- coding: utf-8 -*- 

import urllib2, json, sys
import unicodedata

def translate(phrase):
    # Glosbe API により、引数に与えられた単語の翻訳を取得  

    try:
        phrase=phrase.decode('utf-8')
    except UnicodeDecodeError, UnicodeEncodeError:
        phrase=phrase.decode('cp932')

    if is_japanese(phrase):
        from_lang = u"ja"# English   
        dest_lang = u"en"# Japanese 
    else:
        from_lang = u"en"# English   
        dest_lang = u"ja"# Japanese 

    url = u"https://glosbe.com/gapi/translate?from=" \
        + from_lang + u"&dest=" + dest_lang \
        + u"&format=json&phrase=" + phrase + u"&pretty=true"
    response = urllib2.urlopen(url.encode("utf-8"))
    json_data = response.read()
    json_dict = json.loads(json_data)

    return_txt = "" # これを返り値にする 
    tuc = json_dict["tuc"]# tuc: list   
    for i in range(len(tuc)):
        if u"phrase" in tuc[i].keys():
            return_txt += tuc[i]["phrase"]["text"] + ","  
    return return_txt

def is_japanese(string):
    for ch in string:
        name = unicodedata.name(ch) 
        if "CJK UNIFIED" in name \
        or "HIRAGANA" in name \
        or "KATAKANA" in name:
            return True
    return False

# Main関数 
if __name__ == '__main__':
    # コマンドライン引数を取得 (sysをimportしておく必要あり) 
    argvs = sys.argv
    argc = len(argvs)

    if argc == 2:
        # 使用法が守られていた場合、コマンドライン引数の値をphraseに代入  
        #  print(sys.argv[1])
        phrase=sys.argv[1]

    else:
        # 使い方を教える                                                 
        print "Usage: python translate.py 'word'"
        phrase = ""
    if phrase:
        phrase_jp = translate(phrase)
        if phrase_jp:# 翻訳が見つかった場合  
            print phrase_jp
        else:# 翻訳が見つからなかった場合 
            print "Not Found. "
