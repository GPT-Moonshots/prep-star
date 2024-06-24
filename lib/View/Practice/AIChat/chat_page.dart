import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prepstar/Controller/controller.dart';
import 'package:prepstar/Service/Database/aichats.dart';
import 'package:uuid/uuid.dart';

class ChatPage extends StatefulWidget {
  final String? chatId;
  const ChatPage({super.key, this.chatId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _openAI = OpenAI.instance.build(
      token: AppController.getGPTkeyFromEnv(),
      baseOption: HttpSetup(
        receiveTimeout: const Duration(seconds: 5),
      ),
      enableLog: true);

  final ChatUser _user = ChatUser(
    id: '1',
    firstName: 'Paras',
    lastName: 'Upadhayay',
  );

  final ChatUser _gptChatUser = ChatUser(
    id: '2',
    firstName: 'Jee',
    lastName: 'Assist',
  );

  List<ChatMessage>? _messages;
  final List<ChatUser> _typingUsers = [];

  @override
  void initState() {
    if (widget.chatId != '_') {
      ManageChats.getChat(widget.chatId!).then((value) {
        setState(() {
          _messages = value;
        });
      });
    } else {
      _messages = [];
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.chatId != '_') {
      ManageChats.uploadChat(widget.chatId!, _messages!);
    } else {
      String chatId = const Uuid().v4();
      ManageChats.uploadChat(chatId, _messages!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      onDrawerChanged: (_) {
        setState(() {});
      },
      drawer: Drawer(
          child: FutureBuilder(
              future: ManageChats.getChatIDs(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                List<String> chatIDs = snapshot.data as List<String>;
                return Column(
                  children: [
                    const DrawerHeader(child: Text("Chat with AI")),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: List.generate(chatIDs.length + 1, (index) {
                          return index == 0
                              ? ListTile(
                                  title: const Text('New Chat'),
                                  onTap: () {
                                    _scaffoldKey.currentState!.openEndDrawer();
                                    context.pushReplacementNamed('AIChat',
                                        pathParameters: {
                                          'chatID': '_',
                                        });
                                  },
                                )
                              : ListTile(
                                  title: Text(
                                      'Chat ${chatIDs.length - index + 1}'),
                                  onTap: () {
                                    _scaffoldKey.currentState!.openEndDrawer();
                                    context.pushReplacementNamed('AIChat',
                                        pathParameters: {
                                          'chatID': chatIDs[index - 1],
                                        });
                                  },
                                );
                        }),
                      ),
                    ),
                  ],
                );
              })),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Ask Your Doubts Here!',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: _messages == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : DashChat(
              currentUser: _user,
              messageOptions: const MessageOptions(
                currentUserContainerColor: Colors.black,
                containerColor: Colors.blue,
                textColor: Colors.white,
              ),
              onSend: (ChatMessage m) {
                getChatResponse(m);
              },
              messages: _messages!,
              typingUsers: _typingUsers,
            ),
    );
  }

  Future<void> getChatResponse(ChatMessage m) async {
    setState(() {
      _messages!.insert(0, m);
      _typingUsers.add(_gptChatUser);
    });
    List<Map<String, dynamic>> messagesHistory =
        _messages!.reversed.toList().map((m) {
      if (m.user == _user) {
        return Messages(
                role: Role.user,
                content:
                    "ok now we are going to have a role play in which you are my Joint Entrance Examination Tutor and You will only answer JEE related question and write an apologetic message if ask anything, So my question to you is ${m.text}")
            .toJson();
      } else {
        return Messages(role: Role.assistant, content: m.text).toJson();
      }
    }).toList();
    final request = ChatCompleteText(
      messages: messagesHistory,
      maxToken: 200,
      model: GptTurbo0301ChatModel(),
    );
    final response = await _openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      if (element.message != null) {
        setState(() {
          _messages!.insert(
              0,
              ChatMessage(
                  user: _gptChatUser,
                  createdAt: DateTime.now(),
                  text: element.message!.content));
        });
      }
    }
    setState(() {
      _typingUsers.remove(_gptChatUser);
    });
  }
}
