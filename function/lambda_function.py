import MeCab
import os
import ctypes

mecabdir = os.path.join(os.getcwd(), '/var/task/.mecab')
libmecab = ctypes.cdll.LoadLibrary(os.path.join(mecabdir, 'lib/libmecab.so'))

output_format_type = 'wakati'
dicdir = os.path.join(mecabdir, 'lib/mecab/dic/ipadic')
rcfile = os.path.join(mecabdir, 'etc/mecabrc')

def lambda_handler(event, context):
    sentence = event['sentence']
    tagger = MeCab.Tagger('-O{} -d{} -r{}'.format(output_format_type, dicdir, rcfile))
    parsed_sentence = tagger.parse(sentence).strip().split()
    return {'result': parsed_sentence}
