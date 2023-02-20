import MeCab

def lambda_handler(event, context):
    sentence = event['sentence']
    tagger = MeCab.Tagger('-Owakati -r/dev/null -d/opt/python/ipadic/dicdir')
    parsed_sentence = tagger.parse(sentence).strip().split()
    return {'result': parsed_sentence}
