import json
import MeCab

tagger = MeCab.Tagger(
    '-O wakati '
    '-r /dev/null '
    # '-d /usr/local/lib/mecab/dic/mecab-ipadic-neologd'
)


def lambda_handler(event, context):
    node = tagger.parseToNode(event['body'])

    result = []
    while node:
        if not node.feature.startswith('BOS/EOS'):
            result.append(node.feature)
        node = node.next

    return {
        "body": json.dumps(result),
    }
