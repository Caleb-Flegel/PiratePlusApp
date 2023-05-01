import 'report.dart';
import 'package:dart_openai/openai.dart';
import 'package:pirate_plus/Secret/secret.dart';

class GPT {
  static String model = 'gpt-3.5-turbo';
  static String api = apiCode;
  static String org = orgCode;

  GPT () {
    OpenAI.apiKey = api;
    OpenAI.organization = org;
  }

  Future<String> getResponse (report? curReport) async {

    return await OpenAI.instance.chat.create(
        model: model,
        messages: [
          OpenAIChatCompletionChoiceMessageModel(
              role: OpenAIChatMessageRole.user,
              content: "What advice would you give me if I feel ${curReport?.emotion} and said '${curReport?.answer}' when asked the question '${curReport?.question}'?"
          )
        ]
    ).then((chat)  {
      curReport?.response = chat.choices[0].message.content;
      return chat.choices[0].message.content;
    });
  }
}