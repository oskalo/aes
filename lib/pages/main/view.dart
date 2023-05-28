import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

import 'bloc.dart';
import 'event.dart';
import 'state.dart';

class MainPage extends StatelessWidget {
  final TextEditingController valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainBloc>(
        create: (BuildContext context) => MainBloc(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Генератор EAS ключів'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child:
                  BlocBuilder<MainBloc, MainState>(builder: (context, state) {
                if (state is InitState) {
                  return Column(
                    children: [
                      const Text('Скільки ключиків тобі потрібно?'),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 50,
                              child: TextFormField(
                                maxLines: 1,
                                controller: valueController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]"))
                                ],
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(30)),
                              ),
                              onPressed: () {
                                if (valueController.text.isEmpty) {
                                  BlocProvider.of<MainBloc>(context)
                                      .add(EmptyAmountEvent("Я не можу згенерувати 0 ключиків, дай мені кількість від 1 до 100"));
                                  return;
                                }

                                var value = int.parse(valueController.text);
                                if (value < 1 || value > 100) {
                                  BlocProvider.of<MainBloc>(context)
                                      .add(EmptyAmountEvent("Вибачай, але потрібна кількість від 1 до 100"));
                                  return;
                                }

                                BlocProvider.of<MainBloc>(context)
                                    .add(GetKeysEvent(value));
                              },
                              child: const Text('Згенерувати'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }

                if (state is EmptyAmountState) {
                  return Column(
                    children: [
                      const Text('Скільки ключиків тобі потрібно?'),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 50,
                              child: TextFormField(
                                maxLines: 1,
                                controller: valueController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]"))
                                ],
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(30)),
                              ),
                              onPressed: () {
                                if (valueController.text.isEmpty) {
                                  BlocProvider.of<MainBloc>(context)
                                      .add(EmptyAmountEvent("Я не можу згенерувати 0 ключиків, дай мені кількість від 1 до 100"));
                                  return;
                                }

                                var value = int.parse(valueController.text);
                                if (value < 1 || value > 100) {
                                  BlocProvider.of<MainBloc>(context)
                                      .add(EmptyAmountEvent("Вибачай, але потрібна кількість від 1 до 100"));
                                  return;
                                }

                                BlocProvider.of<MainBloc>(context)
                                    .add(GetKeysEvent(value));
                              },
                              child: const Text('Згенерувати'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(state.message),
                    ],
                  );
                }

                if (state is ResultState) {
                  return Column(
                    children: [
                      const Text('Скільки ключиків тобі потрібно?'),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 50,
                              child: TextFormField(
                                maxLines: 1,
                                controller: valueController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]"))
                                ],
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(30)),
                              ),
                              onPressed: () {
                                if (valueController.text.isEmpty) {
                                  BlocProvider.of<MainBloc>(context)
                                      .add(EmptyAmountEvent("Я не можу згенерувати 0 ключиків, дай мені кількість від 1 до 100"));
                                  return;
                                }

                                var value = int.parse(valueController.text);
                                if (value < 1 || value > 100) {
                                  BlocProvider.of<MainBloc>(context)
                                      .add(EmptyAmountEvent("Вибачай, але потрібна кількість від 1 до 100"));
                                  return;
                                }

                                BlocProvider.of<MainBloc>(context)
                                    .add(GetKeysEvent(value));
                              },
                              child: const Text('Згенерувати'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.keys.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          prototypeItem: ListTile(
                            title: Text(state.keys.first),
                          ),
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Center(
                                  child: ElemKey(state.keys[index], index)),
                            );
                          },
                        ),
                      )
                    ],
                  );
                }

                return TextField(
                    readOnly: true,
                    textAlign: TextAlign.center,
                    controller: TextEditingController()..text = "Помилка. Щось, десь пішло не за планом, пиши в телегу @oleh_sk_uk"
                    );
              }),
            ),
          ),
        ));
  }
}

class ElemKey extends StatelessWidget {
  String bodyKey;
  bool flag = true;
  int keyNum;

  ElemKey(this.bodyKey, this.keyNum);

  @override
  Widget build(BuildContext context) {
    keyNum++;
    return Center(
      child: BlocProvider<ElemBloc>(
          create: (BuildContext context) => ElemBloc(),
          child: BlocBuilder<ElemBloc, ElemState>(builder: (context, state) {
            if (flag) {
              BlocProvider.of<ElemBloc>(context).add(InitElemEvent());
            }
            if (state is InitElemState) {
              return Card(
                color: Colors.white,
                elevation: 0,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          keyNum.toString(),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: TextFormField(
                          readOnly: true,
                          textAlign: TextAlign.center,
                          controller: TextEditingController()..text = bodyKey
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            flag = false;
                            await Clipboard.setData(
                                ClipboardData(text: bodyKey));
                            BlocProvider.of<ElemBloc>(context)
                                .add(CopyElemEvent());
                          },
                          child: const Text('Копіювати'),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is CopyElemState) {
              return Card(
                color: Colors.redAccent,
                elevation: 0,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          keyNum.toString(),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: TextFormField(
                          readOnly: true,
                          textAlign: TextAlign.center,
                          controller: TextEditingController()..text = bodyKey
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            flag = false;
                            await Clipboard.setData(
                                ClipboardData(text: bodyKey));
                            BlocProvider.of<ElemBloc>(context)
                                .add(CopyElemEvent());
                          },
                          child: const Text('Копіювати'),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Text('ERROR');
            }
          })),
    );
  }
}
