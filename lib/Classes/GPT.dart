import 'report.dart';
import 'package:dart_openai/openai.dart';

class GPT {
  static String model = 'gpt-3.5-turbo';
  static String api = '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'; //Temporary, this is VERY unsecure
  static String org = 'org-3fvE6YelSgjOcRvPyHsw2bua'; //Also temp, also unsecure

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

    // final chat = await OpenAI.instance.completion.create(
    //     model: model,
    //     prompt: "What advice would you give me if I said '${curReport?.response}' when asked the question '${curReport?.question}'?",
    // );

    // final chat = await OpenAI.instance.chat.create(
    //     model: 'gpt-3.5-turbo',
    //     messages:[
    //       OpenAIChatCompletionChoiceMessageModel(
    //           role: "User",
    //           content:  "What advice would you give me if I said '${curReport.response}' when asked the question '${curReport.question}'?"
    //       )
    //     ]
    // );
  }
}